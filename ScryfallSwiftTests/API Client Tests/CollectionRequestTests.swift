//
//  CollectionRequestTests.swift
//  ScryfallSwiftTests
//
//  Created by Roudique on 3/5/19.
//

import XCTest

class CollectionRequestTests: XCTestCase {
    let lineBrake = "======================================================================================"
    
    override func setUp() {
        print(lineBrake)
    }
    
    override func tearDown() {
        print(lineBrake)
    }

    func testRequest() {
        let exp = expectation(description: "collectionRequestExp")
        
        let collectionRequest = CollectionRequest.init(identifiers:
            [.id("683a5707-cddb-494d-9b41-51b4584ded69"),
             .mtgoID(39912),
             .multiverseID(394636),
             .name("Ancient Tomb"),
             .nameAndSet("Festering Goblin", "9ed"),
             .collectorNumberAndSet("150", "mrd")])
        BaseAPIClient().send(request: collectionRequest) { response in
            switch response {
            case .success(let cardData):
                XCTAssert(cardData.cards.count == 6)
                for card in cardData.cards {
                    print("Card: \(card.name)")
                }
            case .failure(let error):
                XCTFail("Error fetching collection request: \(error)")
            }
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 5.0)
    }
}
