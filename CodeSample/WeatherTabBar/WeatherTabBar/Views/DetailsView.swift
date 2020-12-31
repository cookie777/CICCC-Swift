//
//  DetailsView.swift
//  WeatherTabBar
//
//  Created by Derrick Park on 2019-04-24.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class DetailsView: UIStackView {

  @IBOutlet var country: UILabel!
  @IBOutlet var city: UILabel!
  @IBOutlet var temp: UILabel!
  @IBOutlet var summary: UILabel!

  func setupView(city: City) {
    self.country.text = city.flag
    self.city.text = city.name
    self.temp.text = "\(city.temp)"
    self.summary.text = city.summary
  }

  required init(coder: NSCoder) {
    super.init(coder: coder)
    translatesAutoresizingMaskIntoConstraints = false
    distribution = .fillEqually
    alignment = .center
  }
  
}
