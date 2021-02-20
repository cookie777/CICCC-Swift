//
//  FloatingPointTestCase.swift
//  TestingDemoTests
//
//  Created by Derrick Park on 2021-02-19.
//

import XCTest
@testable import TestingDemo

class FloatingPointTestCase: XCTestCase {
  func test_isInteger() {
    XCTAssert(1.0.isInteger, "it has to be an integer.")
    XCTAssertFalse((1.1 as CGFloat).isInteger)
  }

  func test_sum() {
    XCTAssertEqual([0.5, 1, 1.5].sum, 3)
    XCTAssertNil(Set<CGFloat>().sum)
    
    let oneThird = 1.0 / 3
    XCTAssertEqual(
      try XCTUnwrap(Array(repeating: oneThird, count: 300).sum),
      100,
      accuracy: pow(0.1, 9)
    )
  }
}
