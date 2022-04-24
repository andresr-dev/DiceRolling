//
//  ViewModel.swift
//  DiceRolling
//
//  Created by Andres camilo Raigoza misas on 23/04/22.
//

import Foundation
import SwiftUI

@MainActor final class ViewModel: ObservableObject {
    let numberOfDiceOptions = [1, 2, 3, 4]
    @Published var numberOfDiceSelected = 1
    
    @Published var users = [User]()
    @Published var currentUsername = ""
    
    func addUser(_ newUser: User) {
        guard !users.contains(where: { $0 == newUser }) else { return }
        withAnimation {
            users.append(newUser)
        }
        currentUsername = newUser.name
    }
    
    func deleteUser(at offsets: IndexSet) {
        users.remove(atOffsets: offsets)
    }
    
    func addDataToUser(_ total: Int) {
        guard let userIndex = users.firstIndex(where: { $0.name == currentUsername }) else { return }
        var data = users[userIndex].data[numberOfDiceSelected]
        if data == nil {
            data = [total]
        } else {
            data!.append(total)
        }
        users[userIndex].data[numberOfDiceSelected] = data
    }
    
    func deleteDataForNumberOfDice(_ numberOfDice: Int, user: User) {
        if let userIndex = users.firstIndex(where: { $0 == user }) {
            withAnimation {
                users[userIndex].data[numberOfDice] = nil
            }
        }
    }
}
