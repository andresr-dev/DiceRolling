//
//  SimpleHaptics.swift
//  DiceRolling
//
//  Created by Andres camilo Raigoza misas on 25/04/22.
//

import SwiftUI

struct SimpleHaptics: View {
    var body: some View {
        Text("Hello, World!")
            .onTapGesture {
                simpleSuccess()
            }
    }
    
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}

struct SimpleHaptics_Previews: PreviewProvider {
    static var previews: some View {
        SimpleHaptics()
    }
}
