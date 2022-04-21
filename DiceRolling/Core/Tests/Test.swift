//
//  Test.swift
//  DiceRolling
//
//  Created by Andres camilo Raigoza misas on 19/04/22.
//

import SwiftUI

struct Test: View {
    
    @State var scaleAmount = 1.0
    @State var offset = CGSize.zero
    
    var magnification: some Gesture {
        MagnificationGesture()
            .onChanged { gestureValue in
                scaleAmount = gestureValue
            }
            .onEnded { _ in
                withAnimation {
                    scaleAmount = 1.0
                }
            }
    }
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { dragValue in
                if scaleAmount > 1.0 {
                    offset = dragValue.translation
                }
            }
            .onEnded { _ in
                withAnimation {
                    offset = .zero
                }
            }
    }
    
    var combinedGestures: some Gesture {
        magnification.simultaneously(with: drag)
    }
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(.red)
                .frame(width: 250, height: 250)
                .scaleEffect(scaleAmount)
                .offset(offset)
                .gesture(combinedGestures)
        }
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
