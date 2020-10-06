//
//  GameFormat.swift
//  ScryfallSwift iOS
//
//  Created by Roudique on 8/6/18.
//

import Foundation

public typealias FormatLegality = (format: CardLegality.Kind, status: LegalityStatus)

/// Class describing the legality of this card across play formats.
public class CardLegality: Decodable {
    public var standard: LegalityStatus
    public var future: LegalityStatus
    public var historic: LegalityStatus
    public var pioneer: LegalityStatus
    public var modern: LegalityStatus
    public var legacy: LegalityStatus
    public var pauper: LegalityStatus
    public var vintage: LegalityStatus
    public var penny: LegalityStatus
    public var commander: LegalityStatus
    public var brawl: LegalityStatus
    public var duel: LegalityStatus
    public var oldschool: LegalityStatus
    
    public enum Kind: CaseIterable {
        case standard, future, historic, pioneer, frontier, modern, legacy, pauper, vintage, penny, commander, brawl, duel, oldschool
    }
    
    public var allStatuses: [FormatLegality] {
        return [(.standard, standard),
                (.future, future),
                (.historic, historic),
                (.pioneer, pioneer),
                (.modern, modern),
                (.legacy, legacy),
                (.pauper, pauper),
                (.vintage, vintage),
                (.penny, penny),
                (.commander, commander),
                (.brawl, brawl),
                (.duel, duel),
                (.oldschool, oldschool)]
    }
    
    public var mainStatuses: [FormatLegality] {
        return [(.standard, standard),
                (.brawl, brawl),
                (.pioneer, pioneer),
                (.historic, historic),
                (.modern, modern),
                (.pauper, pauper),
                (.legacy, legacy),
                (.penny, penny),
                (.vintage, vintage),
                (.commander, commander)]
    }
    
    // CodingKeys
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case standard
        case future
        case historic
        case pioneer
        case modern
        case legacy
        case pauper
        case vintage
        case penny
        case commander
        case brawl
        case duel
        case oldschool
    }
}

public enum LegalityStatus: String, Decodable, CaseIterable {
    case legal
    case notLegal = "not_legal"
    case restricted
    case banned
}
