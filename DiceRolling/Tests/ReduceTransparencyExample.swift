//
//  ReduceTransparencyExample.swift
//  DiceRolling
//
//  Created by Andres camilo Raigoza misas on 26/04/22.
//

import SwiftUI

struct ReduceTransparencyExample: View {
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    
    var body: some View {
        Text("Hello, World!")
            .padding()
            .background(reduceTransparency ? .black : .black.opacity(0.5))
            .foregroundColor(.white)
            .clipShape(Capsule())
            
    }
}

struct ReduceTransparencyExample_Previews: PreviewProvider {
    static var previews: some View {
        ReduceTransparencyExample()
    }
}
