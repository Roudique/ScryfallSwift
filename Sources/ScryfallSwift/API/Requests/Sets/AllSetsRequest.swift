//
//  SetsRequest.swift
//  ScryfallSwift
//
//  Created by Roudique on 10/14/18.
//

import Foundation

public struct AllSetsRequest: APIRequest {
    public typealias Response = List<CardSet>
    
    public var resourceName: String {
        return "/sets"
    }
    
    public init() {}
}
