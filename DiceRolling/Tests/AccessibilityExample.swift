//
//  AccessibilityExample.swift
//  DiceRolling
//
//  Created by Andres camilo Raigoza misas on 25/04/22.
//

import SwiftUI

struct AccessibilityExample: View {
    
    var body: some View {
        ZStack {
            // Background
            Image(decorative: "wood")
                .resizable()
                .ignoresSafeArea()
                
            // Content layer
            VStack(spacing: 20) {
                VStack {
                    Text("Your score is")
                    Text("1000")
                        .font(.title)
                }
                .padding()
                .background(.regularMaterial)
                .cornerRadius(15)
                .padding(.bottom)
                .accessibilityElement(children: .ignore)
                .accessibilityLabel("Your score is 1000")
                
                Image(systemName: "heart")
                    .font(.largeTitle)
                    .padding()
                    .background(Circle().fill(.regularMaterial))
                    .onTapGesture {
                        // Do something
                    }
                    .accessibilityLabel("heart")
                    .accessibilityAddTraits(.isButton)
                    .accessibilityRemoveTraits(.isImage)
            }
        }
    }
}

struct AccessibilityExample_Previews: PreviewProvider {
    static var previews: some View {
        AccessibilityExample()
    }
}
