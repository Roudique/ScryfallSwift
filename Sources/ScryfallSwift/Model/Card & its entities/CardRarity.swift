//
//  CardRarity.swift
//  ScryfallSwift
//
//  Created by Roudique on 3/3/19.
//

import Foundation


/// Card's rarity.
public enum CardRarity: String, Decodable, Comparable, CaseIterable {
    public static func < (lhs: CardRarity, rhs: CardRarity) -> Bool {
        if lhs == .common, rhs != .common { return true }
        if lhs == .uncommon, rhs != .uncommon, rhs != .common { return true }
        if lhs == .rare, rhs == .mythic { return true }
        
        return false
    }
    
    public static func > (lhs: CardRarity, rhs: CardRarity) -> Bool {
        if lhs == .mythic, rhs != .mythic { return true }
        if lhs == .rare, rhs != .rare, rhs != .mythic { return true }
        if lhs == .uncommon, rhs == .common { return true }
        
        return false
    }

    
    case common
    case uncommon
    case rare
    case mythic
    
    case special
    case bonus
}

