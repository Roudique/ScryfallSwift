//
//  CardsRequests.swift
//  ScryfallSwift
//
//  Created by Roudique on 10/14/18.
//

import Foundation


struct AllCardsRequest: APIRequest {
    typealias Response = List<Card>
    
    var resourceName: String {
        get {
            return "/cards"
        }
    }
}


struct FulltextCardSearchRequest: APIRequest {
    typealias Response = List<Card>
    
    let search: String
    
    /// The strategy for omitting similar cards.
    ///
    /// - cards: Default. Removes duplicate gameplay objects (cards that share a name and have the same functionality). For example, if your search matches more than one print of Pacifism, only one copy of Pacifism will be returned.
    /// - art: Returns only one copy of each unique artwork for matching cards. For example, if your search matches more than one print of Pacifism, one card with each different illustration for Pacifism will be returned, but any cards that duplicate artwork already in the results will be omitted.
    /// - print: Returns all prints for all cards matched (disables rollup). For example, if your search matches more than one print of Pacifism, all matching prints will be returned.
    enum CardSearchUniqueness: String, Decodable {
        case cards
        case art
        case prints
    }
    var unique: CardSearchUniqueness?
    
    
    /// The method to sort returned cards.
    ///
    /// - name: Default. Sort cards by name, A → Z
    /// - set: Sort cards by their set and collector number: AAA/#1 → ZZZ/#999
    /// - released: Sort cards by their release date: Newest → Oldest
    /// - rarity: Sort cards by their rarity: Common → Mythic
    /// - color: Sort cards by their color and color identity: WUBRG → multicolor → colorless
    /// - usd: Sort cards by their lowest known U.S. Dollar price: 0.01 → highest, null last
    /// - tix: Sort cards by their lowest known TIX price: 0.01 → highest, null last
    /// - eur: Sort cards by their lowest known Euro price: 0.01 → highest, null last
    /// - cmc: Sort cards by their converted mana cost: 0 → highest
    /// - power: Sort cards by their power: null → highest
    /// - toughness: Sort cards by their toughness: null → highest
    /// - edhrec: Sort cards by their EDHREC ranking: lowest → highest
    /// - artist: Sort cards by their front-side artist name: A → Z*/
    enum CardSearchOrder: String, Decodable {
        case name
        case set
        case released
        case rarity
        case color
        case usd
        case tix
        case eur
        case cmc
        case power
        case toughness
        case edhrec
        case artist
    }
    var order: CardSearchOrder?
    
    
    /// The direction to sort cards.
    ///
    /// - auto: Scryfall will automatically choose the most inuitive direction to sort
    /// - asc: Sort ascending (the direction of the arrows in the CardSearchOrder)
    /// - desc: Sort descending (flip the direction of the arrows in the CardSearchOrder)
    enum SortDirection: String, Decodable {
        case auto
        case asc
        case desc
    }
    var sortDirection: SortDirection?
    
    var includeExtras: Bool?
    var includeMultilingual: Bool?
    
    
    var resourceName: String {
        get {
            return "/cards/search"
        }
    }
}
extension FulltextCardSearchRequest: QueryableAPIRequest {
    var queryItems: [String : String] {
        var items = ["q": search]
        
        items["unique"] = self.unique?.rawValue ?? nil
        items["order"]  = self.order?.rawValue ?? nil
        items["dir"]    = self.sortDirection?.rawValue ?? nil
        
        if let extras = self.includeExtras, extras == true {
            items["include_extras"] = "\(true)"
        }
        
        if let multilingual = self.includeMultilingual, multilingual == true {
            items["include_multilingual"] = "\(true)"
        }
        
        return items
    }
}


/// Name for a card to search for, case insensitive.
///
/// - exact: Exact card name.
/// - fuzzy: Fuzzy card name.
enum Name {
    case exact(String)
    case fuzzy(String)
}


struct NamedCardSearchRequest: APIRequest {
    var resourceName: String {
        get {
            return privateRequest.resourceName
        }
    }
    
    typealias Response = Card
    
    let format = Format.json
    
    private var privateRequest: NamedSearchRequest
    
    init(name: Name, setCode: String?) {
        self.privateRequest = NamedSearchRequest.init(name: name, setCode: setCode, format: self.format)
    }
}
extension NamedCardSearchRequest: QueryableAPIRequest {
    var queryItems: [String : String] {
        get {
            return self.privateRequest.queryItems
        }
    }
}


struct NamedTextCardSearchRequest: APIRequest {
    var resourceName: String {
        get {
            return privateRequest.resourceName
        }
    }
    typealias Response  = String
    let format          = Format.text
    private var privateRequest: NamedSearchRequest
    
    init(name: Name, setCode: String?) {
        self.privateRequest = NamedSearchRequest.init(name: name, setCode: setCode, format: self.format)
    }
}
extension NamedTextCardSearchRequest: QueryableAPIRequest {
    var queryItems: [String : String] {
        get {
            return privateRequest.queryItems
        }
    }
}


struct NamedImageCardSearchRequest: APIRequest {
    var resourceName: String {
        get {
            return self.privateRequest.resourceName
        }
    }
    typealias Response  = Data
    private var privateRequest: NamedSearchRequest

    init(name: Name, setCode: String?, format: Format?) {
        self.privateRequest = NamedSearchRequest.init(name: name, setCode: setCode, format: format)
    }
}
extension NamedImageCardSearchRequest: QueryableAPIRequest {
    var queryItems: [String: String] {
        get {
            return privateRequest.queryItems
        }
    }
}


private struct NamedSearchRequest {
    
    var resourceName: String {
        get {
            return "/cards/named"
        }
    }
    
    /// Name for a card to search for, case insensitive.
    var name: Name
    
    /// A set code to limit the search to one set.
    var setCode: String?
    
    /// The data format to return: json, text, or image. Defaults to json.
    var format: Format?
}
extension NamedSearchRequest: QueryableAPIRequest {
    var queryItems: [String: String] {
        get {
            var items = [String: String]()
            
            var name: (String, String)
            switch self.name {
            case .exact(let exact):
                name = ("exact", exact)
            case .fuzzy(let fuzzy):
                name = ("fuzzy", fuzzy)
            }
            items[name.0] = name.1
            
            items["set"] = self.setCode ?? nil
            
            guard let format = self.format else { return items }
            switch format {
            case .image(let config):
                items["face"] = config.isBackFace ? "back" : nil
                items["version"] = config.version.stringValue
            default:
                break
            }
            items["format"] = format.stringRepresentation()
            
            return items
        }
    }
}

