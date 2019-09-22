//
//  RandomCardRequest.swift
//  ScryfallSwift
//
//  Created by Roudique on 10/24/18.
//

import Foundation

public struct RandomCardRequest: APIRequest, FormatResponseRequest {
    public var resourceName: String {
        return "/cards/random"
    }
    
    public typealias Response = FormatResponse
    
    public var search: String?
    public let format: Format
    
    public init(search: String? = nil, format: Format = .json) {
        self.format = format
        self.search = search
    }
}
extension RandomCardRequest: QueryableAPIRequest {
    var queryItems: [String : String] {
        var queryItems = [String: String]()
        if let search = search {
            queryItems["q"] = search
        }
        
        if case let Format.image(imageConfig) = format {
            var formatQueryItems = [String: String]()
            formatQueryItems["face"] = imageConfig.isBackFace ? "back" : nil
            formatQueryItems["version"] = imageConfig.version.stringValue
            queryItems.merge(formatQueryItems) { str1, str2 in
                return str1
            }
        }
        
        queryItems["format"] = format.stringRepresentation()
        
        return queryItems
    }
}
