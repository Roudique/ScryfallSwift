//
//  Card.swift
//  ScryfallSwift
//
//  Created by Roudique on 5/8/18.
//

import Foundation


enum CardColor: String, Decodable {
    case white  = "W"
    case blue   = "U"
    case black  = "B"
    case red    = "R"
    case green  = "G"
}

public class Card: Decodable {
    //MARK: - Core fields
    var id: String
    var oracleID: String
    var multiverseIDs: [Int]?
    var mtgoID: Int?
    var mtgoFoilID: Int?
    var uri: URL
    var scryfallURI: URL
    var printsSearchURI: URL
    var rulingsURI: URL
    
    //MARK: - Gameplay fields

    var name: String
    var layout: String
    var cmc: Int
    var typeLine: String
    var oracleText: String?
    var manaCost: String
    var power: String?
    var toughness: String?
    var loyalty: String?
    var lifeModifier: String?
    var handModifier: String?
    var colors: [CardColor]
    var colorIndicator: [CardColor]?
    var colorIdentity: [CardColor]
    var allParts: [String]?
    var cardFaces: [CardFace]?
    var legalities: [String: String]
    var reserved: Bool
    var foil: Bool
    var nonfoil: Bool
    var oversized: Bool
    var edhrecRank: Int?
    
    
    //MARK: - CodingKeys
    
    enum CodingKeys: String, CodingKey {
        // Core fields.
        case id
        case oracleID = "oracle_id"
        case multiverseIDs = "multiverse_ids"
        case mtgoID = "mtgo_id"
        case mtgoFoilID = "mtgo_foil_id"
        case uri
        case scryfallURI = "scryfall_uri"
        case printsSearchURI = "prints_search_uri"
        case rulingsURI = "rulings_uri"
        
        // Gameplay fields.
        case name
        case layout
        case cmc
        case typeLine = "type_line"
        case oracleText = "oracle_text"
        case manaCost = "mana_cost"
        case power
        case toughness
        case loyalty
        case lifeModifier = "life_modifier"
        case handModifier = "hand_modifier"
        case colors
        case colorIndicator = "color_indicator"
        case colorIdentity = "color_identity"
        case allParts = "all_parts"
        case cardFaces = "card_faces"
        case legalities
        case reserved
        case foil
        case nonfoil
        case oversized
        case edhrecRank = "edhrec_rank"
    }
}

struct CardFace: Decodable {
    var name: String
    var typeLine: String
    var oracleText: String?
    var manaCost: String
    var colors: [CardColor]
    var colorIndicator: [CardColor]?
    var power: String?
    var toughness: String?
    var loyalty: String?
    var flavorText: String?
    var illustrationID: String?
    var imageURIs: [String]?
    
    enum CodingKeys: String, CodingKey {
        case name
        case typeLine = "type_line"
        case oracleText = "oracle_text"
        case manaCost = "mana_cost"
        case colors
        case colorIndicator = "color_indicator"
        case power
        case toughness
        case loyalty
        case flavorText = "flavor_text"
        case illustrationID = "illustration_id"
        case imageURIs = "image_uris"
    }
}

