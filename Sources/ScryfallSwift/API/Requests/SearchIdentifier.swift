//
//  SearchIdentifier.swift
//  ScryfallSwift
//
//  Created by Roudique on 3/9/19.
//

import Foundation

public enum SearchIdentifier {
    case setCodeCollectorNumberAndLang(String, Int, String?)
    case multiverse(Int)
    case mtgo(Int)
    case arena(Int)
    case tcgplayer(Int)
    case scryfall(String)
}
