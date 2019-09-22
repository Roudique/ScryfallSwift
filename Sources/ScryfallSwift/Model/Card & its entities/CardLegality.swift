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
    public var modern: LegalityStatus
    public var legacy: LegalityStatus
    public var pauper: LegalityStatus
    public var vintage: LegalityStatus
    public var penny: LegalityStatus
    public var commander: LegalityStatus
    public var duel: LegalityStatus
    public var future: LegalityStatus
    
    public enum Kind {
        case standard, frontier, modern, legacy, pauper, vintage, penny, commander, duel, future
    }
    
    public var statuses: [(kind: Kind, status: LegalityStatus)] {
        return [(.standard, standard),
                (.modern, modern),
                (.legacy, legacy),
                (.pauper, pauper),
                (.vintage, vintage),
                (.penny, penny),
                (.commander, commander),
                (.duel, duel),
                (.future, future)]
    }

    
    // CodingKeys
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case standard
        case modern
        case legacy
        case pauper
        case vintage
        case penny
        case commander
        case duel
        case future
    }
}

public enum LegalityStatus: String, Decodable {
    case legal
    case notLegal = "not_legal"
    case restricted
    case banned
}
