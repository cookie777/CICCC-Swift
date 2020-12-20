//
//  main.swift
//  Closures
//
//  Created by Derrick Park on 2020-12-17.
//

import Foundation
//
//// Higher-Order Functions
//// - map
//// - filter
//// - reduce
//// - forEach
//// - compactMap (no-nil)
//// - flatMap
//
//var firstNames: [String] = ["Adriano", "Yumi", "Gil", "Takayuki", "Kengo", "Takayasu"]
//// firstNames.compactMap { $0 }
//
//// [[1, 2], [3, 4, 5], [7, 8]] -> flatten -> [1, 2, 3, 4, 5, 7, 8]
//firstNames.forEach { print($0) }
//firstNames = firstNames.map { $0 + " Smith" }
//print(firstNames)
//
//let shortNames = firstNames.filter { $0.count < 11 }
//print(shortNames)
//
//let sumOfChar = firstNames.reduce(0) { $0 + $1.count }
//print(sumOfChar)
//
//let concatNames = firstNames.reduce("") { $0 + ", " + $1 }
//
//let cities = ["LA", "Kairo", "Dubai", "Rome", "Singapore", "Paris", "NY"]
//// cities.enumerated() = [(0, "LA"), (1, "Kairo"), (2, "Dubai"), ...]
//for city in cities.enumerated() {
//  print("\(city.0) index: \(city.1)")
//}
//
//let concatNamesImproved = firstNames.enumerated().reduce("") {
//  $1.offset == 0 ? $0 + $1.element : $0 + ", " + $1.element
//}
//
////print(concatNames)
//print(concatNamesImproved)
//
//enum MathOperation {
//  case addition
//  case subtraction
//  case multiplication
//  case division
//}
//
//func pleaseDo(_ op: MathOperation) -> ((Int, Int) -> Int) {
//  switch op {
//  case .addition:
//    return { $0 + $1 }
//  case .subtraction:
//    return { $0 - $1 }
//  case .multiplication:
//    return { $0 * $1 }
//  case .division:
//    return { $0 / $1 }
//  }
//}
//
//let operationTodo = pleaseDo(.addition)
//print(operationTodo(10, 20))
//
//print(pleaseDo(.multiplication)(5, 20))
//
//
//class Apartment {
//  var name: String
//  var tenant: Tenant?
//  init(name: String) {
//    self.name = name
//    print("\(name) is created!")
//  }
//  deinit {
//    print("\(name) is destroyed!")
//  }
//}
//
//class Tenant {
//  var name: String
//  var address: Apartment?
//  init(name: String) {
//    self.name = name
//    print("\(name) is born!")
//  }
//  deinit {
//    print("\(name) is dead!")
//  }
//}
//
//var t1: Tenant? = Tenant(name: "Kazu")
//var a1: Apartment? = Apartment(name: "Downtown")
//t1?.address = a1
//a1?.tenant = t1
//
//t1 = nil
//a1 = nil




class Apartment {
  var name: String
  func test1(){
    self.name = "test"
  }
  lazy var test2 = test1
  
  init(name: String) {
    self.name = name
    print("\(name) is created!")
    print(test1)
    print({self.name = "test"})
  }

  deinit {
    print("\(name) is destroyed!")
  }
}

var a1: Apartment? = Apartment(name: "Downtown")
a1 = nil
