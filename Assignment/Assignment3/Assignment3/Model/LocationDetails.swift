//
//  LocationDetails.swift
//  Assignment3
//
//  Created by Takayuki Yamaguchi on 2020-12-12.
//

import Foundation

/*
 # Overview
 - This struct stores and returns details for each location
   - imageURL -> return image pass
   - nextViewController -> return view controller
 - Each case is managed by enum
 
 ## ex)
 - If you want to get Doorway's image, you can use
  `UIImage(named: LocationDetails.imgaeURL(.doorway))`
 - If you want to get Doorway's viewcontroller, you can use
  `let nextVC = LocationDetails.nextViewController(.doorway)`
 */

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
      return "labratory"
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
      return SecretPassageViewController()
    case .kitchen:
      return KitchenViewController()
    case .bedroom:
      return BedroomViewController()
    case .bathroom:
      return BathroomViewController()
    case .dungeon:
      return DungeonViewController()
    case .labratory:
      return LaboratoryViewController()
    case .mysteriousLake:
      return MysteriousLakeViewController()
    case .backPorch:
      return BackPorchViewController()
    case .generator:
      return GeneratorViewController()
    case .cursedChalice:
      return CursedChaliceViewController()
    }
  }
}
