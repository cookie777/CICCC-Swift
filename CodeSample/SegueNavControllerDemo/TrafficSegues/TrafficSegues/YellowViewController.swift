//
//  YellowViewController.swift
//  TrafficSegues
//
//  Created by Derrick Park on 2020-12-11.
//

import UIKit

class YellowViewController: UIViewController {
  
  var textStringFromRed: String!
  
  @IBOutlet var label: UILabel! {
    didSet {
      label.text = textStringFromRed
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
}
