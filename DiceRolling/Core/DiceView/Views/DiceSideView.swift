//
//  DiceSideView.swift
//  DiceRolling
//
//  Created by Andres camilo Raigoza misas on 20/04/22.
//

import SwiftUI

struct DiceSideView: View {
    let side: DiceSide
    
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
            .padding(side.number == 5 ? 32 : side.number == 2 ? 37 : 35)
            .padding(.vertical, side.number == 6 ? -6 : 0)
            .background {
                Circle()
                    .fill(
                        RadialGradient(gradient: Gradient(colors: [.blue, Color("DarkBlue")]), center: .bottomLeading, startRadius: 50, endRadius: 150)
                    )
                    .padding(5)
            }
        }
        .background(
            RadialGradient(gradient: Gradient(colors: [.blue, Color("DarkBlue")]), center: .topTrailing, startRadius: 50, endRadius: 150)
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
                width: side.number == 1 ? 27 : 25,
                height: side.number == 1 ? 27 : 25
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
    }
}

struct DiceSideView_Previews: PreviewProvider {
    static var previews: some View {
        DiceSideView(side: DiceSide.example)
            .frame(width: 150, height: 150)
            .previewLayout(.sizeThatFits)
    }
}
