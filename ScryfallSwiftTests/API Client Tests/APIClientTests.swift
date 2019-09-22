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
        
        var request = FulltextCardSearchRequest(query: "s:rna")
        request.unique = .prints
        request.order = .released

        apiClient.send(request: request) { response in
            switch response {
            case .success(let cards):
                print("Cards fetched: \(cards.totalCards!)")
                assert(cards.totalCards! > 0)
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
        
        let defRequest              = RandomCardRequest()
        let imageRequest            = RandomCardRequest(search: nil, format: .image((false, .png)))
        let textRequest             = RandomCardRequest(search: nil, format: .text)
        
        let search                  = "s:eld"
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
        let textCardSearchReq = NamedCardSearchRequest(format: .text, name: .exact("Domri's Nodorog"), setCode: "rna")
        let jsonCardSearchReq = NamedCardSearchRequest(format: .json, name: .exact("The Haunt of Hightower"), setCode: "rna")
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
    
    func testIdentityCardRequest() {
        let codeNumberCardRequests = [
            IdentityCardRequest(identifier: .setCodeCollectorNumberAndLang("xln", 96, nil), format: .json),
            IdentityCardRequest(identifier: .setCodeCollectorNumberAndLang("xln", 96, nil), format: .text),
            IdentityCardRequest(identifier: .setCodeCollectorNumberAndLang("xln", 96, nil), format: .image((false, .png))),
            IdentityCardRequest(identifier: .setCodeCollectorNumberAndLang("xln", 250, "ru"), format: .json),
            IdentityCardRequest(identifier: .setCodeCollectorNumberAndLang("xln", 250, "ru"), format: .text),
            IdentityCardRequest(identifier: .setCodeCollectorNumberAndLang("xln", 250, "ru"), format: .image((true, .png)))
        ]
        
        let multiverseCardRequests = [
            IdentityCardRequest(identifier: .multiverse(435244), format: .json),
            IdentityCardRequest(identifier: .multiverse(435244), format: .text),
            IdentityCardRequest(identifier: .multiverse(435244), format: .image((false, .png)))
        ]
        
        let mtgoCardRequests = [
            IdentityCardRequest(identifier: .mtgo(67845), format: .json),
            IdentityCardRequest(identifier: .mtgo(67845), format: .text),
            IdentityCardRequest(identifier: .mtgo(67845), format: .image((false, .png)))
        ]
        
        let arenaCardRequests = [
            IdentityCardRequest(identifier: .arena(68806), format: .json),
            IdentityCardRequest(identifier: .arena(68806), format: .text),
            IdentityCardRequest(identifier: .arena(68806), format: .image((false, .png))),
            IdentityCardRequest(identifier: .arena(64533), format: .json),
            IdentityCardRequest(identifier: .arena(64533), format: .text),
            IdentityCardRequest(identifier: .arena(64533), format: .image((false, .png)))
        ]
        
        let tcgplayerCardRequests = [
            // Fetch Rona, Disciple of Gix, from Dominaria
            IdentityCardRequest(identifier: .tcgplayer(162145), format: .json),
            IdentityCardRequest(identifier: .tcgplayer(162145), format: .text),
            IdentityCardRequest(identifier: .tcgplayer(162145), format: .image((false, .png))),
            // Fetch Treasure Map, from Ixalan
            IdentityCardRequest(identifier: .tcgplayer(144537), format: .image((true, .png))),
        ]
        
        let scryfallCardRequests = [
            // Fetch Forest, from MagicFest 2019
            IdentityCardRequest(identifier: .scryfall("7704ed07-aae8-4796-931c-a071aee1e8a4"), format: .json),
            IdentityCardRequest(identifier: .scryfall("7704ed07-aae8-4796-931c-a071aee1e8a4"), format: .text),
            IdentityCardRequest(identifier: .scryfall("7704ed07-aae8-4796-931c-a071aee1e8a4"), format: .image((false, .png))),
            // Fetch Treasure Map, from Ixalan (back)
            IdentityCardRequest(identifier: .scryfall("c0f9c733-0818-4a03-8f0c-a163d09e0fff"), format: .image((true, .png)))
        ]
        
        let requests = [codeNumberCardRequests,
                        multiverseCardRequests,
                        mtgoCardRequests,
                        arenaCardRequests,
                        tcgplayerCardRequests,
                        scryfallCardRequests]
            .flatMap { $0 }

        
        let exp = expectation(description: "IdentityCardRequestExp")
        exp.expectedFulfillmentCount = requests.count

        let responseHandler: (Response<FormatResponse>) -> Void = { response in
            switch response {
            case .success(let data):
                switch data {
                case .card(let card):
                    if let printedName = card.printedName {
                        print("\tPrinted card name: \(printedName)")
                    } else {
                        print("\tCard: \(card.name)")
                    }
                    XCTAssert(card.name.count > 0)
                case .text(let text):
                    print("\tCard text: \(text)")
                    XCTAssert(text.count > 0)
                case .data(let data):
                    print("\tData length: \(data.count)")
                    XCTAssert(data.count > 0)
                }
            case .failure(let error):
                XCTFail("Error: \(error)")
            }
            
            exp.fulfill()
        }

        requests.forEach { BaseAPIClient().send(request: $0, completion: responseHandler) }
        
        wait(for: [exp], timeout: 30.0)
    }
    
    func testRulingsRequest() {
        let requests = [
            // Fetch rulings for Lion’s Eye Diamond
            RulingsRequest(identifier: .multiverse(3255)),
            // Fetch rulings for Demonic Pact
            RulingsRequest(identifier: .mtgo(57934)),
            // Fetch rulings for Song of Freyalise
            RulingsRequest(identifier: .arena(67462)),
            // Retrieve rulings for Mana Drain
            RulingsRequest(identifier: .setCodeCollectorNumberAndLang("ima", 65, nil)),
            // Fetch rulings for Falling Star
            RulingsRequest(identifier: .scryfall("f2b9983e-20d4-4d12-9e2c-ec6d9a345787")),
            // Fetch rulings for Unmoored Ego (should be zero)
            RulingsRequest(identifier: .scryfall("95aecc12-3363-41f7-9b58-277c81859670")),
        ]
        
        let exp = expectation(description: "testRulingsRequestExp")
        exp.expectedFulfillmentCount = requests.count
        
        let responseHandler: (Response<List<CardRuling>>) -> Void = { response in
            switch response {
            case .success(let rulings):
                print("Rulings count: \(rulings.data.count)")
                for ruling in rulings.data {
                    print("\t \(ruling.comment)")
                }
                print("\n")
            case .failure(let error):
                XCTFail("Error: \(error)")
            }
            
            exp.fulfill()
        }
        
        requests.forEach { BaseAPIClient().send(request: $0, completion: responseHandler) }
        
        wait(for: [exp], timeout: 30.0)
    }
    
    func testAllSymbologyRequest() {
        let request = AllSymbologyRequest()
        let exp = expectation(description: "testAllSymbologyRequestExp")
        
        BaseAPIClient().send(request: request) { response in
            switch response {
            case .success(let symbologyList):
                print("Total symbologies: \(symbologyList.data.count)")
            case .failure(let error):
                XCTFail("Error: \(error)")
            }
            
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 10.0)
    }
    
    func testCatalogRequest() {
        let requests = [
            CatalogRequest(type: .cardNames),
            CatalogRequest(type: .artistNames),
            CatalogRequest(type: .wordBank),
            CatalogRequest(type: .creatureTypes),
            CatalogRequest(type: .planeswalkerTypes),
            CatalogRequest(type: .landTypes),
            CatalogRequest(type: .artifactTypes),
            CatalogRequest(type: .enchantmentTypes),
            CatalogRequest(type: .spellTypes),
            CatalogRequest(type: .powers),
            CatalogRequest(type: .toughnesses),
            CatalogRequest(type: .loyalties),
            CatalogRequest(type: .watermarks),
        ]
        let exp = expectation(description: "testCatalogRequestExp")
        exp.expectedFulfillmentCount = requests.count
        
        let responseHandler: (Response<Catalog>) -> Void = { response in
            switch response {
            case .success(let catalog):
                print("Catalog with \(catalog.total) entries.")
                XCTAssert(catalog.total > 0)
                XCTAssert(catalog.data.count == catalog.total)
            case .failure(let error):
                XCTFail("Error: \(error)")
            }
            
            exp.fulfill()
        }
        
        requests.forEach { BaseAPIClient().send(request: $0, completion: responseHandler) }
        
        wait(for: [exp], timeout: Double(requests.count) * 3.0)
    }
}
