//
//  CardsRequests.swift
//  ScryfallSwift
//
//  Created by Roudique on 10/14/18.
//

import Foundation


public struct FulltextCardSearchRequest: APIRequest, FormatResponseRequest {
    public typealias Response = List<Card>
    
    public let search: String
    
    public var format: Format

    /// The strategy for omitting similar cards.
    ///
    /// - cards: Default. Removes duplicate gameplay objects (cards that share a name and have the same functionality). For example, if your search matches more than one print of Pacifism, only one copy of Pacifism will be returned.
    /// - art: Returns only one copy of each unique artwork for matching cards. For example, if your search matches more than one print of Pacifism, one card with each different illustration for Pacifism will be returned, but any cards that duplicate artwork already in the results will be omitted.
    /// - print: Returns all prints for all cards matched (disables rollup). For example, if your search matches more than one print of Pacifism, all matching prints will be returned.
    public enum CardSearchUniqueness: String, Decodable {
        case cards
        case art
        case prints
    }
    public var unique: CardSearchUniqueness?
    
    
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
    public enum CardSearchOrder: String, Decodable {
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
    public var order: CardSearchOrder?
    
    
    /// The direction to sort cards.
    ///
    /// - auto: Scryfall will automatically choose the most inuitive direction to sort
    /// - asc: Sort ascending (the direction of the arrows in the CardSearchOrder)
    /// - desc: Sort descending (flip the direction of the arrows in the CardSearchOrder)
    public enum SortDirection: String, Decodable {
        case auto
        case asc
        case desc
    }
    public var sortDirection: SortDirection?
    
    public var includeExtras: Bool?
    public var includeMultilingual: Bool?
    
    public var resourceName: String {
        return "/cards/search"
    }
    
    public init(query: String,
                format: Format? = .json,
                unique: CardSearchUniqueness? = .cards,
                sortOrder: CardSearchOrder? = .name,
                sortDirection: SortDirection? = .auto,
                includeExtras: Bool? = false,
                includeMultilingual: Bool? = false) {
        self.search = query
        self.format = format ?? .json
        self.unique = unique
        self.order = sortOrder
        self.sortDirection = sortDirection
        self.includeExtras = includeExtras
        self.includeMultilingual = includeMultilingual
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
