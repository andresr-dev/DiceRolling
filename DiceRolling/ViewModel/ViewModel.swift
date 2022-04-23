//
//  ViewModel.swift
//  DiceRolling
//
//  Created by Andres camilo Raigoza misas on 23/04/22.
//

import Foundation

@MainActor final class ViewModel: ObservableObject {
    let numberOfDiceOptions = [1, 2, 3, 4]
    @Published var numberOfDiceSelected = 1
}
