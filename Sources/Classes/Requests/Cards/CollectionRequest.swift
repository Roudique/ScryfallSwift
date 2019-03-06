//
//  CollectionRequest.swift
//  ScryfallSwift
//
//  Created by Roudique on 11/11/18.
//

import Foundation


/// Accepts a JSON array of card identifiers, and returns a List object with the collection of requested cards. A maximum of 75 card references may be submitted per request. 
struct CollectionRequest: APIRequest {
    var resourceName: String {
        return "/cards/collection"
    }
    
    typealias Response = CollectionList
    
    let identifiers: [CardIdentifier]
}
extension CollectionRequest: CustomHTTPRequest {
    var httpMethod: HTTPMethod {
        return .post
    }
}
extension CollectionRequest: CustomBodyRequest {
    var body: Data {
        let identifiersArray = self.identifiers.map { $0.dict() }
        let identifiersDict = ["identifiers": identifiersArray]
        
        if let data = try? JSONSerialization.data(withJSONObject: identifiersDict, options: []) {
            return data
        }
        return Data()
    }
}
extension CollectionRequest: CustomHeadersRequest {
    var headers: [String: String] {
        return ["Content-Type": "application/json"]
    }
}
