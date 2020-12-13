//
//  DiningRoomViewController.swift
//  Assignment3
//
//  Created by Takayuki Yamaguchi on 2020-12-11.
//

import UIKit

class DiningRoomViewController: SuperViewController {

  override func viewDidLoad() {
      super.viewDidLoad()
  }
  
  init() {
    super.init(currentLocation: .diningRoom , nextDestinations: [])
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
