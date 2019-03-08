//
//  RandomCardRequest.swift
//  ScryfallSwift
//
//  Created by Roudique on 10/24/18.
//

import Foundation

struct RandomCardRequest: APIRequest, FormatResponseRequest {
    var resourceName: String {
        return "/cards/random"
    }
    
    typealias Response = FormatResponse
    
    var search: String?
    let format: Format
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
