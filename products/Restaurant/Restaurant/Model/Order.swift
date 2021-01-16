//
//  Order.swift
//  Restaurant
//
//  Created by Takayuki Yamaguchi on 2021-01-14.
//

import Foundation

struct Order {
  var menuItems : [MenuItem]
  
  init(menuItems : [MenuItem] = []) {
    self.menuItems = menuItems
  }
}
