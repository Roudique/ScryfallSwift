//
//  FormatResponse.swift
//  ScryfallSwift
//
//  Created by Roudique on 3/9/19.
//

import Foundation


public enum FormatDecodeError: Error {
    case invalidData
}

public enum FormatResponse: Decodable {
    public init(from decoder: Decoder) throws {
        if let card = try? Card(from: decoder) {
            self = .card(card)
        } else if let text = try? String(from: decoder) {
            self = .text(text)
        } else if let data = try? Data(from: decoder) {
            self = .data(data)
        } else {
            throw FormatDecodeError.invalidData
        }
    }
    
    case card(Card)
    case text(String)
    case data(Data)
}

protocol FormatResponseRequest: QueryableAPIRequest {
    var format: Format { get }
}
