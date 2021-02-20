//
//  Sequence.swift
//  TestingDemo
//
//  Created by Derrick Park on 2021-02-19.
//

import Foundation

extension Sequence where Element: AdditiveArithmetic {
  var first: Element? { first { _ in true } }
  
  var sum: Element? {
    guard let first = first else { return nil }
    return dropFirst().reduce(first, +)
  }
}
