//
//  List.swift
//  ScryfallSwift
//
//  Created by Roudique on 9/13/18.
//

import Foundation



public class List<Model: Decodable>: Decodable {
    /// An array of the requested objects, in a specific order.
    public var data: [Model]

    /// True if this List is paginated and there is a page beyond the current page.
    public var hasMore: Bool = false

    /// If there is a page beyond the current page, this field will contain a full API URI to that page.
    public var nextPage: URL?

    /// If this is a list of Card objects, this field will contain the total number of cards found across all pages.
    public var totalCards: Int?

    /// An array of human-readable warnings issued when generating this list, as strings.
    ///
    /// Warnings are non-fatal issues that the API discovered with your input. In general, they indicate that the List will not contain the all of the information you requested. You should fix the warnings and re-submit your request.
    public var warnings: [String]?

    enum CodingKeys: String, CodingKey {
        case data       = "data"
        case hasMore    = "has_more"
        case nextPage   = "next_page"
        case totalCards = "total_cards"
        case warnings   = "warnings"
    }
}

/// List returned by Card Collection request.
public class CollectionList: Decodable {
    /// While cards will be returned in the order that they were requested, cards that aren’t found will throw off the mapping of request identifiers to results, so you should not rely on positional index alone while parsing the data.
    public var cards: [Card]
    
    /// Identifiers that are not found.
    public var notFoundIdentifiers: [String]
    
    enum CodingKeys: String, CodingKey {
        case cards = "data"
        case notFoundIdentifiers = "not_found"
    }
}
