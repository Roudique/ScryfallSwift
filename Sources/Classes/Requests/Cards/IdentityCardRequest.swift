//
//  IdentityCardRequest.swift
//  ScryfallSwift
//
//  Created by Roudique on 3/9/19.
//

import Foundation


public struct IdentityCardRequest: APIRequest, FormatResponseRequest {
    public var resourceName: String {
        return identifier.resourceName
    }
    
    public typealias Response = FormatResponse
    
    public let identifier: SearchIdentifier
    public let format: Format
    
    public init(identifier: SearchIdentifier, format: Format) {
        self.identifier = identifier
        self.format = format
    }
}

extension IdentityCardRequest: QueryableAPIRequest {
    var queryItems: [String : String] {
        return format.queryItems
    }
}

private extension SearchIdentifier {
    var resourceName: String {
        switch self {
        case .setCodeCollectorNumberAndLang(let setCode, let collectorNumber, let lang):
            var resourceName =  "/cards/\(setCode)/\(collectorNumber)"
            if let lang = lang {
                resourceName += "/\(lang)"
            }
            return resourceName
        case .multiverse(let id):
            return "/cards/multiverse/\(id)"
        case .mtgo(let id):
            return "/cards/mtgo/\(id)"
        case .arena(let id):
            return "/cards/arena/\(id)"
        case .tcgplayer(let id):
            return "/cards/tcgplayer/\(id)"
        case .scryfall(let id):
            return "/cards/\(id)"
        }
    }
}
