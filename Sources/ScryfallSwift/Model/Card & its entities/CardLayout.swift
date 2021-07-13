//
//  Layout.swift
//  ScryfallSwift iOS
//
//  Created by Roudique on 3/3/19.
//

import Foundation


//MARK: -
/// The layout property the arrangement of card parts, faces, and other bounded regions on cards. The layout can be used to programmatically determine which other properties on a card you can expect.
///
/// - cards with the layouts **split**, **flip**, **transform**, and **doubleFacedToken** will always have a **cardFaces** property describing the distinct faces.
///  - cards with the layout **meld** will always have a **relatedCards** property pointing to the other meld parts.
public enum CardLayout: String, Decodable, CaseIterable {
    /// A standard Magic card with one face
    case normal
    
    /// A split-faced card
    case split
    
    /// Cards that invert vertically with the flip keyword
    case flip
    
    /// Double-sided cards that transform
    case transform
    
    /// Double-sided cards that can be played either-side
    case modalDFC = "modal_dfc"
    
    /// Cards with meld parts printed on the back
    case meld
    
    /// Class-type enchantment cards
    case `class`
    
    /// Cards with Level Up
    case leveler
    
    /// Saga-type cards
    case saga
    
    /// Cards with an Adventure spell part
    case adventure
    
    /// Plane and Phenomenon-type cards
    case planar
    
    /// Scheme-type cards
    case scheme
    
    /// Vanguard-type cards
    case vanguard
    
    /// Token cards
    case token
    
    /// Tokens with another token printed on the back
    case doubleFacedToken = "double_faced_token"
    
    /// Emblem cards
    case emblem
    
    /// Cards with **Augment**
    case augment
    
    /// Host-type cards
    case host
    
    /// Art Series collectable double-faced cards
    case artSeries = "art_series"
    
    /// A Magic card with two sides that are unrelated
    case doubleSided = "double_sided"
}
