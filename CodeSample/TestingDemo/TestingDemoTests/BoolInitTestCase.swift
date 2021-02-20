//
//  BoolInitTestCase.swift
//  TestingDemoTests
//
//  Created by Derrick Park on 2021-02-19.
//

import XCTest
@testable import TestingDemo

// open, public, [internal, fileprivate, private]

class BoolInitTestCase: XCTestCase {
  func test_validBits() throws {
    if let boolFromTrueBit = Bool(bit: 1) {
      XCTAssert(boolFromTrueBit)
    } else {
      XCTFail()
    }
    
    let boolFromFalseBit = try XCTUnwrap(Bool(bit: 0))
    XCTAssertFalse(boolFromFalseBit)
  }
  
  func test_invalidBits() throws {
    XCTAssertNil(Bool(bit: -1))
    XCTAssertNil(Bool(bit: 2))
  }
}
