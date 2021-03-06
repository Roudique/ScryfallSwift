//
//  CardFrameEffect.swift
//  ScryfallSwift
//
//  Created by Roudique on 3/3/19.
//

import Foundation


// MARK: -
/// The frame_effect field tracks additional frame artwork applied over a particular frame. For example, there are both 2003 and 2015-frame cards with the Nyx-touched effect.
///
/// - legendary: The legendary crown introduced in Dominaria
/// - miracle: The miracle frame effect
/// - nyxtouched: The Nyx-touched frame effect
/// - draft: The draft-matters frame effect
/// - devoid: The Devoid frame effect
/// - tombstone: The Odyssey tombstone mark
/// - colorshifted: A colorshifted frame
/// - sunmoondfc: The sun and moon transform marks
/// - compasslanddfc: The compass and land transform marks
/// - originpwdfc: The Origins and planeswalker transform marks
/// - mooneldrazidfc: The moon and Eldrazi transform marks
/// - etched: The cards have an etched foil treatment
public enum CardFrameEffect: String, Decodable, CaseIterable {
    case legendary
    case miracle
    case nyxtouched
    case draft
    case devoid
    case tombstone
    case colorshifted
    case inverted
    case sunmoondfc
    case compasslanddfc
    case originpwdfc
    case mooneldrazidfc
    case moonreversemoondfc
    case waxingandwaningmoondfc
    case showcase
    case extendedart
    case companion
    case fullart
    case etched
    case snow
    case none = "" // This is a workaround for server's behaviour: if there are no frame effects it returns an array with an empty string.
}
