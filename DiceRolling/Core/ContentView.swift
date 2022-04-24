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
    @State private var result1 = 0
    @State private var roll2 = false
    @State private var result2 = 0
    @State private var roll3 = false
    @State private var result3 = 0
    @State private var roll4 = false
    @State private var result4 = 0
    @State private var total = 0
    
    var body: some View {
        NavigationView {
            ZStack {
                background
                VStack {
                    HStack {
                        settingsButton
                        Spacer()
                        usernameBox
                        
                        Spacer()
                        historyButton
                    }
                    .padding(.horizontal)
                    Spacer()
                    resultBox
                    Spacer()
                    dice
                    Spacer()
                    button
                }
                .padding(.bottom)
            }
            .navigationBarHidden(true)
            .onChange(of: result1) { _ in
                total = result1 + result2 + result3 + result4
                if total != 0 {
                    vm.addDataToUser(total)
                }
            }
            .onChange(of: vm.numberOfDiceSelected) { _ in
                total = 0
            }
            .onChange(of: vm.currentUsername) { _ in
                total = 0
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
    
    private var usernameBox: some View {
        Menu {
            Picker("Usernames", selection: $vm.currentUsername) {
                let usernames = vm.users.map({ $0.name })
                ForEach(usernames, id: \.self) { name in
                    Text(name)
                        .foregroundColor(.black)
                }
            }
        } label: {
            Text(vm.users.isEmpty ? "Uknown User" : vm.currentUsername)
                .font(.headline)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                .background(.white.opacity(0.5))
                .cornerRadius(10)
        }
        .padding(.horizontal)
    }
    
    private var historyButton: some View {
        NavigationLink {
            HistoryView(vm: vm)
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
    
    private var background: some View {
        Image("wood")
            .resizable()
            .ignoresSafeArea()
    }
    
    private var resultBox: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.white.opacity(0.5))
                .frame(width: 100, height: 78)
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(.black, lineWidth: 0.5)
                }
            
            Text(total == 0 ? "?" : "\(total)")
                .font(.system(size: 54, weight: .semibold))
        }
        .foregroundColor(.black)
    }
    
    private var dice: some View {
        VStack(spacing: 50) {
            HStack {
                DiceView(
                    size: vm.numberOfDiceSelected == 1 ? 140 : 120,
                    roll: $roll1,
                    result: $result1
                )
                .frame(maxWidth: .infinity)
                if vm.numberOfDiceSelected > 1 {
                    DiceView(size: 120, roll: $roll2, result: $result2)
                        .frame(maxWidth: .infinity)
                }
            }
            HStack {
                if vm.numberOfDiceSelected > 2 {
                    DiceView(size: 120, roll: $roll3, result: $result3)
                        .frame(maxWidth: .infinity)
                }
                if vm.numberOfDiceSelected > 3 {
                    DiceView(size: 120, roll: $roll4, result: $result4)
                        .frame(maxWidth: .infinity)
                }
            }
        }
        .padding(.horizontal)
        .padding(.bottom, 40)
    }
    
    private var button: some View {
        Button {
            roll1 = true
            roll2 = vm.numberOfDiceSelected > 1 ? true : false
            roll3 = vm.numberOfDiceSelected > 2 ? true : false
            roll4 = vm.numberOfDiceSelected > 3 ? true : false
            result1 = 0
            result2 = 0
            result3 = 0
            result4 = 0
            total = 0
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
}
