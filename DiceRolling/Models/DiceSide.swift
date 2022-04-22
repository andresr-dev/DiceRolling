//
//  DiceSide.swift
//  DiceRolling
//
//  Created by Andres camilo Raigoza misas on 20/04/22.
//

import SwiftUI

struct DiceSide {
    var number: Int
    var degrees: Double
    var offset: Double
    var anchor: UnitPoint
    var rotateHorizontally: Bool
    
    static let example = DiceSide(number: 6, degrees: 0, offset: 0, anchor: .trailing, rotateHorizontally: true)
}
