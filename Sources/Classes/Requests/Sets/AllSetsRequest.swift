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
        return "/sets"
    }
}
