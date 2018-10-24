//
//  APIClientTests.swift
//  ScryfallSwiftTests
//
//  Created by Roudique on 10/14/18.
//

import XCTest

class APIClientTests: XCTestCase {
    let lineBrake = "======================================================================================"

    override func setUp() {
        print(lineBrake)
    }

    override func tearDown() {
        print(lineBrake)
    }

    func testAllCardsRequest() {
        let apiClient = BaseAPIClient()
        
        let expectation = self.expectation(description: "allCards")
        
        apiClient.send(request: AllCardsRequest()) { response in
            switch response {
            case .success(let cards):
                print("Cards fetched: \(cards.totalCards!)")
            case .failure(let error):
                assertionFailure("Failed to fetch all cards: \(error)")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 15.0)
    }
    
    func testFulltextSearch() {
        let apiClient = BaseAPIClient()
        
        let expectation = self.expectation(description: "fulltextSearch")
        
        let request = FulltextCardSearchRequest(search: "Pacifism", unique: .prints, order: .released, sortDirection: .auto, includeExtras: true, includeMultilingual: true)
        apiClient.send(request: request) { response in
            switch response {
            case .success(let cards):
                print("Cards fetched: \(cards.totalCards!)")
                
                cards.data.forEach {
                    let type    = $0.typeLine ?? ""
                    let flavor  = $0.flavorText ?? ""
                    print("Card: \($0.name) [\(type)] \(flavor)")
                }
            case .failure(let error):
                assertionFailure("Failed to fetch all cards: \(error)")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 15.0)
    }
    
    func testNamedSearch() {
        let apiClient = BaseAPIClient()
        
        let expectation = self.expectation(description: "namedSearch")
        let imageExp = self.expectation(description: "imageSearch")
        let textExp = self.expectation(description: "textNamedSearch")
        
        let request = NamedCardSearchRequest.init(name: .fuzzy("nicol bolas ravager"), setCode: nil)
        apiClient.send(request: request) { response in
            switch response {
            case .success(let card):
                print("Card by named search: \(card.name)")
            case .failure(let error):
                assertionFailure("Error: \(error)")
            }
            expectation.fulfill()
        }
        
        let imageRequest = NamedImageCardSearchRequest.init(name: .fuzzy("nicol bolas ravager"), setCode: nil, backFace: true, imageVersion: .png)
        apiClient.send(request: imageRequest) { response in
            switch response {
            case .success(let imageData):
                assert(imageData.count > 0, "Image data is empty")
            case .failure(let error):
                assertionFailure("Error: \(error)")
            }
            imageExp.fulfill()
        }
        
        let textNamedRequest = NamedTextCardSearchRequest.init(name: .fuzzy("nicol bolas ravager"), setCode: nil)
        apiClient.send(request: textNamedRequest) { response in
            switch response {
            case .success(let cardText):
                print(cardText)
            case .failure(let error):
                assertionFailure("Error: \(error)")
            }
            textExp.fulfill()
        }
        
        wait(for: [expectation, imageExp, textExp], timeout: 20.0)
    }
}
