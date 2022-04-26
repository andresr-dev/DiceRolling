//
//  SettingsView.swift
//  DiceRolling
//
//  Created by Andres camilo Raigoza misas on 23/04/22.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var vm: ViewModel
    @State private var name = ""
        
    var body: some View {
        Form {
            Section("Number of dice") {
                VStack(alignment: .leading) {
                    Picker("Numver of dice", selection: $vm.numberOfDiceSelected) {
                        ForEach(vm.numberOfDiceOptions, id: \.self) {
                            Text($0, format: .number)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            
            Section("Users") {
                HStack {
                    TextField("New username", text: $name)
                    Button("Add", action: addButtonPressed)
                    .disabled(name.isEmpty)
                }
                List {
                    ForEach(vm.users, id: \.name) {
                        Text($0.name)
                    }
                    .onDelete(perform: vm.deleteUser)
                }
            }
        }
        .navigationTitle("Settings")
        .onChange(of: vm.numberOfDiceSelected) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                dismiss()
            }
        }
    }
    
    private func addButtonPressed() {
        let trimmedName = name.trimmingCharacters(in: .whitespaces)
        guard !trimmedName.isEmpty else { return }
        let newUser = User(name: trimmedName, data: [Int:[Int]]())
        vm.addUser(newUser)
        name = ""
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView(vm: ViewModel())
        }
    }
}
