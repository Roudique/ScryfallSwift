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
struct NamedCardSearchRequest: APIRequest, FormatResponseRequest {
    var resourceName: String {
        return "/cards/named"
    }
    
    typealias Response = FormatResponse
    
    let format: Format
    let name: Name
    let setCode: String?
}

extension NamedCardSearchRequest: QueryableAPIRequest {
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
        
        if case let Format.image(imageConfig) = format {
            var formatQueryItems = [String: String]()
            formatQueryItems["face"] = imageConfig.isBackFace ? "back" : nil
            formatQueryItems["version"] = imageConfig.version.stringValue
            items.merge(formatQueryItems) { str1, str2 in
                return str1
            }
        }

        items["format"] = format.stringRepresentation()
        
        return items
    }
}
