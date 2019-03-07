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
        let defRandomRequestExp = self.expectation(description: "defaultRandomRequest")
        let imageRandomRequestExp = self.expectation(description: "imageRandomRequestExp")
        let customImageRequestExp = self.expectation(description: "customImageRequestExp")

        let api                 = BaseAPIClient()
        
        let defRequest          = RandomCardRequest()
        let imageRequest        = RandomCardImageRequest.init(imageConfig: (false, .png))
        
        let fulltextRequest     = FulltextCardSearchRequest(search: "s:grn")
        let customImageRequest  = RandomCardImageRequest.init(imageConfig: (false, .png), fulltextCardRequest: fulltextRequest)
        
        api.send(request: defRequest) { response in
            switch response {
            case .success(let card):
                print(card.name)
            case .failure(let error):
                assertionFailure("Error: \(error)")
            }
            defRandomRequestExp.fulfill()
        }
        
        api.send(request: imageRequest) { response in
            switch response {
            case .success(let imageData):
                assert(imageData.count > 0, "Image data is empty")
            case .failure(let error):
                assertionFailure("Error: \(error)")
            }
            imageRandomRequestExp.fulfill()
        }
        
        api.send(request: customImageRequest) { response in
            switch response {
            case .success(let imageData):
                assert(imageData.count > 0, "Image data is empty")
            case .failure(let error):
                assertionFailure("Error: \(error)")
            }
            customImageRequestExp.fulfill()
        }
        
        wait(for: [defRandomRequestExp, imageRandomRequestExp, customImageRequestExp], timeout: 20.0)
    }
    
    func testNamedCardSearchRequest() {
        let textCardExp = expectation(description: "TextCardSearchExp")
        textCardExp.expectedFulfillmentCount = 3
        
        let textCardSearchReq = NamedCardSearchRequest(format: .text, name: .exact("Hydroid Krasis"), setCode: "rna")
        let jsonCardSearchReq = NamedCardSearchRequest(format: .json, name: .exact("Angel of Grace"), setCode: "rna")
        let imageCardSearchReq = NamedCardSearchRequest(format: .image(ImageConfig(false, .artCrop)), name: .exact("Cry of the Carnarium"), setCode: "rna")
        
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
        
        BaseAPIClient().send(request: textCardSearchReq, completion: responseHandler)
        BaseAPIClient().send(request: jsonCardSearchReq, completion: responseHandler)
        BaseAPIClient().send(request: imageCardSearchReq, completion: responseHandler)
        
        wait(for: [textCardExp], timeout: 15.0)
    }
}
