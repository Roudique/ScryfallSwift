//
//  AutocompleteRequest.swift
//  ScryfallSwift
//
//  Created by Roudique on 10/23/18.
//

import Foundation


struct AutocompleteRequest: APIRequest {
    var resourceName: String {
        get {
            return "/cards/autocomplete"
        }
    }
    
    typealias Response = Catalog
    
    let cardName: String
}
extension AutocompleteRequest: QueryableAPIRequest {
    var queryItems: [String : String] {
        get {
            return ["q": self.cardName]
        }
    }
}
