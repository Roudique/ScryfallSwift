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
    
    /// A computer-readable designation for this card’s layout. 
    var layout: Layout
    
    /// The card’s converted mana cost. Note that some funny cards have fractional mana costs.
    var cmc: Double
    
    /// The type line of this card.
    ///
    /// **Null** if card is double-faced.
    var typeLine: String?
    
    /// The Oracle text for this card, if any.
    var oracleText: String?
    
    /// The mana cost for this card. This value will be any empty string "" if the cost is absent. Remember that per the game rules, a missing mana cost and a mana cost of {0} are different values.
    ///
    /// **Null** if card is double-faced.
    var manaCost: String?
    
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
    ///
    ///Whenever the API presents set of Magic colors, the field will be an array that uses the uppercase, single-character abbreviations for those colors. For example, ["W","U"] represents something that is both white and blue. Colorless sources are denoted with an empty array []
    ///
    ///Common places were you might see this kind of array are a Card object’s colors and color_identity. When a color field is null or missing, it implies that that information is not pertinent for the current object. It does not imply that the object is colorless.
    ///
    ///Color arrays are not guaranteed to be in a particular order.
    ///
    /// **Null** if card is double-faced.
    var colors: [CardColor]?
    
    /// The colors in this card’s color indicator, if any. A null value for this field indicates the card does not have one.
    var colorIndicator: [CardColor]?
    
    /// This card’s color identity.
    var colorIdentity: [CardColor]
    
    /// If this card is closely related to other cards, this property will be an array with related cards.
    var allParts: [RelatedCard]?
    
    /// An array of Card Face objects, if this card is multifaced.
    var cardFaces: [CardFace]?
    
    /// An object describing the legality of this card.
    var legalities: Legality
    
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
    
    /// An object listing available imagery for this card.
    var imagery: Imagery?
    
    /// True if this card’s imagery is high resolution.
    var hasHighresImage: Bool
    
    /// True if this card is a reprint.
    var isReprint: Bool
    
    /// The localized name printed on this card.
    var printedName: String?
    
    /// The localized text printed on this card.
    var printedText: String?
    
    /// The localized type line printed on this card.
    var printedTypeLine: String?
    
    /// True if this is a digital card on Magic Online.
    var isDigital: Bool
    
    /// This card’s rarity. One of common, uncommon, rare, or mythic.
    var rarity: Rarity

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
        case isTimeshifted = "timeshifted"
        case isColorshifted = "colorshifted"
        case isFutureshifted = "futureshifted"
    }
}


//MARK: -
/// Multiface cards have a card_faces property containing at least two Card Face objects.
struct CardFace: Decodable {
    var name: String
    var typeLine: String
    var oracleText: String?
    var manaCost: String
    var colors: [CardColor]?
    var colorIndicator: [CardColor]?
    var power: String?
    var toughness: String?
    var loyalty: String?
    var flavorText: String?
    var illustrationID: String?
    var imagery: Imagery?
    
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
        case imagery = "image_uris"
    }
}


//MARK: -
/// Cards that are closely related to other cards (because they call them by name, or generate a token, or meld, etc) have a related_cards property that contains Related Card objects.
struct RelatedCard: Decodable {
    /// An unique ID for this card in Scryfall’s database.
    var id: String
    
    /// The name of this particular related card.
    var name: String
    
    /// A URI where you can retrieve a full object describing this card on Scryfall’s API.
    var uri: URL
}


//MARK: -
/// he layout property the arrangement of card parts, faces, and other bounded regions on cards. The layout can be used to programmatically determine which other properties on a card you can expect.
///
/// - cards with the layouts **split**, **flip**, **transform**, and **doubleFacedToken** will always have a **cardFaces** property describing the distinct faces.
///  - cards with the layout **meld** will always have a **relatedCards** property pointing to the other meld parts.
enum Layout: String, Decodable {
    /// A standard Magic card with one face
    case normal
    
    /// A split-faced card
    case split
    
    /// Cards that invert vertically with the flip keyword
    case flip
    
    /// Double-sided cards that transform
    case transform
    
    /// Cards with meld parts printed on the back
    case meld
    
    /// Cards with Level Up
    case leveler
    
    /// Saga-type cards
    case saga
    
    /// Plane and Phenomenon-type cards
    case planar
    
    /// Scheme-type cards
    case scheme
    
    /// Vanguard-type cards
    case vanguard
    
    /// Token cards
    case token
    
    /// Tokens with another token printed on the back
    case doubleFacedToken = "double_faced_token"
    
    /// Emblem cards
    case emblem
    
    /// Cards with **Augment**
    case augment
    
    /// Host-type cards
    case host
}


/// Card's rarity.
enum Rarity: String, Decodable {
    case common
    case uncommon
    case rare
    case mythic
}
