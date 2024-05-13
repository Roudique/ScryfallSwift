//
//  ScryfallError.swift
//  ScryfallSwift
//
//  Created by Roudique on 9/13/18.
//

import Foundation

public struct ScryfallError: Error, Decodable {
    /// An integer HTTP status code for this error.
    public var status: Int
    
    /// A computer-friendly string representing the appropriate HTTP status code.
    public var code: String
    
    /// A human-readable string explaining the error.
    public var details: String
    
    /// A computer-friendly string that provides additional context for the main error.
    ///
    /// For example, an endpoint many generate `HTTP 404` errors for different kinds of input. This field will provide a label for the specific kind of 404 failure, such as `ambiguous`.
    public var type: String?
    
    /// If your input also generated non-failure warnings, they will be provided as human-readable strings in this array.
    public var warnings: [String]?
}

public enum CommonError: Error {
    case invalidURL(String)
    
    public var localizedDescription: String {
        if case let CommonError.invalidURL(path) = self {
            return "Invalid path: \(path)"
        }
        
        return ""
    }
}
