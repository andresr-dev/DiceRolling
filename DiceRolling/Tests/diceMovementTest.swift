//
//  diceMovementTest.swift
//  DiceRolling
//
//  Created by Andres camilo Raigoza misas on 20/04/22.
//

import SwiftUI

struct diceMovementTest: View {
    @State var degrees = -90.0
    @State var offset = 150.0
    @State var anchor = UnitPoint.top
    
    var body: some View {
        VStack {
            Button("Rotate") {
                withAnimation(.linear(duration: 2)) {
                    degrees += 90.0
                    offset -= 150.0
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        anchor = .bottom
                    }
                }
            }
            Rectangle()
                .fill(.green)
                .frame(width: 150, height: 150)
                .rotation3DEffect(.degrees(degrees), axis: (x: 1, y: 0, z: 0), anchor: anchor, perspective: 0.1)
                .offset(y: offset)
        }
    }
}

struct diceMovementTest_Previews: PreviewProvider {
    static var previews: some View {
        diceMovementTest()
    }
}
