//
//  Cancellable.swift
//  ScryfallSwift
//
//  Created by Roudique on 01.05.2020.
//

import Foundation

public protocol Cancellable {
    func cancel()
}

extension URLSessionDataTask: Cancellable {}
