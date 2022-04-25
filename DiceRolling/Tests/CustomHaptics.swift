//
//  CustomHaptics.swift
//  DiceRolling
//
//  Created by Andres camilo Raigoza misas on 25/04/22.
//

import SwiftUI
import CoreHaptics

struct CustomHaptics: View {
    // We use @State here because we want engine to be alive even if this view gets recreated.
    @State private var engine: CHHapticEngine?
    
    var body: some View {
        Text("Hello, World!")
            .onAppear(perform: prepareHaptics)
            .onTapGesture(perform: customHaptic)
    }
    
    func prepareHaptics() {
        // Check if the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    func customHaptic() {
        // Check if the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        var events = [CHHapticEvent]()
        
        for i in stride(from: 0, through: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            events.append(event)
        }
        
        for i in stride(from: 0, through: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i)
            events.append(event)
        }
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern \(error.localizedDescription)")
        }
    }
}

struct CustomHaptics_Previews: PreviewProvider {
    static var previews: some View {
        CustomHaptics()
    }
}
