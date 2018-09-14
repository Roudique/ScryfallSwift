//
//  ScryfallError.swift
//  ScryfallSwift
//
//  Created by Roudique on 9/13/18.
//

import Foundation

struct ScryfallError: Error, Codable {
    /// An integer HTTP status code for this error.
    var status: Int
    
    /// A computer-friendly string representing the appropriate HTTP status code.
    var code: String
    
    /// A human-readable string explaining the error.
    var details: String
    
    /// A computer-friendly string that provides additional context for the main error.
    ///
    /// For example, an endpoint many generate `HTTP 404` errors for different kinds of input. This field will provide a label for the specific kind of 404 failure, such as `ambiguous`.
    var type: String?
    
    /// If your input also generated non-failure warnings, they will be provided as human-readable strings in this array.
    var warnings: [String]?
}
