//
//  Catalog.swift
//  ScryfallSwift
//
//  Created by Roudique on 10/23/18.
//

import Foundation


/// A Catalog object contains an array of Magic datapoints (words, card values, etc). Catalog objects are provided by the API as aids for building other Magic software and understanding possible values for a field on Card objects.
class Catalog: Codable {
    /// A link to the current catalog on Scryfall’s API.
    var uri: URL?
    
    /// The number of items in the data array.
    var total: Int
    
    /// An array of datapoints, as strings.
    var data: [String]
    
    private enum CodingKeys: String, CodingKey {
        case uri
        case total = "total_values"
        case data
    }
}
