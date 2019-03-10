//
//  CatalogRequest.swift
//  ScryfallSwift
//
//  Created by Roudique on 3/9/19.
//

import Foundation


enum CatalogType {
    case cardNames
    case artistNames
    case wordBank
    case creatureTypes
    case planeswalkerTypes
    case landTypes
    case artifactTypes
    case enchantmentTypes
    case spellTypes
    case powers
    case toughnesses
    case loyalties
    case watermarks
}


struct CatalogRequest: APIRequest {
    typealias Response = Catalog
    
    var resourceName: String {
        return type.resourceName
    }
    
    let type: CatalogType
}
private extension CatalogType {
    var resourceName: String {
        switch self {
        case .cardNames:
            return "/catalog/card-names"
        case.artistNames:
            return "/catalog/artist-names"
        case .wordBank:
            return "/catalog/word-bank"
        case .creatureTypes:
            return "/catalog/creature-types"
        case .planeswalkerTypes:
            return "/catalog/planeswalker-types"
        case .landTypes:
            return "/catalog/land-types"
        case .artifactTypes:
            return "/catalog/artifact-types"
        case .enchantmentTypes:
            return "/catalog/enchantment-types"
        case .spellTypes:
            return "/catalog/spell-types"
        case .powers:
            return "/catalog/powers"
        case .toughnesses:
            return "/catalog/toughnesses"
        case .loyalties:
            return "/catalog/loyalties"
        case .watermarks:
            return "/catalog/watermarks"
        }
    }
}
