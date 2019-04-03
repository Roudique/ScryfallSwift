//
//  RulingsRequest.swift
//  ScryfallSwift
//
//  Created by Roudique on 3/9/19.
//

import Foundation


public struct RulingsRequest: APIRequest {
    public typealias Response = List<CardRuling>
    
    public var resourceName: String {
        return identifier.resourceName
    }
    
    public let identifier: SearchIdentifier
    
    public init(identifier: SearchIdentifier) {
        self.identifier = identifier
    }
}

private extension SearchIdentifier {
    var resourceName: String {
        switch self {
        case .multiverse(let id):
            return "/cards/multiverse/\(id)/rulings"
        case .mtgo(let id):
            return "/cards/mtgo/\(id)/rulings"
        case .arena(let id):
            return "/cards/arena/\(id)/rulings"
        case .setCodeCollectorNumberAndLang(let setCode, let collectorNumber, _):
            return "/cards/\(setCode)/\(collectorNumber)/rulings"
        case .scryfall(let id):
            return "/cards/\(id)/rulings"
        default:
            return ""
        }
    }
}

