//
//  SetRequest.swift
//  ScryfallSwift
//
//  Created by Roudique on 3/9/19.
//

import Foundation


enum SetIdentifier {
    case code(String)
    case tcgplayerID(Int)
    case scryfallID(String)
}


struct SetRequest: APIRequest {
    typealias Response = CardSet
    
    let identifier: SetIdentifier
    
    var resourceName: String {
        return identifier.resourceName
    }
}


extension SetIdentifier {
    var resourceName: String {
        switch self {
        case .code(let code):
            return "/sets/\(code)"
        case .tcgplayerID(let id):
            return "/sets/tcgplayer/\(id)"
        case .scryfallID(let id):
            return "/sets/\(id)"
        }
    }
}
