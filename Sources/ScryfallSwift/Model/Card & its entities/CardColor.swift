//
//  CardColor.swift
//  ScryfallSwift
//
//  Created by Roudique on 3/3/19.
//

import Foundation


/// While Magic cards can represent costs and colors using printed symbols, the Comprehensive Rules and Scryfall’s API use a text representation of these values.
public enum CardColor: String, Decodable, Comparable, CaseIterable {
    public static func < (lhs: CardColor, rhs: CardColor) -> Bool {
        return lhs.index < rhs.index
    }
    public static func > (lhs: CardColor, rhs: CardColor) -> Bool {
        return lhs.index > rhs.index
    }

    case white      = "W"
    case blue       = "U"
    case black      = "B"
    case red        = "R"
    case green      = "G"
    case colorless  = "C"
    
    public init(from decoder: Decoder) throws {
        self = try CardColor(
            rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .colorless
    }
    
    private var index: Int {
        return CardColor.allCases.firstIndex(of: self) ?? -1
    }
}
