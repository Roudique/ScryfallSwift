// Generated with scrylog.
import Foundation


public class Card: Decodable {
    //MARK: - Core Card Fields
    
    /// This card’s Arena ID, if any. A large percentage of cards are not available on Arena and do not have this ID.
    var arenaID: Int?
    
    /// A unique ID for this card in Scryfall’s database.
    var ID: String
    
    /// A language code for this printing.
    var lang: String
    
    /// This card’s Magic Online ID (also known as the Catalog ID), if any. A large percentage of cards are not available on Magic Online and do not have this ID.
    var mtgoID: Int?
    
    /// This card’s foil Magic Online ID (also known as the Catalog ID), if any. A large percentage of cards are not available on Magic Online and do not have this ID.
    var mtgoFoilID: Int?
    
    /// This card’s multiverse IDs on Gatherer, if any, as an array of integers. Note that Scryfall includes many promo cards, tokens, and other esoteric objects that do not have these identifiers.
    var multiverseIDs: [Int]?
    
    /// This card’s ID on TCGplayer’s API, also known as the productId.
    var tcgplayerID: Int?
    
    /// A content type for this object, always card.
    var object: String
    
    /// A unique ID for this card’s oracle identity. This value is consistent across reprinted card editions, and unique among different cards with the same name (tokens, Unstable variants, etc).
    var oracleID: String
    
    /// A link to where you can begin paginating all re/prints for this card on Scryfall’s API.
    var printsSearchURI: URL
    
    /// A link to this card’s rulings list on Scryfall’s API.
    var rulingsURI: URL
    
    /// A link to this card’s permapage on Scryfall’s website.
    var scryfallURI: URL
    
    /// A link to this card object on Scryfall’s API.
    var URI: URL

    
	//MARK: - Gameplay Fields

	/// If this card is closely related to other cards, this property will be an array with Related Card Objects.
	var allParts: [RelatedCard]?

	/// An array of Card Face objects, if this card is multifaced.
	var cardFaces: [CardFace]?

	/// The card’s converted mana cost. Note that some funny cards have fractional mana costs.
	var cmc: Double

	/// This card’s colors, if the overall card has colors defined by the rules. Otherwise the colors will be on the card_faces objects, see below.
	var colors: [CardColor]?

	/// This card’s color identity.
	var colorIdentity: [CardColor]

	/// The colors in this card’s color indicator, if any. A null value for this field indicates the card does not have one.
	var colorIndicator: [CardColor]?

	/// This card’s overall rank/popularity on EDHREC. Not all cards are ranked.
	var edhrecRank: Int?

	/// True if this printing exists in a foil version.
	var isFoil: Bool

	/// This card’s hand modifier, if it is Vanguard card. This value will contain a delta, such as -1.
	var handModifier: String?

	/// A code for this card’s layout.
	var layout: CardLayout

	/// An object describing the legality of this card across play formats. Possible legalities are legal, not_legal, restricted, and banned.
	var legalities: CardLegality

	/// This card’s life modifier, if it is Vanguard card. This value will contain a delta, such as +2.
	var lifeModifier: String?

	/// This loyalty if any. Note that some cards have loyalties that are not numeric, such as X.
	var loyalty: String?

	/// The mana cost for this card. This value will be any empty string "" if the cost is absent. Remember that per the game rules, a missing mana cost and a mana cost of {0} are different values. Multi-faced cards will report this value in card faces.
	var manaCost: String?

	/// The name of this card. If this card has multiple faces, this field will contain both names separated by ␣//␣.
	var name: String

	/// True if this printing exists in a nonfoil version.
	var isNonfoil: Bool

	/// The Oracle text for this card, if any.
	var oracleText: String?

	/// True if this card is oversized.
	var isOversized: Bool

	/// This card’s power, if any. Note that some cards have powers that are not numeric, such as *.
	var power: String?

	/// True if this card is on the Reserved List.
	var isReserved: Bool

	/// This card’s toughness, if any. Note that some cards have toughnesses that are not numeric, such as *.
	var toughness: String?

	/// The type line of this card.
    /// *nil* if card is double-faced.
	var typeLine: String?


	//MARK: - Print Fields

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
	var frameEffect: String

	/// This card’s frame layout.
	var frame: String

	/// True if this card’s artwork is larger than normal.
	var isFullArt: Bool

	/// A list of games that this card print is available in, paper, arena, and/or mtgo.
	var games: [CardGame]

	/// True if this card’s imagery is high resolution.
	var isHighresImage: Bool

	/// A unique identifier for the card artwork that remains consistent across reprints. Newly spoiled cards may not have this field yet.
	var illustrationID: String?

	/// An object listing available imagery for this card. See the Card Imagery article for more information.
	var imagery: Imagery?

	/// An object containing daily price information for this card, including usd, usd_foil, eur, and tix prices, as strings.
	var prices: CardPrice

	/// The localized name printed on this card, if any.
	var printedName: String?

	/// The localized text printed on this card, if any.
	var printedText: String?

	/// The localized type line printed on this card, if any.
	var printedTypeLine: String?

	/// True if this card is a promotional print.
	var isPromo: Bool

	/// An object providing URIs to this card’s listing on major marketplaces.
    var purchaseURIs: [String: URL]

	/// This card’s rarity. One of common, uncommon, rare, or mythic.
	var rarity: String

	/// An object providing URIs to this card’s listing on other Magic: The Gathering online resources.
    var relatedURIs: [String: URL]

	/// The date this card was first released.
	var releasedAt: Date

	/// True if this card is a reprint.
	var isReprint: Bool

	/// A link to this card’s set on Scryfall’s website.
	var scryfallSetURI: URL

	/// This card’s full set name.
	var setName: String

	/// A link to where you can begin paginating this card’s set on the Scryfall API.
	var setSearchURI: URL

	/// A link to this card’s set object on Scryfall’s API.
	var setURI: URL

	/// This card’s set code.
	var set: String

	/// True if this card is a Story Spotlight.
	var isStorySpotlight: Bool

	/// This card’s watermark, if any.
	var watermark: String?


	// CodingKeys
	enum CodingKeys: String, CodingKey {
        // Core Card Fields
        
        case arenaID = "arena_id"
        case ID = "id"
        case lang
        case mtgoID = "mtgo_id"
        case mtgoFoilID = "mtgo_foil_id"
        case multiverseIDs = "multiverse_ids"
        case tcgplayerID = "tcgplayer_id"
        case object
        case oracleID = "oracle_id"
        case printsSearchURI = "prints_search_uri"
        case rulingsURI = "rulings_uri"
        case scryfallURI = "scryfall_uri"
        case URI = "uri"

		// Gameplay Fields

		case allParts = "all_parts"
		case cardFaces = "card_faces"
		case cmc
		case colors
		case colorIdentity = "color_identity"
		case colorIndicator = "color_indicator"
		case edhrecRank = "edhrec_rank"
		case isFoil = "foil"
		case handModifier = "hand_modifier"
		case layout
		case legalities
		case lifeModifier = "life_modifier"
		case loyalty
		case manaCost = "mana_cost"
		case name
		case isNonfoil = "nonfoil"
		case oracleText = "oracle_text"
		case isOversized = "oversized"
		case power
		case isReserved = "reserved"
		case toughness
		case typeLine = "type_line"

		// Print Fields

		case artist
		case borderColor = "border_color"
		case collectorNumber = "collector_number"
		case isDigital = "digital"
		case flavorText = "flavor_text"
		case frameEffect = "frame_effect"
		case frame
		case isFullArt = "full_art"
		case games
		case isHighresImage = "highres_image"
		case illustrationID = "illustration_id"
		case imagery = "image_uris"
		case prices
		case printedName = "printed_name"
		case printedText = "printed_text"
		case printedTypeLine = "printed_type_line"
		case isPromo = "promo"
		case purchaseURIs = "purchase_uris"
		case rarity
		case relatedURIs = "related_uris"
		case releasedAt = "released_at"
		case isReprint = "reprint"
		case scryfallSetURI = "scryfall_set_uri"
		case setName = "set_name"
		case setSearchURI = "set_search_uri"
		case setURI = "set_uri"
		case set
		case isStorySpotlight = "story_spotlight"
		case watermark
	}
}
