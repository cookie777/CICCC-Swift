//
//  LocationDetails.swift
//  Assignment3
//
//  Created by Takayuki Yamaguchi on 2020-12-12.
//

import Foundation

struct LocationDetails {
  
  static var imgaeURL = {(l: Location) -> String in
    switch l{
    case .doorway:
      return "doorway"
    case .coatRoom:
      return "coat_room"
    case .library:
      return "library"
    case .diningRoom:
      return "dining_room"
    case .stairsUp:
      return "stairs_up"
    case .secretPassage:
      return "secret_passage"
    case .kitchen:
      return "kitchen"
    case .bedroom:
      return "bedroom"
    case .bathroom:
      return "bathroom"
    case .dungeon:
      return "dungeon"
    case .labratory:
      return "labroatory"
    case .mysteriousLake:
      return "mysterious_lake"
    case .backPorch:
      return "back_porch"
    case .generator:
      return "generator"
    case .cursedChalice:
      return "cursed_chalice"
    }
  }

  static var nextViewController = {(l: Location) -> SuperViewController in
    switch l{
    case .coatRoom:
      return CoatRoomViewController()
    case .doorway:
      return DoorwayViewController()
    case .library:
      return LibraryViewController()
    case .diningRoom:
      return DiningRoomViewController()
    case .stairsUp:
      return StarisUpViewController()
      
    case .secretPassage:
      return StarisUpViewController()
    case .kitchen:
      return StarisUpViewController()
    case .bedroom:
      return StarisUpViewController()
    case .bathroom:
      return StarisUpViewController()
    case .dungeon:
      return StarisUpViewController()
    case .labratory:
      return StarisUpViewController()
    case .mysteriousLake:
      return StarisUpViewController()
    case .backPorch:
      return StarisUpViewController()
    case .generator:
      return StarisUpViewController()
    case .cursedChalice:
      return StarisUpViewController()
    }
  }
}
