//
//  City.swift
//  WeatherTabBar
//
//  Created by Derrick Park on 2019-04-24.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import Foundation

struct City {
  let name: String
  let country: String
  let temp: Double
  let icon: String
  let summary: String
  var flag: String
  
  init(name: String, country: String, temp: Double, icon: String, summary: String, flag: String) {
    self.name = name
    self.country = country
    self.temp = temp
    self.icon = icon
    self.summary = summary
    self.flag = flag
  }
}
