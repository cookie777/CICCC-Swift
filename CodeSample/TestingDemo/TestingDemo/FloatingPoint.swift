//
//  FloatingPoint.swift
//  TestingDemo
//
//  Created by Derrick Park on 2021-02-19.
//

import Foundation

extension FloatingPoint {
  var isInteger: Bool {
    rounded() == self
  }
}
