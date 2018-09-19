//
//  List.swift
//  ScryfallSwift
//
//  Created by Roudique on 9/13/18.
//

import Foundation


enum ListData: Decodable {
    case cards([Card])
    case sets([CardSet])
    case rulings([Ruling])
    case cardSymbols([CardSymbol])
}

extension ListData {
    init(from decoder: Decoder) throws {
        if let cards = try? [Card].init(from: decoder) {
            self = .cards(cards)
        } else if let sets = try? [CardSet].init(from: decoder) {
            self = .sets(sets)
        } else if let rulings = try? [Ruling].init(from:decoder) {
            self = .rulings(rulings)
        } else if let cardSymbols = try? [CardSymbol].init(from: decoder) {
            self = .cardSymbols(cardSymbols)
        }else {
            let context = DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Cannot decode \([Card].self) or \([CardSet].self) or \([Ruling].self)")
            throw DecodingError.dataCorrupted(context)
        }
    }
}


class List: Decodable {
    /// An array of the requested objects, in a specific order.
    var data: ListData

    /// True if this List is paginated and there is a page beyond the current page.
    var hasMore: Bool = false

    /// If there is a page beyond the current page, this field will contain a full API URI to that page.
    var nextPage: URL?

    /// If this is a list of Card objects, this field will contain the total number of cards found across all pages.
    var totalCards: Int?

    /// An array of human-readable warnings issued when generating this list, as strings.
    ///
    /// Warnings are non-fatal issues that the API discovered with your input. In general, they indicate that the List will not contain the all of the information you requested. You should fix the warnings and re-submit your request.
    var warnings: [String]?

    enum CodingKeys: String, CodingKey {
        case data       = "data"
        case hasMore    = "has_more"
        case nextPage   = "next_page"
        case totalCards = "total_cards"
        case warnings   = "warnings"
    }
}
