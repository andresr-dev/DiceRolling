//
//  DifferentiateWithoutColorExample.swift
//  DiceRolling
//
//  Created by Andres camilo Raigoza misas on 26/04/22.
//

import SwiftUI

struct DifferentiateWithoutColorExample: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    
    var body: some View {
        HStack {
            if differentiateWithoutColor {
                Image(systemName: "checkmark.circle")
            }
            Text("Success")
        }
        .padding()
        .background(differentiateWithoutColor ? .black : .green)
        .foregroundColor(.white)
        .clipShape(Capsule())
    }
}

struct DifferentiateWithoutColorExample_Previews: PreviewProvider {
    static var previews: some View {
        DifferentiateWithoutColorExample()
    }
}
