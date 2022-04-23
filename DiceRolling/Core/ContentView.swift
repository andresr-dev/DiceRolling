//
//  ContentView.swift
//  DiceRolling
//
//  Created by Andres camilo Raigoza misas on 23/04/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = ViewModel()
    
    @State private var roll1 = false
    @State private var roll2 = false
    @State private var result1: Int?
    @State private var result2: Int?
    
    
    
    var body: some View {
        NavigationView {
            ZStack {
                background
                VStack {
                    Spacer()
                    resultBox
                    Spacer()
                    HStack {
                        Spacer()
                        DiceView(size: 125, roll: $roll1, result: $result1)
                        Spacer()
                        DiceView(size: 125, roll: $roll2, result: $result2)
                        Spacer()
                    }
                    Spacer()
                    Spacer()
                    button
                }
                .padding(.bottom)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    settingsButton
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    historyButton
                }
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
                .frame(width: 110, height: 90)
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(.black, lineWidth: 0.5)
                }
            
            if let result = result1 {
                Text("\(result)")
                    .font(.system(size: 54, weight: .semibold))
            } else {
                Text("?")
                    .font(.system(size: 54, weight: .semibold))
            }
        }
        .foregroundColor(.black)
    }
    
    private var button: some View {
        Button {
            roll1 = true
            roll2 = true
            result1 = nil
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(.mediumBlue)
                    .frame(height: 58)
                    .overlay {
                        RoundedRectangle(cornerRadius: 15)
                            .strokeBorder(.black, lineWidth: 0.5)
                    }
                    .shadow(radius: 5)
                
                Text("Roll Dice")
                    .font(.title3.weight(.semibold))
                    .foregroundColor(.white)
            }
        }
        .padding(.horizontal, 30)
        .padding(.bottom, 5)
    }
    
    private var settingsButton: some View {
        NavigationLink {
            SettingsView(vm: vm)
        } label: {
            ZStack {
                Circle()
                    .fill(.white.opacity(0.5))
                    .frame(width: 42, height: 42)
                    .overlay {
                        Circle()
                            .strokeBorder(.black, lineWidth: 0.2)
                    }
                
                Image(systemName: "gear")
                    .foregroundColor(.black)
            }
        }
    }
    
    private var historyButton: some View {
        NavigationLink {
            Text("History")
        } label: {
            ZStack {
                Circle()
                    .fill(.white.opacity(0.5))
                    .frame(width: 42, height: 42)
                    .overlay {
                        Circle()
                            .strokeBorder(.black, lineWidth: 0.2)
                    }
                
                Image(systemName: "clock.arrow.circlepath")
                    .foregroundColor(.black)
            }
        }
    }
}
