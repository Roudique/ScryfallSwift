//
//  AllCardsRequest.swift
//  ScryfallSwift
//
//  Created by Roudique on 3/9/19.
//

import Foundation


public struct AllCardsRequest: APIRequest {
    public typealias Response = List<Card>
    
    public var resourceName: String {
        return "/cards"
    }
    
    public init() {}
}
