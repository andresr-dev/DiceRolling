//
//  DiceRollingApp.swift
//  DiceRolling
//
//  Created by Andres camilo Raigoza misas on 18/04/22.
//

import SwiftUI

@main
struct DiceRollingApp: App {
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .tertiarySystemBackground
    
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
