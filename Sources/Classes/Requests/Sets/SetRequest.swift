//
//  SetRequest.swift
//  ScryfallSwift
//
//  Created by Roudique on 3/9/19.
//

import Foundation


public enum SetIdentifier {
    case code(String)
    case tcgplayerID(Int)
    case scryfallID(String)
}


public struct SetRequest: APIRequest {
    public typealias Response = CardSet
    
    public let identifier: SetIdentifier

    public var resourceName: String {
        return identifier.resourceName
    }
    
    public init(identifier: SetIdentifier) {
        self.identifier = identifier
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
