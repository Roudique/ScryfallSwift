//
//  CardColor.swift
//  ScryfallSwift
//
//  Created by Roudique on 3/3/19.
//

import Foundation


/// While Magic cards can represent costs and colors using printed symbols, the Comprehensive Rules and Scryfall’s API use a text representation of these values.
public enum CardColor: String, Decodable, Comparable {
    public static func < (lhs: CardColor, rhs: CardColor) -> Bool {
        if lhs == rhs { return false }
        if lhs == .green { return false }
        
        if lhs == .white { return true }
        if lhs == .blue, rhs != .white { return true }
        if lhs == .black, rhs != .blue, rhs != .white { return true }
        if lhs == .red, rhs == .green { return true }
        
        return false
    }
    public static func > (lhs: CardColor, rhs: CardColor) -> Bool {
        if lhs == rhs { return false }
        if lhs == .white { return false }
        
        if lhs == .green { return true }
        if lhs == .red, rhs != .green { return true }
        if lhs == .black, rhs != .red, rhs != green { return true }
        if lhs == .blue, rhs == .white { return true }
        
        return false
    }

    case white  = "W"
    case blue   = "U"
    case black  = "B"
    case red    = "R"
    case green  = "G"
}
