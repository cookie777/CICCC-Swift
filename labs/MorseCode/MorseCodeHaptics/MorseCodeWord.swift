
import Foundation

struct MorseCodeWord {
        
    let characters: [MorseCodeCharacter]
    
    init?(word: String) {
        self.characters = word.compactMap { character in
            MorseCodeCharacter(character: character)
        }
        
        guard word.count == self.characters.count else {
            return nil
        }
    }    
}

extension MorseCodeWord : MorseCodePlaybackEventRepresentable{
    
    //create [char + off*3, char + off*3, char + off*3]
    var components: [MorseCodePlaybackEventRepresentable] {
        characters
    }
    
    var componentSeparationDuration: TimeInterval {
        .morseCodeUnit*3
    }
        
}
