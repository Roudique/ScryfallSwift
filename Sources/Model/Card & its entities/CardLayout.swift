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
public enum CardLayout: String, Decodable {
    /// A standard Magic card with one face
    case normal
    
    /// A split-faced card
    case split
    
    /// Cards that invert vertically with the flip keyword
    case flip
    
    /// Double-sided cards that transform
    case transform
    
    /// Cards with meld parts printed on the back
    case meld
    
    /// Cards with Level Up
    case leveler
    
    /// Saga-type cards
    case saga
    
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
}
