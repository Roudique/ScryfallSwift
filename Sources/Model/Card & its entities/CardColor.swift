//
//  CardColor.swift
//  ScryfallSwift
//
//  Created by Roudique on 3/3/19.
//

import Foundation


/// While Magic cards can represent costs and colors using printed symbols, the Comprehensive Rules and Scryfall’s API use a text representation of these values.
enum CardColor: String, Decodable {
    case white  = "W"
    case blue   = "U"
    case black  = "B"
    case red    = "R"
    case green  = "G"
}
