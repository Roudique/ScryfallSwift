//
//  CardFace.swift
//  ScryfallSwift
//
//  Created by Roudique on 3/3/19.
//

import Foundation


//MARK: -
/// Multiface cards have a card_faces property containing at least two Card Face objects.
public struct CardFace: Decodable {
    public var artist: String
    public var colorIndicator: [CardColor]?
    public var colors: [CardColor]?
    public var flavorText: String?
    public var illustrationID: String?
    public var imagery: Imagery?
    public var loyalty: String?
    public var manaCost: String
    public var name: String
    public var oracleText: String?
    public var power: String?
    public var printedName: String?
    public var printedText: String?
    public var printedTypeLine: String?
    public var toughness: String?
    public var typeLine: String?
    public var watermark: String?
    
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
