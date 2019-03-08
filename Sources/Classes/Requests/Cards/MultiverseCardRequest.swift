//
//  MultiverseCardRequest.swift
//  ScryfallSwift
//
//  Created by Roudique on 3/7/19.
//

import Foundation


struct MultiverseCardRequest: APIRequest, FormatResponseRequest {
    typealias Response = FormatResponse

    var resourceName: String {
        return "/cards/multiverse/\(id)"
    }
    
    let id: Int
    let format: Format
}
extension MultiverseCardRequest: QueryableAPIRequest {
    var queryItems: [String : String] {
        var queryItems = ["format": format.stringRepresentation()]
        
        if case let Format.image(imageConfig) = format {
            var formatQueryItems = [String: String]()
            formatQueryItems["face"] = imageConfig.isBackFace ? "back" : nil
            formatQueryItems["version"] = imageConfig.version.stringValue
            queryItems.merge(formatQueryItems) { str1, str2 in
                return str1
            }
        }

        return queryItems
    }
}
