//
//  MorseCodePlayer.swift
//  MorseCodeHaptics
//
//  Created by Takayuki Yamaguchi on 2021-02-03.
//

import Foundation


// Creating a player of morse code
protocol MorseCodePlayer {
    func play(message: MorseCodeMessage) throws
}

// player enum. on and off with interval
enum MorseCodePlaybackEvent{
    // associated enum == attach data type whatever you want.
    case on(TimeInterval)
    case off(TimeInterval)
    
    // xxxxx.duration returns any interval value
    var duration: TimeInterval{
        switch self {
        case .on(let duration):
            return duration
        case .off(let duration):
            return duration
        }
    }
}

// using custom interval unit 
extension TimeInterval {
    static let morseCodeUnit: TimeInterval = 0.2
}
