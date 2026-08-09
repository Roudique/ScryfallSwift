//
//  RequestHeadersTests.swift
//  ScryfallSwiftTests
//

import Foundation
import XCTest
@testable import ScryfallSwift


class RequestHeadersTests: XCTestCase {
    /// Scryfall rejects requests that don't identify the client.
    func testDefaultHeadersAreSet() throws {
        let api = BaseAPIClient()
        let request = try XCTUnwrap(api.urlRequest(for: RandomCardRequest()))

        XCTAssertEqual(request.value(forHTTPHeaderField: "User-Agent"),
                       "ScryfallSwift/\(ScryfallSwiftVersion.current)")
        XCTAssertEqual(request.value(forHTTPHeaderField: "Accept"),
                       "application/json;q=0.9,*/*;q=0.8")
    }

    func testCustomUserAgentOverridesDefault() throws {
        let api = BaseAPIClient()
        api.userAgent = "MyApp/2.0"
        let request = try XCTUnwrap(api.urlRequest(for: RandomCardRequest()))

        XCTAssertEqual(request.value(forHTTPHeaderField: "User-Agent"), "MyApp/2.0")
    }

    /// A request carrying its own headers must add to the defaults, not replace them.
    func testRequestHeadersMergeWithDefaults() throws {
        let api = BaseAPIClient()
        let collection = CollectionRequest(identifiers: [.id("0000579f-7b35-4ed3-b44c-db2a538066fe")])
        let request = try XCTUnwrap(api.urlRequest(for: collection))

        XCTAssertEqual(request.value(forHTTPHeaderField: "Content-Type"), "application/json")
        XCTAssertEqual(request.value(forHTTPHeaderField: "User-Agent"),
                       "ScryfallSwift/\(ScryfallSwiftVersion.current)")
        XCTAssertNotNil(request.value(forHTTPHeaderField: "Accept"))
    }
}
