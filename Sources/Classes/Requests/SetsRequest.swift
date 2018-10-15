//
//  SetsRequest.swift
//  ScryfallSwift
//
//  Created by Roudique on 10/14/18.
//

import Foundation

struct AllSetsRequest: APIRequest {
    typealias Response = List<CardSet>
    
    var resourceName: String {
        get {
            return "/sets"
        }
    }
}

struct SetRequest: APIRequest {
    typealias Response = CardSet
    
    let setCode: String
    
    var resourceName: String {
        get {
            return "/sets/\(self.setCode)"
        }
    }
}
