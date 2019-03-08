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
            case .success(let list):
                print("Cards fetched: \(list.totalCards!)")
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
        
        var request = FulltextCardSearchRequest(search: "Pacifism")
        request.unique = .prints
        request.order = .released
        request.includeExtras = true
        request.includeMultilingual = true
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
    
    func testAutocompleteSearch() {
        let exp = self.expectation(description: "autocomplete")
        
        let cardName = "thal"
        let request = AutocompleteRequest(cardName: cardName)
        BaseAPIClient().send(request: request) { response in
            switch response {
            case .success(let catalog):
                print("Found \(catalog.total) autocompletes for \(cardName)")
            case .failure(let error):
                assertionFailure("Error: \(error)")
            }
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 5.0)
    }
    
    func testRandomCard() {
        let api = BaseAPIClient()
        
        let defRequest              = RandomCardRequest(search: nil, format: .json)
        let imageRequest            = RandomCardRequest(search: nil, format: .image((false, .png)))
        let textRequest             = RandomCardRequest(search: nil, format: .text)
        
        let search                  = "s:rna"
        let customImageRequest      = RandomCardRequest(search: search, format: .image((false, .png)))
        let customFulltextRequest   = RandomCardRequest(search: search, format: .text)
        
        
        let requests = [defRequest, imageRequest, customImageRequest, textRequest, customFulltextRequest]
        
        let exp = self.expectation(description: "testRandomCardExt")
        exp.expectedFulfillmentCount = requests.count
        

        let responseHandler: (Response<FormatResponse>) -> Void = { response in
            switch response {
            case .success(let data):
                switch data {
                case .card(let card):
                    print("Card: \(card.name)")
                    XCTAssert(card.name.count > 0)
                case .text(let text):
                    print("Card text: \(text)")
                    XCTAssert(text.count > 0)
                case .data(let data):
                    print("Data length: \(data.count)")
                    XCTAssert(data.count > 0)
                }
            case .failure(let error):
                XCTFail("Error: \(error)")
            }
            
            exp.fulfill()
        }
        
        requests.forEach  { api.send(request: $0, completion: responseHandler) }

        
        wait(for: [exp], timeout: 20.0)
    }
    
    func testNamedCardSearchRequest() {
        let textCardSearchReq = NamedCardSearchRequest(format: .text, name: .exact("Hydroid Krasis"), setCode: "rna")
        let jsonCardSearchReq = NamedCardSearchRequest(format: .json, name: .exact("Angel of Grace"), setCode: "rna")
        let imageCardSearchReq = NamedCardSearchRequest(format: .image(ImageConfig(false, .artCrop)), name: .exact("Cry of the Carnarium"), setCode: "rna")
        
        let requests = [textCardSearchReq, jsonCardSearchReq, imageCardSearchReq]
        
        let textCardExp = expectation(description: "TextCardSearchExp")
        textCardExp.expectedFulfillmentCount = requests.count

        let responseHandler: (Response<FormatResponse>) -> Void = { response in
            switch response {
            case .success(let data):
                switch data {
                case .card(let card):
                    print("Card: \(card.name)")
                    XCTAssert(card.name.count > 0)
                case .text(let text):
                    print("Card text: \(text)")
                    XCTAssert(text.count > 0)
                case .data(let data):
                    print("Data length: \(data.count)")
                    XCTAssert(data.count > 0)
                }
            case .failure(let error):
                XCTFail("Error: \(error)")
            }
            
            textCardExp.fulfill()
        }
        
        requests.forEach { BaseAPIClient().send(request: $0, completion: responseHandler) }
        
        wait(for: [textCardExp], timeout: 15.0)
    }
    
    func testMultiverseRequest() {
        let textCardSearchReq = MultiverseCardRequest(id: 409574, format: .text)
        let jsonCardSearchReq = MultiverseCardRequest(id: 409574, format: .json)
        let imageCardSearchReq = MultiverseCardRequest(id: 409574, format: .image((false, .artCrop)))
        
        let requests = [textCardSearchReq, jsonCardSearchReq, imageCardSearchReq]
        
        let textCardExp = expectation(description: "TextCardSearchExp")
        textCardExp.expectedFulfillmentCount = requests.count

        let responseHandler: (Response<FormatResponse>) -> Void = { response in
            switch response {
            case .success(let data):
                switch data {
                case .card(let card):
                    print("Card: \(card.name)")
                    XCTAssert(card.name.count > 0)
                case .text(let text):
                    print("Card text: \(text)")
                    XCTAssert(text.count > 0)
                case .data(let data):
                    print("Data length: \(data.count)")
                    XCTAssert(data.count > 0)
                }
            case .failure(let error):
                XCTFail("Error: \(error)")
            }
            
            textCardExp.fulfill()
        }
        
        requests.forEach { BaseAPIClient().send(request: $0, completion: responseHandler) }
        
        wait(for: [textCardExp], timeout: 15.0)
    }
}
