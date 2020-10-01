//
//  CardModelTests.swift
//  ScryfallSwiftTests
//
//  Created by Roudique on 30.09.2020.
//

import XCTest
import ScryfallSwift

class CardModelTests: XCTestCase {
    let api = BaseAPIClient()
    
    private func fetchCard(named: String, completion: @escaping (Card?) -> Void) {
        let request = NamedCardSearchRequest(format: .json, name: .exact(named))
        api.send(request: request) { response in
            switch response {
            case .success(let data):
                guard case .card(let card) = data else {
                    completion(nil)
                    return
                }

                completion(card)
            case .failure:
                completion(nil)
            }
        }
    }
    
    func testKeywordsExist() {
        let exp = expectation(description: "Card")
        fetchCard(named: "Serra Angel") { card in
            XCTAssertEqual(card!.keywords.count, 2)
            XCTAssertEqual(card!.keywords[0], "Flying")
            XCTAssertEqual(card!.keywords[1], "Vigilance")
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 10)
    }
    
    func testKeywordsAreEmpty() {
        let exp = expectation(description: "card with no keywords")
        fetchCard(named: "Archpriest of Iona") { card in
            XCTAssertEqual(card!.keywords.count, 0)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 10)
    }
    
    func testContentWarning() {
        let exp = expectation(description: "card with warning")
        fetchCard(named: "Pradesh Gypsies") { card in
            XCTAssertEqual(card!.contentWarning, true)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 10)
    }
    
    func testProducedManaCards() {
        let exp1 = expectation(description: "exp 1")
        let exp2 = expectation(description: "exp 2")
        let exp3 = expectation(description: "exp 3")
        let exp4 = expectation(description: "exp 4")
        let exp5 = expectation(description: "exp 5")
        
        fetchCard(named: "Lotus Cobra") { card in
            XCTAssertEqual(card!.producedMana?.count, 5)
            exp1.fulfill()
        }
        
        fetchCard(named: "Forest") { card in
            XCTAssertEqual(card!.producedMana?.count, 1)
            XCTAssertEqual(card!.producedMana!.first, .green)
            exp2.fulfill()
        }
        
        fetchCard(named: "Llanowar Elves") { card in
            XCTAssertEqual(card!.producedMana?.count, 1)
            XCTAssertEqual(card!.producedMana!.first, .green)
            exp3.fulfill()
        }
        
        fetchCard(named: "Knight of New Benalia") { card in
            XCTAssertEqual(card!.producedMana, nil)
            exp4.fulfill()
        }
        
        fetchCard(named: "Narset of the Ancient Way") { card in
            XCTAssertEqual(card!.producedMana?.count, 3)
            exp5.fulfill()
        }
        
        wait(for: [exp1, exp2, exp3, exp4, exp5], timeout: 25)
    }

    func testFlavorName() {
        let exp1 = expectation(description: "exp 1")
        let exp2 = expectation(description: "exp 2")
        
        fetchCard(named: "Yidaro, Wandering Monster") { card in
            XCTAssertEqual(card!.flavorName, nil)
            XCTAssertEqual(card!.printedName, nil)
            exp1.fulfill()
        }
        
        // Godzilla
        let request = IdentityCardRequest(
            identifier: .scryfall("8bb6b4c7-4f18-4bea-b927-916c7bb987ee"), format: .json)
        api.send(request: request) { response in
            switch response {
            case .success(let data):
                guard case .card(let card) = data else {
                    XCTFail()
                    return
                }
                
                XCTAssertEqual(card.flavorName?.isEmpty, false)
                XCTAssertEqual(card.printedName?.isEmpty, false)
                XCTAssertEqual(card.flavorName, card.printedName)
                exp2.fulfill()
            case .failure:
                XCTFail()
            }
        }
        
        wait(for: [exp1, exp2], timeout: 10)
    }
    
    func testModalDFCLayout() {
        let exp = expectation(description: "exp")
        
        fetchCard(named: "Spikefield Hazard") { card in
            XCTAssertEqual(card?.cardFaces?.count, 2)
            XCTAssertEqual(card?.layout, CardLayout.modalDFC)
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 10)
    }
}
