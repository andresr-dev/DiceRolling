//
//  CustomCurveHaptics.swift
//  DiceRolling
//
//  Created by Andres camilo Raigoza misas on 2/08/22.
//

import CoreHaptics
import SwiftUI

struct CustomCurveHaptics: View {
    // We use @State here because we want engine to be alive even if this view gets recreated.
    @State private var engine: CHHapticEngine?
    
    var body: some View {
        Text("Hello, World!")
            .onAppear(perform: prepareHaptics)
            .onTapGesture(perform: customCurveHaptic)
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
    
    func customCurveHaptic() {
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0)
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        
        let start = CHHapticParameterCurve.ControlPoint(relativeTime: 0, value: 1)
        let end = CHHapticParameterCurve.ControlPoint(relativeTime: 1, value: 0)
        
        let parameterCurve = CHHapticParameterCurve(
            parameterID: .hapticIntensityControl,
            controlPoints: [start, end],
            relativeTime: 0
        )
        
        let event1 = CHHapticEvent(
            eventType: .hapticTransient,
            parameters: [intensity, sharpness],
            relativeTime: 0
        )
        
        let event2 = CHHapticEvent(
            eventType: .hapticContinuous,
            parameters: [sharpness, intensity],
            relativeTime: 0.125,
            duration: 1
        )
        
        do {
            let pattern = try CHHapticPattern(events: [event1, event2], parameterCurves: [parameterCurve])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern \(error.localizedDescription)")
        }
    }
}

struct CustomCurveHaptics_Previews: PreviewProvider {
    static var previews: some View {
        CustomCurveHaptics()
    }
}
