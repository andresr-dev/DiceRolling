//
//  DiceView.swift
//  DiceRolling
//
//  Created by Andres camilo Raigoza misas on 18/04/22.
//

import SwiftUI

struct DiceView: View {
    let size: Double
    @Binding var roll: Bool
    @StateObject var vm: Dice
    
    init(size: Double, roll: Binding<Bool>) {
        self.size = size
        self._roll = roll
        _vm = StateObject(wrappedValue: Dice(size: size))
    }
    
    var body: some View {
        ZStack {
            ForEach(vm.dice, id: \.number) {
                DiceSideView(side: $0, size: size)
            }
        }
        .frame(width: size, height: size)
        .onChange(of: roll) { _ in
            if roll {
                vm.rollDice()
                roll = false
            }
        }
    }
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView(size: 150, roll: .constant(false))
            .preferredColorScheme(.dark)
    }
}
