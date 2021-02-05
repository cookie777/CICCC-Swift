//
//  VisualMorseCodePlayerView.swift
//  MorseCodeHaptics
//
//  Created by Takayuki Yamaguchi on 2021-02-03.
//

import UIKit

class VisualMorseCodePlayerView: UIView, MorseCodePlayer {
    
    func play(message: MorseCodeMessage) throws {
        
        func eventTimer(timer: Timer?, eventId: Int)  {
  
            timer?.invalidate()
            
            if eventId >= (message.playbackEvents.count - 1) {
                backgroundColor = .label
                return
            }
            let currentEvent = message.playbackEvents[eventId]

            Timer.scheduledTimer(
                withTimeInterval: currentEvent.duration,
                repeats: false,
                block: {[weak self] timer in
                    switch currentEvent{
                    case .on(_):
                        self?.backgroundColor = .systemBackground
                    case .off(_):
                        self?.backgroundColor = .label
                    }
                    eventTimer(timer: timer, eventId: eventId+1)
                }
            )
        }
        eventTimer(timer: nil, eventId: 0)
        
    }
    
    
}


//                var totalTime = 0.0
//                for event in message.playbackEvents{
//
//                    DispatchQueue.main.asyncAfter(deadline: .now() + totalTime ) {
//                        switch event{
//                        case .on(_):
//                            print("⬜️")
//                            self.backgroundColor = .systemBackground
//                        case .off(_):
//                            print("◾️")
//                            self.backgroundColor = .label
//                        }
//                        print(event.duration)
//
//                    }
//
//                    totalTime += event.duration
//
//
//                }

//        var currentEventId = 0
