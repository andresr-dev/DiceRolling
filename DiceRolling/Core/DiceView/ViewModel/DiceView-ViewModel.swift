//
//  DiceView-ViewModel.swift
//  DiceRolling
//
//  Created by Andres camilo Raigoza misas on 20/04/22.
//

import SwiftUI

extension DiceView {
    @MainActor final class Dice: ObservableObject {
        let size: Double
        
        @Published private(set) var dice = [DiceSide]()
        
        private var horizontalPattern = [6, 5, 1, 2]
        private var verticalPattern = [6, 4, 1, 3]
        
        let rotationTime = 0.5
        
        init(size: Double) {
            self.size = size
            
            (1...6).forEach { number in
                let side = DiceSide(number: number, degrees: -90, offset: size, anchor: .leading, rotateHorizontally: true)
                dice.append(side)
            }
            setInitialFacingSide()
        }
        
        func setInitialFacingSide() {
            for _ in 0...Int.random(in: 0...3) {
                moveHorizontalPattern()
            }
            if let facingSideIndex = dice.firstIndex(where: { $0.number == horizontalPattern[0] }) {
                dice[facingSideIndex].degrees = 0
                dice[facingSideIndex].offset = 0
            }
        }
        
        func rollDice() {
            for i in 0..<6 {
                DispatchQueue.main.asyncAfter(deadline: .now() + (Double(i) * rotationTime)) {
                    if Bool.random() {
                        self.rotateHorizontally()
                    } else {
                        self.rotateVertically()
                    }
                }
            }
        }
        
        private func rotateDice(_ facingSideIndex: Int, _ nextSideIndex: Int) {
            withAnimation(.easeInOut(duration: rotationTime)) {
                dice[facingSideIndex].degrees += 90
                dice[facingSideIndex].offset -= size
                
                dice[nextSideIndex].degrees += 90
                dice[nextSideIndex].offset -= size
            }
        }
        
        private func moveHorizontalPattern() {
            horizontalPattern.move(fromOffsets: .init(integer: 0), toOffset: 4)
            verticalPattern.remove(atOffsets: .init([0, 2]))
            verticalPattern.insert(horizontalPattern[0], at: 0)
            verticalPattern.insert(horizontalPattern[2], at: 2)
        }
        
        private func moveVerticalPattern() {
            verticalPattern.move(fromOffsets: .init(integer: 0), toOffset: 4)
            horizontalPattern.remove(atOffsets: .init([0, 2]))
            horizontalPattern.insert(verticalPattern[0], at: 0)
            horizontalPattern.insert(verticalPattern[2], at: 2)
        }
        
        func rotateHorizontally() {
            if let facingSideIndex = dice.firstIndex(where: { $0.degrees == 0 }) {
                // Reorder patterns
                moveHorizontalPattern()
                
                if let currentHorizontalIndex = horizontalPattern.firstIndex(where: { $0 == dice[facingSideIndex].number }) {
                    
                    // Prepare facing side before animation
                    dice[facingSideIndex].rotateHorizontally = true
                    dice[facingSideIndex].anchor = .trailing
                    
                    // Prepare next side before animation
                    // Look for next index in horizontal pattern
                    if currentHorizontalIndex < 3 {
                        if let nextSideIndex = dice.firstIndex(where: { $0.number == horizontalPattern[currentHorizontalIndex + 1] }) {
                            setNextSideBeforeMovingHorizontally(facingSideIndex, nextSideIndex)
                        }
                    } else {
                        // next index is 0
                        if let nextSideIndex = dice.firstIndex(where: { $0.number == horizontalPattern[0] }) {
                            setNextSideBeforeMovingHorizontally(facingSideIndex, nextSideIndex)
                        }
                    }
                }
            }
        }
        
        private func setNextSideBeforeMovingHorizontally(_ facingSideIndex: Int, _ nextSideIndex: Int) {
            dice[nextSideIndex].rotateHorizontally = true
            dice[nextSideIndex].anchor = .leading
            dice[nextSideIndex].degrees = -90
            dice[nextSideIndex].offset = size
            
            rotateDice(facingSideIndex, nextSideIndex)
        }
        
        func rotateVertically() {
            if let facingSideIndex = dice.firstIndex(where: { $0.degrees == 0 }) {
                // Reorder patterns
                moveVerticalPattern()
                
                if let currentVerticalIndex = verticalPattern.firstIndex(where: { $0 == dice[facingSideIndex].number }) {
                    
                    // Prepare facing side before animation
                    dice[facingSideIndex].rotateHorizontally = false
                    dice[facingSideIndex].anchor = .bottom
                    
                    // Prepare next side before animation
                    // Look for next index in vertical pattern
                    if currentVerticalIndex < 3 {
                        if let nextSideIndex = dice.firstIndex(where: { $0.number == verticalPattern[currentVerticalIndex + 1] }) {
                            setNextSideBeforeMovingVertically(facingSideIndex, nextSideIndex)
                        }
                    } else {
                        // next index is 0
                        if let nextSideIndex = dice.firstIndex(where: { $0.number == verticalPattern[0] }) {
                            setNextSideBeforeMovingVertically(facingSideIndex, nextSideIndex)
                        }
                    }
                }
            }
        }
        
        private func setNextSideBeforeMovingVertically(_ facingSideIndex: Int, _ nextSideIndex: Int) {
            dice[nextSideIndex].rotateHorizontally = false
            dice[nextSideIndex].anchor = .top
            dice[nextSideIndex].degrees = -90
            dice[nextSideIndex].offset = size
            
            rotateDice(facingSideIndex, nextSideIndex)
        }
    }
}
