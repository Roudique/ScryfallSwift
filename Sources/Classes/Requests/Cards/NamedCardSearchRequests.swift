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

enum FormatDecodeError: Error {
    case invalidData
}

enum FormatResponse: Decodable {
    init(from decoder: Decoder) throws {
        if let card = try? Card(from: decoder) {
            self = .card(card)
        } else if let text = try? String(from: decoder) {
            self = .text(text)
        } else if let data = try? Data(from: decoder) {
            self = .data(data)
        } else {
            throw FormatDecodeError.invalidData
        }
    }
    
    case card(Card)
    case text(String)
    case data(Data)
}

protocol FormatResponseRequest {
    var format: Format { get }
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
