//
//  SettingsView.swift
//  DiceRolling
//
//  Created by Andres camilo Raigoza misas on 23/04/22.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var vm: ViewModel
        
    var body: some View {
        Form {
            Section {
                VStack(alignment: .leading) {
                    Text("Number of dice:")
                        .font(.headline)
                    Picker("Numver of dice", selection: $vm.numberOfDiceSelected) {
                        ForEach(vm.numberOfDiceOptions, id: \.self) {
                            Text($0, format: .number)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
        }
        .navigationTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView(vm: ViewModel())
        }
    }
}
