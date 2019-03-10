//
//  IdentityCardRequest.swift
//  ScryfallSwift
//
//  Created by Roudique on 3/9/19.
//

import Foundation


enum Identifier {
    case setCodeCollectorNumberAndLang(String, Int, String?)
    case multiverse(Int)
    case mtgo(Int)
    case arena(Int)
    case tcgplayer(Int)
    case scryfall(String)
}


struct IdentityCardRequest: APIRequest, FormatResponseRequest {
    var resourceName: String {
        return identifier.resourceName
    }
    
    typealias Response = FormatResponse
    
    let identifier: Identifier
    let format: Format
}
extension IdentityCardRequest: QueryableAPIRequest {
    var queryItems: [String : String] {
        return format.queryItems
    }
}


private extension Identifier {
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
