//
//  ViewController.swift
//  Assignment3
//
//  Created by Takayuki Yamaguchi on 2020-12-11.
//


/*
 # Every Child view cotroller of superView controller.
 - Each view controller indicates each locations(rooms).
 - By initilizing with `currentLocation` and `nextDestinations` parameters,
  this ViewCotroller creates
    - image view of current location
    - buttons(link) which leads to next destinations
 - Most of the core variables and functions are described in suprView controller
 */


import UIKit

class DoorwayViewController: SuperViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  init() {
    super.init(currentLocation: .doorway, nextDestinations: [.coatRoom])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}


class CoatRoomViewController: SuperViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  init() {
    super.init(currentLocation: .coatRoom, nextDestinations: [.library, .diningRoom, .stairsUp])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}


class LibraryViewController: SuperViewController {

  override func viewDidLoad() {
      super.viewDidLoad()
  }
    
  init() {
    super.init(currentLocation: .library, nextDestinations: [.secretPassage])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}


class DiningRoomViewController: SuperViewController {

  override func viewDidLoad() {
      super.viewDidLoad()
  }
  
  init() {
    super.init(currentLocation: .diningRoom , nextDestinations: [.kitchen])
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}


class StarisUpViewController: SuperViewController {

  override func viewDidLoad() {
      super.viewDidLoad()
  }
  
  init() {
    super.init(currentLocation: .stairsUp , nextDestinations: [.bedroom, .bathroom])
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}


class SecretPassageViewController: SuperViewController {

  override func viewDidLoad() {
      super.viewDidLoad()
  }
  
  init() {
    super.init(currentLocation: .secretPassage , nextDestinations: [.dungeon, .labratory, .mysteriousLake])
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}


class KitchenViewController: SuperViewController {

  override func viewDidLoad() {
      super.viewDidLoad()
  }
  
  init() {
    super.init(currentLocation: .kitchen , nextDestinations: [.backPorch])
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}


class BedroomViewController: SuperViewController {

  override func viewDidLoad() {
      super.viewDidLoad()
  }
  
  init() {
    super.init(currentLocation: .bedroom , nextDestinations: [])
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}


class BathroomViewController: SuperViewController {

  override func viewDidLoad() {
      super.viewDidLoad()
  }
  
  init() {
    super.init(currentLocation: .bathroom , nextDestinations: [])
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}


class DungeonViewController: SuperViewController {

  override func viewDidLoad() {
      super.viewDidLoad()
  }
  
  init() {
    super.init(currentLocation: .dungeon, nextDestinations: [])
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}


class LaboratoryViewController: SuperViewController {

  override func viewDidLoad() {
      super.viewDidLoad()
  }
  
  init() {
    super.init(currentLocation: .labratory, nextDestinations: [.generator])
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}


class MysteriousLakeViewController: SuperViewController {

  override func viewDidLoad() {
      super.viewDidLoad()
  }
  
  init() {
    super.init(currentLocation: .mysteriousLake, nextDestinations: [.cursedChalice])
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}



class BackPorchViewController: SuperViewController {

  override func viewDidLoad() {
      super.viewDidLoad()
  }
  
  init() {
    super.init(currentLocation: .backPorch, nextDestinations: [])
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}


class GeneratorViewController: SuperViewController {

  override func viewDidLoad() {
      super.viewDidLoad()
  }
  
  init() {
    super.init(currentLocation: .generator, nextDestinations: [])
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}


class CursedChaliceViewController: SuperViewController {

  override func viewDidLoad() {
      super.viewDidLoad()
  }
  
  init() {
    super.init(currentLocation: .cursedChalice, nextDestinations: [])
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}





