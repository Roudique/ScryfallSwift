// Generated with scrylog.
import Foundation


public class Card: Decodable {
    //MARK: - Core Card Fields
    
    /// This card’s Arena ID, if any. A large percentage of cards are not available on Arena and do not have this ID.
    public var arenaID: Int?
    
    /// A unique ID for this card in Scryfall’s database.
    public var ID: String
    
    /// A language code for this printing.
    public var lang: String
    
    /// This card’s Magic Online ID (also known as the Catalog ID), if any. A large percentage of cards are not available on Magic Online and do not have this ID.
    public var mtgoID: Int?
    
    /// This card’s foil Magic Online ID (also known as the Catalog ID), if any. A large percentage of cards are not available on Magic Online and do not have this ID.
    public var mtgoFoilID: Int?
    
    /// This card’s multiverse IDs on Gatherer, if any, as an array of integers. Note that Scryfall includes many promo cards, tokens, and other esoteric objects that do not have these identifiers.
    public var multiverseIDs: [Int]?
    
    /// This card’s ID on TCGplayer’s API, also known as the productId.
    public var tcgplayerID: Int?
    
    /// A content type for this object, always card.
    public var object: String
    
    /// A unique ID for this card’s oracle identity. This value is consistent across reprinted card editions, and unique among different cards with the same name (tokens, Unstable variants, etc).
    public var oracleID: String?
    
    /// A link to where you can begin paginating all re/prints for this card on Scryfall’s API.
    public var printsSearchURI: URL
    
    /// A link to this card’s rulings list on Scryfall’s API.
    public var rulingsURI: URL
    
    /// A link to this card’s permapage on Scryfall’s website.
    public var scryfallURI: URL
    
    /// A link to this card object on Scryfall’s API.
    public var URI: URL

    
	//MARK: - Gameplay Fields

	/// If this card is closely related to other cards, this property will be an array with Related Card Objects.
	public var allParts: [RelatedCard]?

	/// An array of Card Face objects, if this card is multifaced.
	public var cardFaces: [CardFace]?

	/// The card’s converted mana cost. Note that some funny cards have fractional mana costs.
	public var cmc: Double

	/// This card’s colors, if the overall card has colors defined by the rules. Otherwise the colors will be on the card_faces objects, see below.
	public var colors: [CardColor]?

	/// This card’s color identity.
	public var colorIdentity: [CardColor]

	/// The colors in this card’s color indicator, if any. A null value for this field indicates the card does not have one.
	public var colorIndicator: [CardColor]?

	/// This card’s overall rank/popularity on EDHREC. Not all cards are ranked.
	public var edhrecRank: Int?

	/// True if this printing exists in a foil version.
	public var isFoil: Bool

	/// This card’s hand modifier, if it is Vanguard card. This value will contain a delta, such as -1.
	public var handModifier: String?
    
    /// An array of keywords that this card uses, such as 'Flying' and 'Cumulative upkeep'.
    public var keywords: [String]

	/// A code for this card’s layout.
	public var layout: CardLayout

	/// An object describing the legality of this card across play formats. Possible legalities are legal, not_legal, restricted, and banned.
	public var legalities: CardLegality

	/// This card’s life modifier, if it is Vanguard card. This value will contain a delta, such as +2.
	public var lifeModifier: String?

	/// This loyalty if any. Note that some cards have loyalties that are not numeric, such as X.
	public var loyalty: String?

	/// The mana cost for this card. This value will be any empty string "" if the cost is absent. Remember that per the game rules, a missing mana cost and a mana cost of {0} are different values. Multi-faced cards will report this value in card faces.
	public var manaCost: String?

	/// The name of this card. If this card has multiple faces, this field will contain both names separated by ␣//␣.
	public var name: String

	/// True if this printing exists in a nonfoil version.
	public var isNonfoil: Bool

	/// The Oracle text for this card, if any.
	public var oracleText: String?

	/// True if this card is oversized.
	public var isOversized: Bool

	/// This card’s power, if any. Note that some cards have powers that are not numeric, such as *.
	public var power: String?
    
    /// Colors of mana that this card could produce.
    public var producedMana: [CardColor]?

	/// True if this card is on the Reserved List.
	public var isReserved: Bool

	/// This card’s toughness, if any. Note that some cards have toughnesses that are not numeric, such as *.
	public var toughness: String?

	/// The type line of this card.
    /// *nil* if card is double-faced.
	public var typeLine: String?


	//MARK: - Print Fields

	/// The name of the illustrator of this card. Newly spoiled cards may not have this field yet.
	public var artist: String?
    
    public var isFoundInBoosters: Bool

	/// This card’s border color: black, borderless, gold, silver, or white.
	public var borderColor: CardBorderColor
    
    /// The Scryfall ID for the card back design present on this card.
    /// 
    /// **NOTE:** this is marked as non-nil on backend but some cards that are just art
    /// pieces actually don't have cardBackID.
    public var cardBackID: String?

	/// This card’s collector number. Note that collector numbers can contain non-numeric characters, such as letters or ★.
	public var collectorNumber: String
    
    /// True if you should consider avoiding use of this print downstream.
    /// https://scryfall.com/blog/regarding-wotc-s-recent-statement-on-depictions-of-racism-220
    public var contentWarning: Bool?

	/// True if this is a digital card on Magic Online.
	public var isDigital: Bool

    /// The just-for-fun name printed on the card (such as for Godzilla series cards).
    public var flavorName: String?
    
	/// The flavor text, if any.
	public var flavorText: String?

	/// This card’s frame effects, if any.
	public var frameEffects: [CardFrameEffect]?

	/// This card’s frame layout.
	public var frame: String

	/// True if this card’s artwork is larger than normal.
	public var isFullArt: Bool

	/// A list of games that this card print is available in, paper, arena, and/or mtgo.
	public var games: [CardGame]

	/// True if this card’s imagery is high resolution.
	public var isHighresImage: Bool

	/// A unique identifier for the card artwork that remains consistent across reprints. Newly spoiled cards may not have this field yet.
	public var illustrationID: String?

	/// An object listing available imagery for this card. See the Card Imagery article for more information.
	public var imagery: Imagery?

	/// An object containing daily price information for this card, including usd, usd_foil, eur, and tix prices, as strings.
	public var prices: CardPrice

	/// The localized name printed on this card, if any.
	public var printedName: String?

	/// The localized text printed on this card, if any.
	public var printedText: String?

	/// The localized type line printed on this card, if any.
	public var printedTypeLine: String?

	/// True if this card is a promotional print.
	public var isPromo: Bool
    
    /// An array of strings describing what categories of promo cards this card falls into.
    public var promoTypes: [String]?

	/// An object providing URIs to this card’s listing on major marketplaces.
    public var purchaseURIs: [String: URL]?

	/// This card’s rarity. One of common, uncommon, rare, or mythic.
	public var rarity: CardRarity

	/// An object providing URIs to this card’s listing on other Magic: The Gathering online resources.
    public var relatedURIs: [String: URL]

	/// The date this card was first released.
	public var releasedAt: Date

	/// True if this card is a reprint.
	public var isReprint: Bool

	/// A link to this card’s set on Scryfall’s website.
	public var scryfallSetURI: URL

	/// This card’s full set name.
	public var setName: String

	/// A link to where you can begin paginating this card’s set on the Scryfall API.
	public var setSearchURI: URL
    
    /// The type of set this printing is in.
    public var setType: String

	/// A link to this card’s set object on Scryfall’s API.
	public var setURI: URL

	/// This card’s set code.
	public var set: String

	/// True if this card is a Story Spotlight.
	public var isStorySpotlight: Bool
    
    /// True if the card is printed without text.
    public var isTextless: Bool
    
    /// Whether this card is a variation of another printing.
    public var isVariation: Bool
    
    /// The printing ID of the printing this card is a variation of.
    public var variationOf: String?

	/// This card’s watermark, if any.
	public var watermark: String?
    
    /// This card's preview info.
    public var preview: CardPreview?


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
        case keywords
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
        case producedMana = "produced_mana"
		case isReserved = "reserved"
		case toughness
		case typeLine = "type_line"

		// Print Fields

		case artist
        case isFoundInBoosters = "booster"
		case borderColor = "border_color"
        case cardBackID = "card_back_id"
		case collectorNumber = "collector_number"
        case contentWarning = "content_warning"
		case isDigital = "digital"
        case flavorName = "flavor_name"
		case flavorText = "flavor_text"
		case frameEffects = "frame_effects"
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
        case promoTypes = "promo_types"
		case purchaseURIs = "purchase_uris"
		case rarity
		case relatedURIs = "related_uris"
		case releasedAt = "released_at"
		case isReprint = "reprint"
		case scryfallSetURI = "scryfall_set_uri"
		case setName = "set_name"
		case setSearchURI = "set_search_uri"
        case setType = "set_type"
		case setURI = "set_uri"
		case set
		case isStorySpotlight = "story_spotlight"
        case isTextless = "textless"
        case isVariation = "variation"
        case variationOf = "variation_of"
		case watermark
        case preview
	}
}
