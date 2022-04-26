//
//  AnimationExample.swift
//  DiceRolling
//
//  Created by Andres camilo Raigoza misas on 26/04/22.
//

import SwiftUI

struct AnimationExample: View {
    @State var degrees = 0.0
    @State var offset = 0.0
    
    var body: some View {
        VStack {
            Button("Rotate") {
                withAnimation(.linear(duration: 1)) {
                    degrees = 90
                    offset = -150
                }
            }
            Rectangle()
                .fill(.red)
                .frame(width: 150, height: 150)
                .rotation3DEffect(.degrees(degrees), axis: (x: 0, y: -1, z: 0), anchor: .trailing, perspective: 0.1)
                .offset(x: offset, y: 0)
        }
    }
}

struct AnimationExample_Previews: PreviewProvider {
    static var previews: some View {
        AnimationExample()
    }
}
