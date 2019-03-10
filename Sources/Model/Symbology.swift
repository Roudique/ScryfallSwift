//
//  Symbology.swift
//  ScryfallSwift
//
//  Created by Roudique on 3/9/19.
//

import Foundation



/// A Card Symbol object represents an illustrated symbol that may appear in card’s mana cost or Oracle text. Symbols are based on the notation used in the Comprehensive Rules.
class Symbololy: Decodable {
    /// The plaintext symbol. Often surrounded with curly braces {}. Note that not all symbols are ASCII text (for example, {∞}).
    var symbol: String
    
    /// An alternate version of this symbol, if it is possible to write it without curly braces.
    var looseVariant: String?
    
    /// An English snippet that describes this symbol. Appropriate for use in alt text or other accessible communication formats.
    var english: String
    
    /// True if it is possible to write this symbol “backwards”. For example, the official symbol {U/P} is sometimes written as {P/U} or {P\U} in informal settings. Note that the Scryfall API never writes symbols backwards in other responses. This field is provided for informational purposes.
    var isTransposable: Bool
    
    /// True if this is a mana symbol.
    var representsMana: Bool
    
    /// A decimal number representing this symbol’s converted mana cost. Note that mana symbols from funny sets can have fractional converted mana costs.
    var cmc: Double
    
    /// True if this symbol appears in a mana cost on any Magic card. For example {20} has this field set to false because {20} only appears in Oracle text, not mana costs.
    var appearsInManaCosts: Bool

    /// True if this symbol is only used on funny cards or Un-cards.
    var isFunny: Bool
    
    /// An array of colors that this symbol represents.
    var colors: [CardColor]
    
    /// An array of plaintext versions of this symbol that Gatherer uses on old cards to describe original printed text. For example: {W} has ["oW", "ooW"] as alternates.
    var gathererAlternates: [String]?
    
    enum CodingKeys: String, CodingKey {
        case symbol
        case looseVariant = "loose_variant"
        case english
        case isTransposable = "transposable"
        case representsMana = "represents_mana"
        case cmc
        case appearsInManaCosts = "appears_in_mana_costs"
        case isFunny = "funny"
        case colors
        case gathererAlternates = "gatherer_alternates"
    }
}
