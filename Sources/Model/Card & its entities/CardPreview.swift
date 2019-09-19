//
//  CardPreview.swift
//  ScryfallSwift iOS
//
//  Created by Roudique on 9/18/19.
//

import Foundation


public struct CardPreview: Decodable {
    /// The name of the source that previewed this card.
    let source: String
    
    /// A link to the preview for this card.
    let sourceURIString: String?
    
    /// The date this card was previewed.
    let previewedAt: String
    
    enum CodingKeys: String, CodingKey {
        case source
        case sourceURIString = "source_uri"
        case previewedAt = "previewed_at"
    }

}
