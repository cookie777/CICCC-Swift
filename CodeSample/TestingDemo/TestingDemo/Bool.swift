//
//  Bool.swift
//  TestingDemo
//
//  Created by Derrick Park on 2021-02-19.
//

import Foundation

extension Bool {
  init?(bit: Int) {
    switch bit {
    case 0:
      self = false
    case 1:
      self = true
    default:
      return nil
    }
  }
}

