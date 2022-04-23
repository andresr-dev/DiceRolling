//
//  ContentView.swift
//  DiceRolling
//
//  Created by Andres camilo Raigoza misas on 18/04/22.
//

import SwiftUI

struct ContentView: View {
    @State private var roll = false
    @State private var result: Int?
    
    var body: some View {
        ZStack {
            background
            VStack {
                Spacer()
                resultBox
                Spacer()
                DiceView(size: 150, roll: $roll, result: $result)
                Spacer()
                Spacer()
                button
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension ContentView {
    private var background: some View {
        Image("wood")
            .resizable()
            .ignoresSafeArea()
    }
    private var resultBox: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.white.opacity(0.5))
                .frame(width: 100, height: 80)
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(.black, lineWidth: 0.5)
                }
            
            if let result = result {
                Text("\(result)")
                    .font(.system(size: 56, weight: .semibold))
            } else {
                Text("?")
                    .font(.system(size: 56, weight: .semibold))
            }
        }
        .foregroundColor(.black)
        .padding(.top)
    }
    private var button: some View {
        Button {
            roll = true
            result = nil
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color("MediumBlue"))
                    .frame(height: 58)
                    .overlay {
                        RoundedRectangle(cornerRadius: 15)
                            .strokeBorder(.black, lineWidth: 0.5)
                    }
                Text("Roll Dice")
                    .font(.title3.weight(.semibold))
                    .foregroundColor(.white)
            }
            
        }
        .padding(.horizontal, 30)
        .padding(.bottom, 5)
    }
}
