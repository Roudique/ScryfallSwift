//
//  CardSet.swift
//  ScryfallSwift
//
//  Created by Oleksandr Rudavka on 2018-05-23.
//

import Foundation


enum CardSetType: String, Decodable {
    /// A yearly Magic core set (Tenth Edition, etc).
    case core
    /// A rotational expansion set in a block (Zendikar, etc).
    case expansion
    /// A reprint set that contains no new cards (Modern Masters, etc).
    case masters
    /// Masterpiece Series premium foil cards.
    case masterpiece
    /// From the Vault gift sets.
    case fromTheVault = "from_the_vault"
    /// Spellbook series gift sets.
    case spellbook
    /// Premium Deck Series decks.
    case premiumDeck = "premium_deck"
    /// Duel Decks.
    case duelDeck = "duel_deck"
    /// Special draft sets, like Conspiracy and Battlebond.
    case draftInnovation = "draft_innovation"
    /// Commander preconstructed decks.
    case commander
    /// Planechase sets.
    case planechase
    /// Archenemy sets.
    case archenemy
    /// Vanguard card sets.
    case vanguard
    /// A funny un-set or set with funny promos (Unglued, Happy Holidays, etc).
    case funny
    /// A starter/introductory set (Portal, etc).
    case starter
    /// A gift box set.
    case box
    /// A set that contains purely promotional cards.
    case promo
    /// A set made up of tokens and emblems.
    case token
    /// A set made up of gold-bordered, oversize, or trophy cards that are not legal.
    case memorabilia
    #warning("This one is not documented yet.")
    /// No info on this one yet.
    case treasureChest = "treasure_chest"
 
}

/// A **Set** object represents a group of related Magic cards. All Card objects on Scryfall belong to exactly one set.
///
/// Due to Magic’s long and complicated history, Scryfall includes many un-official sets as a way to group promotional or outlier cards together. Such sets will likely have a four-letter **code** that begins with **p** or **t**, such as **pcel** or **tori**.
///
/// Official sets always have a three-letter set code, such as **zen**.
class CardSet: Decodable {
    /// The unique three or four-letter code for this set.
    var code: String
    
    /// The unique code for this set on MTGO, which may differ from the regular code.
    var mtgoCode: String?
    
    /// The English name of the set.
    var name: String
    
    /// A computer-readable classification for this set.
    var setType: CardSetType
    
    /// The date the set was released (in GMT-8 Pacific time). Not all sets have a known release date.
    var releasedAt: String?
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        return dateFormatter
    }()
    
    /// Release date as an object of **Date** class.
    lazy var releaseDate: Date? = {
        guard let value = releasedAt else { return nil }

        return CardSet.dateFormatter.date(from: value)
    }()
    
    /// The block code for this set, if any.
    var blockCode: String?
    
    /// The block or group name code for this set, if any.
    var block: String?
    
    /// The set code for the parent set, if any. **promo** and **token** sets often have a parent set.
    var parentSetCode: String?
    
    /// The number of cards in this set.
    var cardCount: Int
    
    /// True if this set was only released on Magic Online.
    var isDigital: Bool
    
    /// True if this set contains only foil cards.
    var isFoilOnly: Bool
    
    /// A URI to an SVG file for this set’s icon on Scryfall’s CDN.
    ///
    /// Hotlinking this image isn’t recommended, because it may change slightly over time. You should download it and use it locally for your particular user interface needs.
    var iconURI: URL
    
    /// A Scryfall API URI that you can request to begin paginating over the cards in this set.
    var searchURI: URL
    
    enum CodingKeys: String, CodingKey {
        case code
        case mtgoCode       = "mtgo_code"
        case name
        case setType        = "set_type"
        case releasedAt     = "released_at"
        case blockCode      = "block_code"
        case block
        case parentSetCode  = "parent_set_code"
        case cardCount      = "card_count"
        case isDigital      = "digital"
        case isFoilOnly     = "foil_only"
        case iconURI        = "icon_svg_uri"
        case searchURI      = "search_uri"
    }
}
