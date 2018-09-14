//
//  List.swift
//  ScryfallSwift
//
//  Created by Roudique on 9/13/18.
//

import Foundation



class List {
    init?(with data: Data) {
        do {
            guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]  else {
                return nil
            }
            
            if let more = json[CodingKeys.hasMore.rawValue] as? Bool {
                self.hasMore = more
            }
            
            if let nextPage = json[CodingKeys.nextPage.rawValue] as? String,
                let nextPageURL = URL(string: nextPage) {
                self.nextPage = nextPageURL
            }
            
            if let totalCards = json[CodingKeys.totalCards.rawValue] as? Int {
                self.totalCards = totalCards
            }
            
            if let warnings = json[CodingKeys.warnings.rawValue] as? [String] {
                self.warnings = warnings
            }
        } catch {
            print("Error: \(error)")
            return nil
        }
    }

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
        case hasMore    = "has_more"
        case nextPage   = "next_page"
        case totalCards = "total_cards"
        case warnings   = "warnings"
    }
}

class CardsList: List {
    override init?(with data: Data) {
        do {
            guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]  else {
                return nil
            }
            
            if let cardsData = json[CodingKeys.cards.rawValue] {
                if let cardsJSONData = try? JSONSerialization.data(withJSONObject: cardsData, options: []) {
                    let decoder = JSONDecoder()
                    guard let cards = try? decoder.decode([Card].self, from: cardsJSONData) else { return nil }
                    self.cards = cards
                    
                    super.init(with: data)
                    return
                } else {
                    return nil
                }
            }
        } catch {
            return nil
        }
        return nil
    }
    
    var cards: [Card]
    
    enum CodingKeys: String, CodingKey {
        case cards = "data"
    }
}







