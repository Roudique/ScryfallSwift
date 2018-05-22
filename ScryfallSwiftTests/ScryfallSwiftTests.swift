//
//  ScryfallSwiftTests.swift
//  ScryfallSwiftTests
//
//  Created by Roudique on 5/8/18.
//

import XCTest
import ScryfallSwift

class ScryfallSwiftTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        var i = 0
        let urls = urlsForTestFiles()
        
        for url in urls {
            guard let jsonData = try? Data.init(contentsOf: url) else {
                assertionFailure()
                return
            }
            
            let jsonDecoder = JSONDecoder()
            let card = try? jsonDecoder.decode(Card.self, from: jsonData)

            assert(card != nil, "Card should not be nil. Looks like json wasn't parsed")

            print("Tried card with name: [\(card!.name)]")
            i += 1
        }
        
        print("Total cards tested: \(urls.count)")
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
    
    func urlsForTestFiles() -> [URL] {
        var urls = [URL]()
        let bundle = Bundle(for: type(of: self))

        var i = 0
        while let fileURL = bundle.url(forResource: "Test\(i)", withExtension: "json") {
            urls.append(fileURL)
            i += 1
        }
        
        return urls
    }
}
