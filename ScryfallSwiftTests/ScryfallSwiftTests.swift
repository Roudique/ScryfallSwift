//
//  ScryfallSwiftTests.swift
//  ScryfallSwiftTests
//
//  Created by Roudique on 5/8/18.
//

import XCTest
import ScryfallSwift


class ScryfallSwiftTests: XCTestCase {
    let lineBrake = "======================================================================================"
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        print(lineBrake)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        print(lineBrake)
    }
    
    func testCards() {
//        var i = 0
//        let urls = urlsForCardTestFiles()
//
//        print("\nStarted testing cards")
//
//        for url in urls {
//            guard let jsonData = try? Data.init(contentsOf: url) else {
//                assertionFailure()
//                return
//            }
//
//            let jsonDecoder = JSONDecoder()
//            let card = try? jsonDecoder.decode(Card.self, from: jsonData)
//
//            assert(card != nil, "Card should not be nil. Looks like json wasn't parsed")
//
//            print("Testing card with name: [\(card!.name)]...")
//            i += 1
//        }
//
//        print("\nFinished testing cards. Total cards tested: \(urls.count)")
    }
    
    func testSets() {
//        let url = urlForSetTestFile()
//
//        print("Started testing sets")
//
//        guard let jsonData = try? Data.init(contentsOf: url) else {
//            assertionFailure()
//            return
//        }
//
//        let jsonDecoder = JSONDecoder()
//        guard let sets = try? jsonDecoder.decode([CardSet].self, from: jsonData) else {
//            assertionFailure("Sets should not be nil. Looks like json wasn't parsed correctly.")
//            return
//        }
//
//        print("Total sets tested: \(sets.count)")
    }
    
    func testRulings() {
        let url = urlForRulingsTestFile()
        
        print("Started testing rulings")

        guard let jsonData = try? Data.init(contentsOf: url) else {
            assertionFailure()
            return
        }

        let jsonDecoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        do {
            let rulings = try jsonDecoder.decode([CardRuling].self, from: jsonData)
            print("Total rulings tested: \(rulings.count)")
        } catch {
            assertionFailure("Error: \(error)")
        }
    }
    
    func testSymbology() {
        let url = urlForSymbologyTestFile()
        
        print("Started testing symbology")
        
        guard let jsonData = try? Data.init(contentsOf: url) else {
            assertionFailure()
            return
        }
        
        let jsonDecoder = JSONDecoder()
        
        do {
            let symbologies = try jsonDecoder.decode([CardSymbol].self, from: jsonData)
            
            print("Total symbologies tested: \(symbologies.count)")
        } catch {
            assertionFailure("Symbologies should not be nil. Looks like json wasn't parsed correctly: \(error)")
        }
    }
    
    func testList() {
//        let urls = urlsForListTestFile()
//
//        print("Started testing List")
//
//        var jsonDatas = [Data]()
//
//        urls.forEach { url in
//            jsonDatas.append(try! Data(contentsOf: url))
//        }
//
//        let jsonDecoder = JSONDecoder()
//
//        do {
//            for jsonData in jsonDatas {
//                let index = jsonDatas.index(of: jsonData)!
//                if index == 0 || index == 1 {
//                    let list = try jsonDecoder.decode(List<Card>.self, from: jsonData)
//                    print("\tTotal cards in list: \(list.data.count)")
//                } else if index == 2 {
//                    let list = try jsonDecoder.decode(List<CardSet>.self, from: jsonData)
//                    print("\tTotal sets in list: \(list.data.count)")
//                } else if index == 3 {
//                    let list = try jsonDecoder.decode(List<CardRuling>.self, from: jsonData)
//                    print("\tTotal rulings in list: \(list.data.count)")
//                } else if index == 4 {
//                    let list = try jsonDecoder.decode(List<CardSymbol>.self, from: jsonData)
//                    print("\tTotal symbologies in list: \(list.data.count)")
//                }
//
//            }
//        } catch {
//            print("Error thrown: \(error)")
//            assertionFailure("Error during decoding the list.")
//        }
    }
    
    func testAllSetsRequest() {
        let apiManager = BaseAPIClient()

        let exp  = expectation(description: "testAllSetsRequestExp")

        apiManager.send(request: AllSetsRequest()) { response in
            switch response {
            case .success(let scryfallData):
                print("There is data for all sets: \(scryfallData.data.count) lists returned")
                print(self.lineBrake)
            case .failure(let error):
                assertionFailure("Error during testing all sets request all sets: \(error)")
            }

            exp.fulfill()
        }

        wait(for: [exp], timeout: 8.0)
    }
    
    func testSetRequest() {
        let setRequests = [
            // Fetch Ravnica Allegiances
            SetRequest(identifier: .code("rna")),
            // Fetch Ultimate Masters Tokens
            SetRequest(identifier: .scryfallID("804240d7-957c-4860-a684-d3d51dfe1c77")),
            // Fetch You Make The Cube (pz2)
            SetRequest(identifier: .scryfallID("2661b143-8eac-4c73-9d93-549fe928bd96")),
            //Fetch HarperPrism Book Promos (PHPR)
            SetRequest(identifier: .code("PHPR")),
            // Fetch Amonkhet Invocations
            SetRequest(identifier: .tcgplayerID(1909))
        ]
        
        let exp = expectation(description: "testSetRequestExp")
        exp.expectedFulfillmentCount = setRequests.count
        
        let responseHandler: (Response<CardSet>) -> Void = { response in
            switch response {
            case .success(let set):
                print("There is set: \(set.name) with \(set.cardCount) cards.")
            case .failure(let error):
                XCTFail("Error: \(error)")
            }
            exp.fulfill()
        }
        
        setRequests.forEach { BaseAPIClient().send(request: $0, completion: responseHandler) }
        
        wait(for: [exp], timeout: 15.0)
    }
    
    func testCollectionRequest() {
        let apiClient = BaseAPIClient()
        
        let collectionReqExp = self.expectation(description: "collectionReqExp")
        
        let identifiers = [CollectionCardIdentifier.id("683a5707-cddb-494d-9b41-51b4584ded69"),
                           CollectionCardIdentifier.name("Ancient Tomb"),
                           CollectionCardIdentifier.collectorNumberAndSet("150", "mrd")]
        let request = CollectionRequest.init(identifiers: identifiers)
        apiClient.send(request: request) { response in
            switch response {
            case .success(let list):
                assert(list.cards.count == 3, "There is mismatch in card count returned by collection request.")
                print("There are \(list.cards.count) card for collectionRequest.")
                list.cards.forEach { print("Found: \($0.name)") }
            case .failure(let error):
                assertionFailure("Error during testing collection request: \(error)")
            }
            
            collectionReqExp.fulfill()
        }
        
        wait(for: [collectionReqExp], timeout: 20.0)
    }
    
    
    //MARK: - Utils
    
    func compareJSONs(first firstName: String, secondName: String) -> Set<String>? {
        let bundle = Bundle(for: type(of: self))
        guard let firstFileURL = bundle.url(forResource: firstName, withExtension: "json") else { return nil }
        guard let secondFileURL = bundle.url(forResource: secondName, withExtension: "json") else { return nil }
        
        guard let firstJSONData = try? Data.init(contentsOf: firstFileURL) else { return nil }
        guard let secondJSONData = try? Data.init(contentsOf: secondFileURL) else { return nil }

        guard let firstDict = try? JSONSerialization.jsonObject(with: firstJSONData, options: []) as? [String: Any] else { return nil }
        guard let secondDict = try? JSONSerialization.jsonObject(with: secondJSONData, options: []) as? [String: Any] else { return nil }

        guard let firstKeys = firstDict?.keys else { return nil }
        guard let secondKeys = secondDict?.keys else { return nil }
        
        return Set<String>.init(firstKeys).symmetricDifference(Set<String>.init(secondKeys))
    }
    
    func urlsForCardTestFiles() -> [URL] {
        var urls = [URL]()
        let bundle = Bundle(for: type(of: self))

        var i = 0
        while let fileURL = bundle.url(forResource: "CardTest\(i)", withExtension: "json") {
            urls.append(fileURL)
            i += 1
        }
        
        return urls
    }
    
    func urlForSetTestFile() -> URL {
        let bundle = Bundle(for: type(of: self))
        
        let fileURL = bundle.url(forResource: "SetsTest", withExtension: "json")!
        
        return fileURL
    }
    
    func urlForRulingsTestFile() -> URL {
        let bundle = Bundle(for: type(of: self))
        
        let fileURL = bundle.url(forResource: "RulingsTest", withExtension: "json")!
        
        return fileURL
    }
    
    func urlForSymbologyTestFile() -> URL {
        let bundle = Bundle(for: type(of: self))
        
        let fileURL = bundle.url(forResource: "SymbologyTest", withExtension: "json")!
        
        return fileURL
    }
    
    func urlsForListTestFile() -> [URL] {
        var urls = [URL]()
        let bundle = Bundle(for: type(of: self))
        
        var i = 0
        while let fileURL = bundle.url(forResource: "ListTest\(i)", withExtension: "json") {
            urls.append(fileURL)
            i += 1
        }
        
        return urls
    }
}
