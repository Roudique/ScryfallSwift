//
//  GameFormat.swift
//  ScryfallSwift iOS
//
//  Created by Roudique on 8/6/18.
//

import Foundation

/// Class describing the legality of this card across play formats.
public class CardLegality: Decodable {
    public var standard: LegalityStatus
    public var future: LegalityStatus
    public var frontier: LegalityStatus
    public var modern: LegalityStatus
    public var legacy: LegalityStatus
    public var pauper: LegalityStatus
    public var vintage: LegalityStatus
    public var penny: LegalityStatus
    public var commander: LegalityStatus
    public var duel: LegalityStatus
    
    
    // CodingKeys
    
    enum CodingKeys: String, CodingKey {
        case standard
        case future
        case frontier
        case modern
        case legacy
        case pauper
        case vintage
        case penny
        case commander
        case duel
    }
}

public enum LegalityStatus: String, Decodable {
    case legal
    case notLegal = "not_legal"
    case restricted
    case banned
}
