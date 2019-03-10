//
//  AllCardsRequest.swift
//  ScryfallSwift
//
//  Created by Roudique on 3/9/19.
//

import Foundation


struct AllCardsRequest: APIRequest {
    typealias Response = List<Card>
    
    var resourceName: String {
        return "/cards"
    }
}
