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

protocol QueryableAPIRequest {
    /// Query items for the request.
    var queryItems: [String: String] { get }
}

protocol CustomHTTPRequest {
    var httpMethod: HTTPMethod { get }
}

protocol CustomBodyRequest {
    var body: Data { get }
}

protocol CustomHeadersRequest {
    var headers: [String: String] { get }
}

protocol BasicAPIRequest {
    var basicURL: URL? { get }
}
