//
//  AllSymbologyRequest.swift
//  ScryfallSwift
//
//  Created by Roudique on 3/9/19.
//

import Foundation


struct AllSymbologyRequest: APIRequest {
    typealias Response = List<Symbology>
    
    var resourceName: String {
        return "/symbology"
    }
}
