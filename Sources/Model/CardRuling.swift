//
//  File.swift
//  ScryfallSwift
//
//  Created by Roudique on 7/15/18.
//

import Foundation


/// Rulings represent Oracle rulings, Wizards of the Coast set release notes, or Scryfall notes for a particular card.
///
/// If two cards have the same name, they will have the same set of rulings objects. If a card has rulings, it usually has more than one.
///
///Rulings with a **scryfall** source have been added by the Scryfall team, either to provide additional context for the card, or explain how the card works in an unofficial format (such as Duel Commander).
class CardRuling: Decodable {
    /// A computer-readable string indicating which company produced this ruling, either wotc or scryfall.
    var source: String
    
    /// The date when the ruling or note was published.
    var publishedAt: String
    
    static var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        return dateFormatter
    }()
    
    lazy var publishedDate: Date? = {
        return CardRuling.dateFormatter.date(from: publishedAt)
    }()
    
    /// The text of the ruling.
    var comment: String
    
    enum CodingKeys: String, CodingKey {
        case source
        case publishedAt = "published_at"
        case comment
    }
}
