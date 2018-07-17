//
//  Imagery.swift
//  ScryfallSwift
//
//  Created by Roudique on 7/16/18.
//

import Foundation

/// Scryfall produces multiple sizes of images and image crops for each Card object. Links to these images are available in each Card objects’ **image_uris** properties.
///
/// Guidelines on using images considering WOtC legal rules: [Link to scryfall](https://scryfall.com/docs/api/images)
class Imagery: Decodable {
    /// A transparent, rounded full card PNG. This is the best image to use for videos or other high-quality content.
    ///
    /// Size: 745 × 1040
    var png: URL
    
    /// A full card image with the rounded corners and the majority of the border cropped off. Designed for dated contexts where rounded images can’t be used.
    ///
    /// Size: 480 × 680
    var borderCrop: URL

    /// A rectangular crop of the card’s art only. Not guaranteed to be perfect for cards with outlier designs or strange frame arrangements
    ///
    /// Size: varies
    var artCrop: URL

    /// A large full card image
    ///
    /// Size: 672 × 936
    var large: URL

    /// A medium-sized full card image
    ///
    /// Size: 488 × 680
    var normal: URL

    /// A small full card image. Designed for use as thumbnail or list icon.
    ///
    /// Size: 146 × 204
    var small: URL

    enum CodingKeys: String, CodingKey {
        case png
        case borderCrop = "border_crop"
        case artCrop = "art_crop"
        case large
        case normal
        case small
    }
}
