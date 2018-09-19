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
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCards() {
        var i = 0
        let urls = urlsForCardTestFiles()
        
        print("\(lineBrake)\nStarted testing cards")

        for url in urls {
            guard let jsonData = try? Data.init(contentsOf: url) else {
                assertionFailure()
                return
            }
            
            let jsonDecoder = JSONDecoder()
            let card = try? jsonDecoder.decode(Card.self, from: jsonData)

            assert(card != nil, "Card should not be nil. Looks like json wasn't parsed")
            
            print("Testing card with name: [\(card!.name)]...")
            i += 1
        }
        
        print("\(lineBrake)\nFinished testing cards. Total cards tested: \(urls.count)")
        print(lineBrake)
    }
    
    func testSets() {
        let url = urlForSetTestFile()
        
        print(lineBrake)
        print("Started testing sets")
        
        guard let jsonData = try? Data.init(contentsOf: url) else {
            assertionFailure()
            return
        }
        
        let jsonDecoder = JSONDecoder()
        guard let sets = try? jsonDecoder.decode([CardSet].self, from: jsonData) else {
            assertionFailure("Sets should not be nil. Looks like json wasn't parsed correctly.")
            return
        }
        
        print(lineBrake)
        print("Total sets tested: \(sets.count)")
        print(lineBrake)
    }
    
    func testRulings() {
        let url = urlForRulingsTestFile()
        
        print(lineBrake)
        print("Started testing rulings")
        
        guard let jsonData = try? Data.init(contentsOf: url) else {
            assertionFailure()
            return
        }
        
        let jsonDecoder = JSONDecoder()
        guard let rulings = try? jsonDecoder.decode([Ruling].self, from: jsonData) else {
            assertionFailure("Rulings should not be nil. Looks like json wasn't parsed correctly.")
            return
        }
        
        print(lineBrake)
        print("Total rulings tested: \(rulings.count)")
        print(lineBrake)
    }
    
    func testSymbology() {
        let url = urlForSymbologyTestFile()
        
        print(lineBrake)
        print("Started testing symbology")
        
        guard let jsonData = try? Data.init(contentsOf: url) else {
            assertionFailure()
            return
        }
        
        let jsonDecoder = JSONDecoder()
        
        do {
            let symbologies = try jsonDecoder.decode([CardSymbol].self, from: jsonData)
            
            print(lineBrake)
            print("Total symbologies tested: \(symbologies.count)")
            print(lineBrake)
        } catch {
            assertionFailure("Symbologies should not be nil. Looks like json wasn't parsed correctly: \(error)")
        }
    }
    
    func testList() {
        let urls = urlsForListTestFile()
        
        print(lineBrake)
        print("Started testing List")
        
        var jsonDatas = [Data]()
        
        urls.forEach { url in
            jsonDatas.append(try! Data(contentsOf: url))
        }
        
        let jsonDecoder = JSONDecoder()
        
        do {
            try jsonDatas.forEach { data in
                let list = try jsonDecoder.decode(List.self, from: data)
                print("List #\(jsonDatas.index(of: data)!)")
                switch list.data {
                case .cards(let cards):
                    print("\tTotal cards in list: \(cards.count)")
                case .sets(let sets):
                    print("\tTotal sets in list: \(sets.count)")
                }
            }
        } catch {
            assertionFailure("List should not be nil: \(error)")
        }
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
