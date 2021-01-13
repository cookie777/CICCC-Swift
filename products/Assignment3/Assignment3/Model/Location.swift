//
//  Location.swift
//  Assignment3
//
//  Created by Takayuki Yamaguchi on 2020-12-12.
//

import Foundation

/*
 # This enum manages each locations(rooms)
 - This enum will be used for
   - determine image url
   - determine button title
   - determine each view controller
 - The raw value is used for button title
 
 */

enum Location : String {
  case doorway          = "Doorway"
  case coatRoom         = "Coat room"
  case library          = "Library"
  case diningRoom       = "Dining room"
  case stairsUp         = "Staris up"
  case secretPassage    = "Secret passage"
  case kitchen          = "Kitchen"
  case bedroom          = "Bedroom"
  case bathroom         = "Bathroom"
  case dungeon          = "Dungeon"
  case labratory        = "Labratory"
  case mysteriousLake   = "Mysterious lake"
  case backPorch        = "Back porch"
  case generator        = "Generator"
  case cursedChalice    = "Cursed chalice"
}
