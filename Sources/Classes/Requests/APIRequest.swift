//
//  APIRequest.swift
//  ScryfallSwift
//
//  Created by Roudique on 10/14/18.
//

import Foundation


/// All requests conform to this protocol.
public protocol APIRequest {
    associatedtype Response: Decodable
    
    /// Endpoint for this request.
    var resourceName: String { get }
}
