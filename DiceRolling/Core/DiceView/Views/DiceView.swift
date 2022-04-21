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
                    DiceSideView(side: $0)
                }
            }
            .frame(width: 150, height: 150)
        }
    }
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView(rotationTime: 3)
            .preferredColorScheme(.dark)
    }
}
