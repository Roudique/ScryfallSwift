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
    
    /// A unique ID for this card in Scryfall’s database.
    var id: String
    
    /// A unique ID for this card’s oracle identity. This value is consistent across reprinted card editions, and unique among different cards with the same name (tokens, Unstable variants, etc).
    var oracleID: String
    
    /// This card’s multiverse IDs on Gatherer, if any, as an array of integers. Note that Scryfall includes many promo cards, tokens, and other esoteric objects that do not have these identifiers.
    var multiverseIDs: [Int]?
    
    /// This card’s Magic Online ID (also known as the Catalog ID), if any. A large percentage of cards are not available on Magic Online and do not have this ID.
    var mtgoID: Int?
    
    /// This card’s foil Magic Online ID (also known as the Catalog ID), if any. A large percentage of cards are not available on Magic Online and do not have this ID.
    var mtgoFoilID: Int?
    
    /// A link to this card object on Scryfall’s API.
    var uri: URL
    
    /// A link to this card’s permapage on Scryfall’s website.
    var scryfallURI: URL
    
    /// A link to where you can begin paginating all re/prints for this card on Scryfall’s API.
    var printsSearchURI: URL
    
    /// A link to this card’s rulings on Scryfall’s API.
    var rulingsURI: URL
    
    
    //MARK: - Gameplay fields
    
    /// The name of this card. If this card has multiple faces, this field will contain both names separated by ␣//␣.
    var name: String
    
    /// A computer-readable designation for this card’s layout. See the layout article.
    var layout: String
    
    /// The card’s converted mana cost. Note that some funny cards have fractional mana costs.
    var cmc: Int
    
    /// The type line of this card.
    var typeLine: String
    
    /// The Oracle text for this card, if any.
    var oracleText: String?
    
    /// The mana cost for this card. This value will be any empty string "" if the cost is absent. Remember that per the game rules, a missing mana cost and a mana cost of {0} are different values.
    var manaCost: String
    
    /// This card’s power, if any. Note that some cards have powers that are not numeric, such as *.
    var power: String?

    /// This card’s toughness, if any. Note that some cards have toughnesses that are not numeric, such as *.
    var toughness: String?
    
    /// This loyalty if any. Note that some cards have loyalties that are not numeric, such as X.
    var loyalty: String?
    
    /// This card’s life modifier, if it is Vanguard card. This value will contain a delta, such as +2.
    var lifeModifier: String?
    
    /// This card’s hand modifier, if it is Vanguard card. This value will contain a delta, such as -1.
    var handModifier: String?
    
    /// This card’s colors.
    var colors: [CardColor]
    
    /// The colors in this card’s color indicator, if any. A null value for this field indicates the card does not have one.
    var colorIndicator: [CardColor]?
    
    /// This card’s color identity.
    var colorIdentity: [CardColor]
    
    /// If this card is closely related to other cards, this property will be an array with.
    var allParts: [String]?
    
    /// An array of Card Face objects, if this card is multifaced.
    var cardFaces: [CardFace]?
    
    /// An object describing the legality of this card.
    var legalities: [String: String]
    
    /// True if this card is on the Reserved List.
    var reserved: Bool
    
    /// True if this printing exists in a foil version.
    var foil: Bool
    
    /// True if this printing exists in a nonfoil version.
    var nonfoil: Bool
    
    /// True if this card is oversized.
    var oversized: Bool
    
    /// This card’s overall rank/popularity on EDHREC. Not all carsd are ranked.
    var edhrecRank: Int?
    
    
    //MARK: - Print fields
    
    /// This card’s set code.
    var set: String
    
    /// This card’s full set name.
    var setName: String
    
    /// This card’s collector number. Note that collector numbers can contain non-numeric characters, such as letters or ★.
    var collectorNumber: String
    
    /// A link to where you can begin paginating this card’s set on the Scryfall API.
    var setSearchURI: URL
    
    /// A link to this card’s set on Scryfall’s website.
    var scryfallSetURI: URL
    
    /// An object listing available imagery for this card. See the [Card Imagery](#) article for more information.
    var imageURIs: [String: URL]?
    
    /// True if this card’s imagery is high resolution.
    var hasHighresImage: Bool
    
    /// True if this card is a reprint.
    var isReprint: Bool
    
    /// True if this is a digital card on Magic Online.
    var isDigital: Bool
    
    /// This card’s rarity. One of common, uncommon, rare, or mythic.
    var rarity: String

    /// The flavor text, if any.
    var flavorText: String?
    
    /// The name of the illustrator of this card. Newly spoiled cards may not have this field yet.
    var artist: String?
    
    /// A unique identifier for the card artwork that remains consistent across reprints. Newly spoiled cards may not have this field yet.
    var illustrationID: String?
    
    /// This card’s frame layout.
    var frame: String
    
    /// True if this card’s artwork is larger than normal.
    var isFullArt: Bool
    
    /// This card’s watermark, if any.
    var watermark: String?
    
    /// This card’s border color: black, borderless, gold, silver, or white.
    var borderColor: String
    
    /// This card’s story spotlight number, if any.
    var storySpotlightNumber: Int?
    
    /// A URL to this cards’s story article, if any.
    var storySpotlightURI: String?
    
    /// True if this card is timeshifted.
    var isTimeshifted: Bool
    
    /// True if this card is colorshifted.
    var isColorshifted: Bool
    
    /// True if this card is from the future.
    var isFutureshifted: Bool
    
    
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
        
        // Print fields.
        case set
        case setName = "set_name"
        case collectorNumber = "collector_number"
        case setSearchURI = "set_search_uri"
        case scryfallSetURI = "scryfall_set_uri"
        case imageURIs = "image_uris"
        case hasHighresImage = "highres_image"
        case isReprint = "reprint"
        case isDigital = "digital"
        case rarity
        case flavorText = "flavor_text"
        case artist
        case illustrationID = "illustration_id"
        case frame
        case isFullArt = "full_art"
        case watermark
        case borderColor = "border_color"
        case storySpotlightNumber = "story_spotlight_number"
        case storySpotlightURI = "story_spotlight_uri"
        case isTimeshifted = "timeshifted"
        case isColorshifted = "colorshifted"
        case isFutureshifted = "futureshifted"
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
    var imageURIs: [String: URL]?
    
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

