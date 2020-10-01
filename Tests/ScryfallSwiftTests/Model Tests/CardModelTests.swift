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

}
