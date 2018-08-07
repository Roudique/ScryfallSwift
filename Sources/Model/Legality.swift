//
//  GameFormat.swift
//  ScryfallSwift iOS
//
//  Created by Roudique on 8/6/18.
//

import Foundation

/// Class describing the legality of this card across play formats.
class Legality: Decodable {
    var standard: LegalityStatus
    var future: LegalityStatus
    var frontier: LegalityStatus
    var modern: LegalityStatus
    var legacy: LegalityStatus
    var pauper: LegalityStatus
    var vintage: LegalityStatus
    var penny: LegalityStatus
    var commander: LegalityStatus
    var oneVsOne: LegalityStatus
    var duel: LegalityStatus
    var brawl: LegalityStatus
    
    
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
        case oneVsOne = "1v1"
        case duel
        case brawl
    }
}

enum LegalityStatus: String, Decodable {
    case legal
    case notLegal = "not_legal"
    case restricted
    case banned
}
