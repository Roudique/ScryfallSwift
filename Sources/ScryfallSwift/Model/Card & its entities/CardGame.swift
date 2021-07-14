//
//  CardGame.swift
//  ScryfallSwift
//
//  Created by Roudique on 3/3/19.
//

import Foundation


// MARK: -
/// Games that card print could be available in.
public enum CardGame: String, Decodable, CaseIterable {
    case paper
    case arena
    case mtgo
    case astral
    case sega
}
