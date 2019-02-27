//
//  Price.swift
//  ScryfallSwift
//
//  Created by Roudique on 2/26/19.
//

import Foundation


/// An object containing daily price information for card.
struct Price: Decodable {
    var usd: Double?
    var usdFoil: Double?
    var eur: Double?
    var tix: Double?
    
    enum CodingKeys: String, CodingKey {
        case usd
        case usdFoil = "usd_foil"
        case eur
        case tix
    }
}
