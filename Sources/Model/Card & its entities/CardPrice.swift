//
//  CardPrice.swift
//  ScryfallSwift
//
//  Created by Roudique on 2/26/19.
//

import Foundation


/// An object containing daily price information for card.
public struct CardPrice: Decodable {
    public var usd: String?
    public var usdFoil: String?
    public var eur: String?
    public var tix: String?
    
    enum CodingKeys: String, CodingKey {
        case usd
        case usdFoil = "usd_foil"
        case eur
        case tix
    }
}
