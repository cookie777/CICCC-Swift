
import Foundation

enum MorseCodeSignal: String {
    case short = "."
    case long = "-"
}

extension MorseCodeSignal: MorseCodePlaybackEventRepresentable{
    
    // basic element you are going to play
    var components: [MorseCodePlaybackEventRepresentable] {
        []
    }
    
    // off interval between each element
    var componentSeparationDuration: TimeInterval {
        0
    }
    
    // Basically, do [element + off interval , element + off interval, .......]
    // But this time, override and define new play event based on self (== short or long).
    var playbackEvents: [MorseCodePlaybackEvent] {
        switch self {
        case .short:
            return [.on(.morseCodeUnit)]
        case .long:
            return [.on(.morseCodeUnit*3)]
        }
    }
    
}
