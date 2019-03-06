//
//  NamedCardSearchRequests.swift
//  ScryfallSwift
//
//  Created by Roudique on 3/5/19.
//

import Foundation


/// Name for a card to search for, case insensitive.
///
/// - exact: Exact card name.
/// - fuzzy: Fuzzy card name.
enum Name {
    case exact(String)
    case fuzzy(String)
}

// MARK: -
struct NamedCardSearchRequest: APIRequest {
    var resourceName: String {
        return privateRequest.resourceName
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
        return self.privateRequest.queryItems
    }
}


// MARK: -
struct NamedTextCardSearchRequest: APIRequest {
    var resourceName: String {
        return privateRequest.resourceName
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
        return privateRequest.queryItems
    }
}


// MARK: -
struct NamedImageCardSearchRequest: APIRequest {
    var resourceName: String {
        return self.privateRequest.resourceName
    }
    typealias Response  = Data
    private var privateRequest: NamedSearchRequest
    
    init(name: Name, setCode: String?, config: ImageConfig) {
        self.privateRequest = NamedSearchRequest.init(name: name, setCode: setCode, format: Format.image(config))
    }
}
extension NamedImageCardSearchRequest: QueryableAPIRequest {
    var queryItems: [String: String] {
        return privateRequest.queryItems
    }
}


// MARK: -
private struct NamedSearchRequest {
    
    var resourceName: String {
        return "/cards/named"
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
        
        items.merge(format.queryItems) { str1, str2 in
            return str1
        }
        
        return items
    }
}

