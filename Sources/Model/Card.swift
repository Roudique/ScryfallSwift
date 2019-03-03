//
//  Card.swift
//  ScryfallSwift
//
//  Created by Roudique on 5/8/18.
//

import Foundation


/// While Magic cards can represent costs and colors using printed symbols, the Comprehensive Rules and Scryfall’s API use a text representation of these values.
enum CardColor: String, Decodable {
    case white  = "W"
    case blue   = "U"
    case black  = "B"
    case red    = "R"
    case green  = "G"
}


/// Card objects represent individual Magic: The Gathering cards that players could obtain and add to their collection (with a few minor exceptions).
public class Card: Decodable {
    //MARK: - Core fields
    
    /// This card’s Arena ID, if any. A large percentage of cards are not available on Arena and do not have this ID.
    var arenaID: Int?
    
    /// A unique ID for this card in Scryfall’s database.
    var id: String
    
    /// A language code for this printing. [Link to scryfall.com](https://scryfall.com/docs/api/languages)
    var lang: String
    
    /// This card’s Magic Online ID (also known as the Catalog ID), if any. A large percentage of cards are not available on Magic Online and do not have this ID.
    var mtgoID: Int?
    
    /// This card’s foil Magic Online ID (also known as the Catalog ID), if any. A large percentage of cards are not available on Magic Online and do not have this ID.
    var mtgoFoilID: Int?
    
    /// This card’s multiverse IDs on Gatherer, if any, as an array of integers. Note that Scryfall includes many promo cards, tokens, and other esoteric objects that do not have these identifiers.
    var multiverseIDs: [Int]?

    /// This card’s ID on TCGplayer’s API, also known as the productId.
    var tcgPlayerID: Int?
    
    /// A unique ID for this card’s oracle identity. This value is consistent across reprinted card editions, and unique among different cards with the same name (tokens, Unstable variants, etc).
    var oracleID: String
    
    /// A link to where you can begin paginating all re/prints for this card on Scryfall’s API.
    var printsSearchURI: URL
    
    /// A link to this card’s rulings on Scryfall’s API.
    var rulingsURI: URL
    
    /// A link to this card’s permapage on Scryfall’s website.
    var scryfallURI: URL

    /// A link to this card object on Scryfall’s API.
    var uri: URL
    
    
    //MARK: - Gameplay fields
    
    /// If this card is closely related to other cards, this property will be an array with related cards.
    var allParts: [RelatedCard]?
    
    /// An array of Card Face objects, if this card is multifaced.
    var cardFaces: [CardFace]?
    
    /// The card’s converted mana cost. Note that some funny cards have fractional mana costs.
    var cmc: Double
    
    /// This card’s colors.
    ///
    ///Whenever the API presents set of Magic colors, the field will be an array that uses the uppercase, single-character abbreviations for those colors. For example, ["W","U"] represents something that is both white and blue. Colorless sources are denoted with an empty array []
    ///
    ///Common places were you might see this kind of array are a Card object’s colors and color_identity. When a color field is null or missing, it implies that that information is not pertinent for the current object. It does not imply that the object is colorless.
    ///
    ///Color arrays are not guaranteed to be in a particular order.
    ///
    /// **Null** if card is double-faced.
    var colors: [CardColor]?
    
    /// This card’s color identity.
    var colorIdentity: [CardColor]

    /// The colors in this card’s color indicator, if any. A null value for this field indicates the card does not have one.
    var colorIndicator: [CardColor]?
    
    /// This card’s overall rank/popularity on EDHREC. Not all carsd are ranked.
    var edhrecRank: Int?
    
    /// True if this printing exists in a foil version.
    var foil: Bool
    
    /// This card’s hand modifier, if it is Vanguard card. This value will contain a delta, such as -1.
    var handModifier: String?
    
    /// A computer-readable designation for this card’s layout. 
    var layout: CardLayout
    
    /// An object describing the legality of this card.
    var legalities: Legality
    
    /// This card’s life modifier, if it is Vanguard card. This value will contain a delta, such as +2.
    var lifeModifier: String?

    /// This loyalty if any. Note that some cards have loyalties that are not numeric, such as X.
    var loyalty: String?
    
    /// The mana cost for this card. This value will be any empty string "" if the cost is absent. Remember that per the game rules, a missing mana cost and a mana cost of {0} are different values.
    ///
    /// **Null** if card is double-faced.
    var manaCost: String?

    /// The name of this card. If this card has multiple faces, this field will contain both names separated by ␣//␣.
    var name: String
    
    /// True if this printing exists in a nonfoil version.
    var nonfoil: Bool
    
    /// The Oracle text for this card, if any.
    var oracleText: String?
    
    /// True if this card is oversized.
    var oversized: Bool
    
    /// This card’s power, if any. Note that some cards have powers that are not numeric, such as *.
    var power: String?
    
    /// True if this card is on the Reserved List.
    var reserved: Bool

    /// This card’s toughness, if any. Note that some cards have toughnesses that are not numeric, such as *.
    var toughness: String?

    /// The type line of this card.
    ///
    /// **Null** if card is double-faced.
    var typeLine: String?
    
    
    //MARK: - Print fields
    
    /// The name of the illustrator of this card. Newly spoiled cards may not have this field yet.
    var artist: String?
    
    /// This card’s border color: black, borderless, gold, silver, or white.
    var borderColor: String
    
    /// This card’s collector number. Note that collector numbers can contain non-numeric characters, such as letters or ★.
    var collectorNumber: String
    
    /// True if this is a digital card on Magic Online.
    var isDigital: Bool

    /// The flavor text, if any.
    var flavorText: String?

    /// This card’s frame effect, if any.
    var frameEffect: FrameEffect?
    
    /// This card’s frame layout.
    var frame: String
    
    /// True if this card’s artwork is larger than normal.
    var isFullArt: Bool

    /// A list of games that this card print is available in.
    var games: [Game]
    
    /// True if this card’s imagery is high resolution.
    var hasHighresImage: Bool
    
    /// A unique identifier for the card artwork that remains consistent across reprints. Newly spoiled cards may not have this field yet.
    var illustrationID: String?
    
    /// An object listing available imagery for this card.
    var imagery: Imagery?

    /// An object containing daily price information for this card.
    var prices: Price
    
    /// The localized name printed on this card.
    var printedName: String?
    
    /// The localized text printed on this card.
    var printedText: String?
    
    /// The localized type line printed on this card.
    var printedTypeLine: String?
    
    /// True if this card is a promotional print.
    var isPromo: Bool
    
    /// An object providing URIs to this card’s listing on major marketplaces.
    var purchaseURIs: [String: URL]
    
    /// This card’s rarity. One of common, uncommon, rare, or mythic.
    var rarity: Rarity
    
    // MARK: -
    // TODO: Add related_uris
    // TODO: Add released_at
    // MARK: -
    
    /// True if this card is a reprint.
    var isReprint: Bool
    
    /// A link to this card’s set on Scryfall’s website.
    var scryfallSetURI: URL
    
    /// This card’s full set name.
    var setName: String

    // MARK: -
    // TODO: Add set_uri
    // MARK: -
    
    /// This card’s set code.
    var set: String
    
    /// A link to where you can begin paginating this card’s set on the Scryfall API.
    var setSearchURI: URL
    
    // MARK: -
    // TODO: change these to story_spotlight
    /// This card’s story spotlight number, if any.
    var storySpotlightNumber: Int?
    
    /// A URL to this cards’s story article, if any.
    var storySpotlightURI: String?
    // MARK: - mark
    
    /// This card’s watermark, if any.
    var watermark: String?

    
    // CodingKeys
    
    enum CodingKeys: String, CodingKey {
        // Core fields.
        case arenaID = "arena_id"
        case id
        case lang
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
        case frameEffect = "frame_effect"
        case prices
        case games
        case isPromo = "promo"
        case purchaseURIs = "purchase_uris"
        case set
        case setName = "set_name"
        case collectorNumber = "collector_number"
        case setSearchURI = "set_search_uri"
        case scryfallSetURI = "scryfall_set_uri"
        case imagery = "image_uris"
        case hasHighresImage = "highres_image"
        case printedName = "printed_name"
        case printedText = "printed_text"
        case printedTypeLine = "printed_type_line"
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
    }
}


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


//MARK: -
/// Cards that are closely related to other cards (because they call them by name, or generate a token, or meld, etc) have a related_cards property that contains Related Card objects.
struct RelatedCard: Decodable {
    /// An unique ID for this card in Scryfall’s database.
    var id: String
    
    // MARK: -
    // TODO: Add component
    // MARK: -
    
    /// The name of this particular related card.
    var name: String
    
    /// The type line of this card.
    var typeLine: String
    
    /// A URI where you can retrieve a full object describing this card on Scryfall’s API.
    var uri: URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case typeLine = "type_line"
        case uri
    }
}




// MARK: -
/// The frame_effect field tracks additional frame artwork applied over a particular frame. For example, there are both 2003 and 2015-frame cards with the Nyx-touched effect.
///
/// - legendary: The legendary crown introduced in Dominaria
/// - miracle: The miracle frame effect
/// - nyxtouched: The Nyx-touched frame effect
/// - draft: The draft-matters frame effect
/// - devoid: The Devoid frame effect
/// - tombstone: The Odyssey tombstone mark
/// - colorshifted: A colorshifted frame
/// - sunmoondfc: The sun and moon transform marks
/// - compasslanddfc: The compass and land transform marks
/// - originpwdfc: The Origins and planeswalker transform marks
/// - mooneldrazidfc: The moon and Eldrazi transform marks
enum FrameEffect: String, Decodable {
    case legendary
    case miracle
    case nyxtouched
    case draft
    case devoid
    case tombstone
    case colorshifted
    case sunmoondfc
    case compasslanddfc
    case originpwdfc
    case mooneldrazidfc
}


/// Card's rarity.
enum Rarity: String, Decodable {
    case common
    case uncommon
    case rare
    case mythic
}


// MARK: -
/// Games that card print could be available.
enum Game: String, Decodable {
    case paper
    case arena
    case mtgo
}
