//
//  RandomCardRequest.swift
//  ScryfallSwift
//
//  Created by Roudique on 10/24/18.
//

import Foundation


struct RandomCardRequest: APIRequest {
    var resourceName: String {
         return "/cards/random"
    }
    
    typealias Response = Card
    
    var fulltextRequest: FulltextCardSearchRequest?
    var format: Format?
}
extension RandomCardRequest: QueryableAPIRequest {
    var queryItems: [String : String] {
        var queryItems = [String: String]()
        if let fulltextRequest = self.fulltextRequest, let query = fulltextRequest.queryItems["q"] {
            queryItems["q"] = query
        }
        
        if let format = format {
            
        }
        
        return queryItems
    }
}

