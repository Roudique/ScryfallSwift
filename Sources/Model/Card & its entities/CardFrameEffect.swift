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
public enum CardFrameEffect: String, Decodable {
    case legendary
    case miracle
    case nyxtouched
    case draft
    case devoid
    case tombstone
    case colorshifted
    case sunmoondfc
    case compasslanddfc
    case originpwdfc
    case mooneldrazidfc
}
