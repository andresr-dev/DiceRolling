//
//  AnimationExample.swift
//  DiceRolling
//
//  Created by Andres camilo Raigoza misas on 26/04/22.
//

import SwiftUI

struct AnimationExample: View {
    @State private var redDegrees = 0.0
    @State private var redOffset = 0.0
    @State private var blueDegrees = -90.0
    @State private var blueOffset = 150.0
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(.red)
                    .frame(width: 150, height: 150)
                    .rotation3DEffect(.degrees(redDegrees), axis: (x: 0, y: -1, z: 0), anchor: .trailing, perspective: 0.1)
                    .offset(x: redOffset, y: 0)
                
                Rectangle()
                    .fill(.blue)
                    .frame(width: 150, height: 150)
                    .rotation3DEffect(.degrees(blueDegrees), axis: (x: 0, y: -1, z: 0), anchor: .leading, perspective: 0.1)
                    .offset(x: blueOffset, y: 0)
            }
            
            Button("Rotate Horizontally") {
                withAnimation(.linear(duration: 1).repeatForever(autoreverses: true)) {
                    redDegrees = 90
                    redOffset = -150
                    blueDegrees = 0
                    blueOffset = 0
                }
            }
        }
    }
}

struct AnimationExample_Previews: PreviewProvider {
    static var previews: some View {
        AnimationExample()
    }
}
