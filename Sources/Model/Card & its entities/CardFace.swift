//
//  CardFace.swift
//  ScryfallSwift
//
//  Created by Roudique on 3/3/19.
//

import Foundation


//MARK: -
/// Multiface cards have a card_faces property containing at least two Card Face objects.
struct CardFace: Decodable {
    var artist: String
    var colorIndicator: [CardColor]?
    var colors: [CardColor]?
    var flavorText: String?
    var illustrationID: String?
    var imagery: Imagery?
    var loyalty: String?
    var manaCost: String
    var name: String
    var oracleText: String?
    var power: String?
    var printedName: String?
    var printedText: String?
    var printedTypeLine: String?
    var toughness: String?
    var typeLine: String
    var watermark: String?
    
    enum CodingKeys: String, CodingKey {
        case artist
        case colorIndicator = "color_indicator"
        case colors
        case flavorText = "flavor_text"
        case illustrationID = "illustration_id"
        case imagery = "image_uris"
        case loyalty
        case manaCost = "mana_cost"
        case name
        case oracleText = "oracle_text"
        case power
        case printedName = "printed_name"
        case printedText = "printed_text"
        case printedTypeLine = "printed_type_line"
        case toughness
        case typeLine = "type_line"
        case watermark
    }
}
