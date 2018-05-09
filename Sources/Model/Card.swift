//
//  Card.swift
//  ScryfallSwift
//
//  Created by Roudique on 5/8/18.
//

import Foundation

public class Card: Decodable {
    // Core fields
    var id: String
    var oracleID: String
    var multiverseIDs: [Int]?
    var mtgoID: Int?
    var mtgoFoilID: Int?
    var uri: URL
    var scryfallURI: URL
    var printsSearchURI: URL
    var rulingsURI: URL

    private enum CodingKeys: String, CodingKey {
        case id
        case oracleID = "oracle_id"
        case multiverseIDs = "multiverse_ids"
        case mtgoID = "mtgo_id"
        case mtgoFoilID = "mtgo_foil_id"
        case uri
        case scryfallURI = "scryfall_uri"
        case printsSearchURI = "prints_search_uri"
        case rulingsURI = "rulings_uri"
    }
}

