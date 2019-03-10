//
//  RulingsRequest.swift
//  ScryfallSwift
//
//  Created by Roudique on 3/9/19.
//

import Foundation


struct RulingsRequest: APIRequest {
    typealias Response = List<CardRuling>
    
    var resourceName: String {
        return identifier.resourceName
    }
    
    let identifier: SearchIdentifier
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

