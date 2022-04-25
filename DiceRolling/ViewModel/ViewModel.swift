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
    
    @Published var users: [User]
    @Published var currentUsername = "" {
        didSet {
            UserDefaults.standard.set(currentUsername, forKey: "Username")
        }
    }
   
    @Published var showClearHistoryButton = false
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("Users")
    
    init() {
        do {
            users = try FileManager.default.decode(from: savePath)
        } catch {
            users = [User]()
            print("Error getting users data: \(error.localizedDescription)")
        }
        currentUsername = UserDefaults.standard.string(forKey: "Username") ?? ""
    }
    
    func addUser(_ newUser: User) {
        guard !users.contains(where: { $0 == newUser }) else { return }
        withAnimation {
            users.append(newUser)
        }
        currentUsername = newUser.name
        saveUsers()
    }
    
    func deleteUser(at offsets: IndexSet) {
        users.remove(atOffsets: offsets)
        saveUsers()
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
        showClearHistoryButton = true
        saveUsers()
    }
    
    func clearHistory() {
        users.indices.forEach { index in
            users[index].data = [Int: [Int]]()
        }
        showClearHistoryButton = false
        saveUsers()
    }
    
    private func saveUsers() {
        FileManager.default.save(users, to: savePath)
    }
}
