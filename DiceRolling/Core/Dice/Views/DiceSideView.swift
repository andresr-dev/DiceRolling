//
//  DiceSideView.swift
//  DiceRolling
//
//  Created by Andres camilo Raigoza misas on 20/04/22.
//

import SwiftUI

struct DiceSideView: View {
    let side: DiceSide
    let size: Double
    
    var body: some View {
        ZStack {
            ZStack {
                if side.number == 1 || side.number == 3 || side.number == 5 {
                    dot(alignment: .center)
                }
                if side.number != 1 {
                    dot(alignment: .topLeading)
                    dot(alignment: .bottomTrailing)
                }
                if side.number >= 4 {
                    dot(alignment: .topTrailing)
                    dot(alignment: .bottomLeading)
                }
                if side.number == 6 {
                    dot(alignment: .leading)
                    dot(alignment: .trailing)
                }
            }
            .shadow(radius: 5)
            .padding(side.number == 5 ? size * 0.213 : side.number == 2 ? size * 0.2467 : size * 0.233)
            .padding(.vertical, side.number == 6 ? -size * 0.04 : 0)
            .background {
                Circle()
                    .fill(
                        RadialGradient(gradient: Gradient(colors: [.blue, .darkBlue]), center: .bottomLeading, startRadius: size * 0.333, endRadius: size)
                    )
                    .padding(size * 0.033)
            }
        }
        .background(
            RadialGradient(gradient: Gradient(colors: [.blue, .darkBlue]), center: .topTrailing, startRadius: size * 0.333, endRadius: size)
        )
        .overlay {
            Rectangle()
                .strokeBorder(.black, lineWidth: 0.5)
        }
        .rotation3DEffect(
            .degrees(side.degrees),
            axis: (
                x: side.rotateHorizontally ? 0 : 1,
                y: side.rotateHorizontally ? -1 : 0,
                z: 0
            ),
            anchor: side.anchor, perspective: 0.1
        )
        .offset(
            x: side.rotateHorizontally ? side.offset : 0,
            y: side.rotateHorizontally ? 0 : side.offset
        )
    }
    
    private func dot(alignment: Alignment) -> some View {
        Circle()
            .fill(.white)
            .frame(
                width: side.number == 1 ? size * 0.18 : size * 0.167,
                height: side.number == 1 ? size * 0.18 : size * 0.167
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
    }
}

struct DiceSideView_Previews: PreviewProvider {
    static var previews: some View {
        DiceSideView(side: DiceSide.example, size: 150)
            .frame(width: 150, height: 150)
            .previewLayout(.sizeThatFits)
    }
}
