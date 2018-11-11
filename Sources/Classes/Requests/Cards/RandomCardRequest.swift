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
    let format: Format = Format.json
}
extension RandomCardRequest: QueryableAPIRequest {
    var queryItems: [String : String] {
        var queryItems = [String: String]()
        if let fulltextRequest = self.fulltextRequest, let query = fulltextRequest.queryItems["q"] {
            queryItems["q"] = query
        }
        
        return queryItems
    }
}


struct RandomTextCardRequest: APIRequest {
    var resourceName: String {
        return "/cards/random"
    }
    typealias Response = String
    
    let format = Format.text
    let fulltextRequest: FulltextCardSearchRequest?
}
extension RandomTextCardRequest: QueryableAPIRequest {
    var queryItems: [String : String] {
        var queryItems = [String: String]()
        if let fulltextRequest = self.fulltextRequest, let query = fulltextRequest.queryItems["q"] {
            queryItems["q"] = query
        }
        
        return queryItems
    }
}


struct RandomCardImageRequest: APIRequest {
    var resourceName: String {
        return "/cards/random"
    }
    
    typealias Response = Data
    
    private var cardRequest: RandomCardRequest
    var format: Format
    
    init(imageConfig: ImageConfig, fulltextCardRequest: FulltextCardSearchRequest? = nil) {
        self.cardRequest = RandomCardRequest(fulltextRequest: fulltextCardRequest)
        self.format = .image(imageConfig)
    }
}
extension RandomCardImageRequest: QueryableAPIRequest {
    var queryItems: [String : String] {
        return self.cardRequest.queryItems.merging(self.format.queryItems, uniquingKeysWith: { str1, str2 in
            return str1
        })
    }
}
