//
//  HapticsMorseCodePlayer.swift
//  MorseCodeHaptics
//
//  Created by Takayuki Yamaguchi on 2021-02-03.
//

import Foundation
import CoreHaptics

class HapticsMorseCodePlayer: MorseCodePlayer {
    let hapticsEngine: CHHapticEngine

    init() throws {
        hapticsEngine = try CHHapticEngine()
        try hapticsEngine.start()
    }

    func play(message: MorseCodeMessage) throws {

        let events = self.hapticEvents(for: message)
        let pattern = try CHHapticPattern(events: events,
           parameters: [])
        let player = try hapticsEngine.makePlayer(with: pattern)
        try player.start(atTime: 0)
    }

    func hapticEvents(for message: MorseCodeMessage) -> [CHHapticEvent] {
        // TODO
        var totalTime = 0.4
        var events : Array<CHHapticEvent> = []
        for event in message.playbackEvents{
            switch event {
            case .on(let duration):
                events.append(CHHapticEvent(eventType: .hapticContinuous, parameters: [], relativeTime: totalTime, duration: duration))
            case .off(_):
                break
            }
            totalTime += event.duration
        }
        return events
    }
}
