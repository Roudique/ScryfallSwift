//
//  AutocompleteRequest.swift
//  ScryfallSwift
//
//  Created by Roudique on 10/23/18.
//

import Foundation


public struct AutocompleteRequest: APIRequest {
    public var resourceName: String {
        return "/cards/autocomplete"
    }
    
    public typealias Response = Catalog
    
    public let cardName: String
    
    public init(cardName: String) {
        self.cardName = cardName
    }
}
extension AutocompleteRequest: QueryableAPIRequest {
    public var queryItems: [String : String] {
        return ["q": self.cardName]
    }
}
