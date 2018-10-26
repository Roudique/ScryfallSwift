//
//  RandomCardRequest.swift
//  ScryfallSwift
//
//  Created by Roudique on 10/24/18.
//

import Foundation


struct RandomCardRequest: APIRequest {
    var resourceName: String {
        get { return "/cards/random" }
    }
    
    typealias Response = Card
}

