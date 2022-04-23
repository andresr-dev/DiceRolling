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
    @Binding var result: Int?
    @StateObject var vm: ViewModel
    
    init(size: Double, roll: Binding<Bool>, result: Binding<Int?>) {
        self.size = size
        self._roll = roll
        self._result = result
        _vm = StateObject(wrappedValue: ViewModel(size: size))
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
        .onChange(of: vm.result) { newResult in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                result = newResult
            }
        }
    }
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView(size: 150, roll: .constant(false), result: .constant(4))
            .preferredColorScheme(.dark)
    }
}
