//
//  CancellableTests.swift
//  ScryfallSwiftTests
//
//  Created by Roudique on 01.05.2020.
//

import XCTest
import ScryfallSwift

class CancellableTests: XCTestCase {
    var api = BaseAPIClient()

    func testCancellableNoResponseIfCancelled() {
        let request = AllCardsRequest()
        let exp = expectation(description: "exp")
        var didFinishRequest = false
        
        let task = api.send(request: request) { response in
            print("Finishing request.")
            didFinishRequest = true
        }
        task!.cancel()
        
        let queue = DispatchQueue(label: "com.roudique.cancellable")
        queue.asyncAfter(deadline: .now() + .seconds(8)) {
            print("Checking request: \(didFinishRequest)")
            if !didFinishRequest {
                exp.fulfill()
            }
        }
        
        wait(for: [exp], timeout: 10)
    }
}
