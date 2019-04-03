//
//  RelatedCard.swift
//  ScryfallSwift
//
//  Created by Roudique on 3/3/19.
//

import Foundation


//MARK: -
/// Cards that are closely related to other cards (because they call them by name, or generate a token, or meld, etc) have a related_cards property that contains Related Card objects.
public struct RelatedCard: Decodable {
    /// An unique ID for this card in Scryfall’s database.
    public var id: String
    
    // MARK: -
    // TODO: Add component
    // MARK: -
    public var component: RelatedCardComponent
    
    /// The name of this particular related card.
    public var name: String
    
    /// The type line of this card.
    public var typeLine: String
    
    /// A URI where you can retrieve a full object describing this card on Scryfall’s API.
    public var uri: URL
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case component
        case name
        case typeLine = "type_line"
        case uri
    }
}

public enum RelatedCardComponent: String, Decodable {
    case token
    case meldPart = "meld_part"
    case meldResult = "meld_result"
    case comboPiece = "combo_piece"
}
