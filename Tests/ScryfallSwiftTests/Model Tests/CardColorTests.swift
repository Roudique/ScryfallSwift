//
//  CardColorTests.swift
//  ScryfallSwiftTests
//
//  Created by Roudique on 03.10.2020.
//

import XCTest
import ScryfallSwift

class CardColorTests: XCTestCase {
    func testComparable() {
        // Regular order
        XCTAssert(CardColor.white < CardColor.blue)
        XCTAssert(CardColor.blue < CardColor.black)
        XCTAssert(CardColor.black < CardColor.red)
        XCTAssert(CardColor.red < CardColor.green)
        XCTAssert(CardColor.green < CardColor.colorless)

        
        // white
        XCTAssert(CardColor.white < CardColor.black)
        XCTAssert(CardColor.white < CardColor.red)
        XCTAssert(CardColor.white < CardColor.green)
        XCTAssert(CardColor.white < CardColor.colorless)

        // blue
        XCTAssert(CardColor.blue > CardColor.white)
        XCTAssert(CardColor.blue < CardColor.red)
        XCTAssert(CardColor.blue < CardColor.green)
        XCTAssert(CardColor.blue < CardColor.colorless)

        // black
        XCTAssert(CardColor.black > CardColor.white)
        XCTAssert(CardColor.black > CardColor.blue)
        XCTAssert(CardColor.black < CardColor.green)
        XCTAssert(CardColor.black < CardColor.colorless)

        // red
        XCTAssert(CardColor.red > CardColor.white)
        XCTAssert(CardColor.red > CardColor.blue)
        XCTAssert(CardColor.red > CardColor.black)
        XCTAssert(CardColor.red < CardColor.green)
        XCTAssert(CardColor.red < CardColor.colorless)

        // green
        XCTAssert(CardColor.green > CardColor.white)
        XCTAssert(CardColor.green > CardColor.blue)
        XCTAssert(CardColor.green > CardColor.black)
        XCTAssert(CardColor.green > CardColor.red)
        XCTAssert(CardColor.green < CardColor.colorless)
    }
}
