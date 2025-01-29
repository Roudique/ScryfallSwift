//
//  CardBorderColor.swift
//  ScryfallSwift
//
//  Created by Roudique on 9/21/19.
//

import Foundation


public enum CardBorderColor: String, Decodable, CaseIterable {
    case black, borderless, gold, silver, white, yellow
    case unknown
    
    public init(from decoder: Decoder) throws {
        self = try CardBorderColor(
            rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .unknown
    }
}
