//
//  CardPrice.swift
//  ScryfallSwift
//
//  Created by Roudique on 2/26/19.
//

import Foundation


/// An object containing daily price information for card.
struct CardPrice: Decodable {
    var usd: String?
    var usdFoil: String?
    var eur: String?
    var tix: String?
    
    enum CodingKeys: String, CodingKey {
        case usd
        case usdFoil = "usd_foil"
        case eur
        case tix
    }
}
