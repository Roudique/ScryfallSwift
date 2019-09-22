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
public enum Name {
    case exact(String)
    case fuzzy(String)
}

// MARK: -
public struct NamedCardSearchRequest: APIRequest, FormatResponseRequest {
    public var resourceName: String {
        return "/cards/named"
    }
    
    public typealias Response = FormatResponse
    
    public let format: Format
    public let name: Name
    public let setCode: String?
    
    public init(format: Format, name: Name, setCode: String?) {
        self.format = format
        self.name = name
        self.setCode = setCode
    }
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
