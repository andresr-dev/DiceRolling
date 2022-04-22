//
//  DiceView.swift
//  DiceRolling
//
//  Created by Andres camilo Raigoza misas on 18/04/22.
//

import SwiftUI

struct DiceView: View {
    let rotationTime: Double
    @StateObject var vm = Dice()
    let diceSize = 150.0
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Rotate Vertically") {
                vm.rotateVertically()
            }
            Button("Rotate Horizontally") {
                vm.rotateHorizontally()
            }
            ZStack {
                ForEach(vm.dice, id: \.number) {
                    DiceSideView(side: $0, width: diceSize)
                }
            }
            .frame(width: diceSize, height: diceSize)
        }
    }
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView(rotationTime: 3)
            .preferredColorScheme(.dark)
    }
}
