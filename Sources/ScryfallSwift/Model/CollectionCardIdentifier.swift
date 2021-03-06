//
//  CollectionCardIdentifier.swift
//  ScryfallSwift
//
//  Created by Roudique on 11/11/18.
//

import Foundation


/// Each submitted card identifier must be a JSON object with one or more of the keys.
///
/// - id: Finds a card with the specified Scryfall id.
/// - mtgoID: Finds a card with the specified mtgo_id or mtgo_foil_id.
/// - multiverseID: Finds a card with the specified value among its multiverse_ids.
/// - name: Finds the newest edition of a card with the specified name.
/// - nameAndSet: Finds a card matching the specified name and set.
/// - collectorNumberAndSet: Finds a card with the specified collector_number and set. Note that collector numbers are strings.
public enum CollectionCardIdentifier {
    /// Finds a card with the specified Scryfall id.
    case id(String)
    
    /// Finds a card with the specified mtgo_id or mtgo_foil_id.
    case mtgoID(Int)
    
    /// Finds a card with the specified value among its multiverse_ids.
    case multiverseID(Int)
    
    /// Finds the newest edition of a card with the specified name.
    case name(String)
    
    /// Finds a card matching the specified name and set.
    case nameAndSet(String, String)
    
    /// Finds a card with the specified collector_number and set. Note that collector numbers are strings.
    case collectorNumberAndSet(String, String)
    
    
    func dict() -> [String: Any] {
        var dict = [String: Any]()
        
        switch self {
        case .id(let string):
            dict["id"] = string
        case .mtgoID(let int):
            dict["mtgo_id"] = int
        case .multiverseID(let int):
            dict["multiverse_id"] = int
        case .name(let string):
            dict["name"] = string
        case .nameAndSet(let name, let set):
            dict["name"] = name
            dict["set"] = set
        case .collectorNumberAndSet(let collectorNumber, let set):
            dict["collector_number"] = collectorNumber
            dict["set"] = set
        }
        
        return dict
    }
}
