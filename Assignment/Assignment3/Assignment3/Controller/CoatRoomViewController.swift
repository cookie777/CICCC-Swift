//
//  CoatRoomViewController.swift
//  Assignment3
//
//  Created by Takayuki Yamaguchi on 2020-12-11.
//

import UIKit

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
