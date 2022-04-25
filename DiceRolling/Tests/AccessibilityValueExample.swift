//
//  AccessibilityValueExample.swift
//  DiceRolling
//
//  Created by Andres camilo Raigoza misas on 25/04/22.
//

import SwiftUI

struct AccessibilityValueExample: View {
    @State private var value = 10
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Value: \(value)")
            
            Button("Increment") {
                value += 1
            }
            
            Button("Decrement") {
                value -= 1
            }
        }
        // This is .accessibilityElement(children: .ignore) by default
        .accessibilityElement()
        .accessibilityLabel("Value")
        .accessibilityValue(String(value))
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment:
                value += 1
            case .decrement:
                value -= 1
            default:
                print("Not handled")
            }
        }
    }
}

struct AccessibilityValueExample_Previews: PreviewProvider {
    static var previews: some View {
        AccessibilityValueExample()
    }
}
