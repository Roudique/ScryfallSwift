//
//  RelatedCard.swift
//  ScryfallSwift
//
//  Created by Roudique on 3/3/19.
//

import Foundation


//MARK: -
/// Cards that are closely related to other cards (because they call them by name, or generate a token, or meld, etc) have a related_cards property that contains Related Card objects.
struct RelatedCard: Decodable {
    /// An unique ID for this card in Scryfall’s database.
    var id: String
    
    // MARK: -
    // TODO: Add component
    // MARK: -
    
    /// The name of this particular related card.
    var name: String
    
    /// The type line of this card.
    var typeLine: String
    
    /// A URI where you can retrieve a full object describing this card on Scryfall’s API.
    var uri: URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case typeLine = "type_line"
        case uri
    }
}
