//
//  CardSetTests.swift
//  ScryfallSwiftTests
//
//  Created by Alex Rudavka on 2022-04-02.
//

import XCTest
import ScryfallSwift

fileprivate let validSetJSON =
"""
{
    "object": "set",
    "id": "a60124f9-8002-4769-ac16-387b61fa2bc6",
    "code": "tunf",
    "name": "Unfinity Tokens",
    "uri": "https://api.scryfall.com/sets/a60124f9-8002-4769-ac16-387b61fa2bc6",
    "scryfall_uri": "https://scryfall.com/sets/tunf",
    "search_uri": "https://api.scryfall.com/cards/search?order=set&q=e%3Atunf&unique=prints",
    "released_at": "2022-12-31",
    "set_type": "token",
    "card_count": 0,
    "parent_set_code": "unf",
    "digital": false,
    "nonfoil_only": true,
    "foil_only": true,
    "icon_svg_uri": "https://c2.scryfall.com/file/scryfall-symbols/sets/unf.svg?1648440000"
}
"""

fileprivate let invalidSetJSON =
"""
{
    "object": "set",
    "id": "b314f553-8f07-4ba9-96c8-16be7784eff3",
    "code": "unf",
    "tcgplayer_id": 2958,
    "name": "Unfinity",
    "uri": "https://api.scryfall.com/sets/b314f553-8f07-4ba9-96c8-16be7784eff3",
    "scryfall_uri": "https://scryfall.com/sets/unf",
    "search_uri": "https://api.scryfall.com/cards/search?order=set&q=e%3Aunf&unique=prints",
    "released_at": "2022-12-31",
    "set_type": "INVALID",
    "card_count": 26,
    "digital": false,
    "nonfoil_only": false,
    "foil_only": false,
    "icon_svg_uri": "https://c2.scryfall.com/file/scryfall-symbols/sets/unf.svg?1648440000"
}
"""

class CardSetTests: XCTestCase {
    func testSetType() {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        let validSet = try! decoder.decode(CardSet.self, from: validSetJSON.data(using: .utf8)!)
        if let setType = validSet.setType.value {
            XCTAssertTrue(setType == .token)
        } else {
            XCTFail("set type is nil")
        }
        let invalidSet = try! decoder.decode(CardSet.self, from: invalidSetJSON.data(using: .utf8)!)
        XCTAssertNil(invalidSet.setType.value)
    }

}
