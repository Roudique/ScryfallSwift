//
//  AllSymbologyRequest.swift
//  ScryfallSwift
//
//  Created by Roudique on 3/9/19.
//

import Foundation


public struct AllSymbologyRequest: APIRequest {
    public typealias Response = List<Symbology>
    
    public var resourceName: String {
        return "/symbology"
    }
}
