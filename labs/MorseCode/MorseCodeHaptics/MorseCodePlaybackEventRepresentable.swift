//
//  MorseCodePlaybackEventRepresentable.swift
//  MorseCodeHaptics
//
//  Created by Takayuki Yamaguchi on 2021-02-03.
//

import Foundation


// Create element to be played.
protocol MorseCodePlaybackEventRepresentable {

    // basic element you are going to play
    var components: [MorseCodePlaybackEventRepresentable] {get}
    // off interval between each element
    var componentSeparationDuration: TimeInterval {get}
    //  Create events by using component and duration
    //  [element + off interval , element + off interval, .......]
    var playbackEvents: [MorseCodePlaybackEvent] {get}
}

extension MorseCodePlaybackEventRepresentable{
    // Set a default implementation
    var playbackEvents: [MorseCodePlaybackEvent]{
        components.flatMap{$0.playbackEvents + [.off(componentSeparationDuration)]}
    }
}

