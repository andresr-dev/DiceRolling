//
//  ContentView.swift
//  DiceRolling
//
//  Created by Andres camilo Raigoza misas on 18/04/22.
//

import SwiftUI

struct ContentView: View {
    @State private var roll = false
    
    var body: some View {
        ZStack {
            Image("wood")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                DiceView(size: 150, roll: $roll)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .offset(y: 15)
                
                Button {
                    roll = true
                } label: {
                    Text("Roll Dice")
                        .font(.title2.weight(.semibold))
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.darkBlue)
                        .clipShape(Capsule())
                        .shadow(radius: 5)
                }
                .padding(.horizontal)
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
