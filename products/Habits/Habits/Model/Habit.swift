//
//  Habit.swift
//  Habits
//
//  Created by Takayuki Yamaguchi on 2021-02-10.
//

import Foundation

struct Habit {
  let name: String
  let category: Category
  let info: String
}

struct Category {
  let name: String
  let color: Color
}

struct Color {
  let hue: Double
  let saturation: Double
  let brightness: Double
}


extension Color: Codable{
  // adjusting api key name
  enum CodingKeys: String, CodingKey {
    case hue = "h"
    case saturation = "s"
    case brightness = "b"
  }
}

extension Category: Codable {}
extension Habit: Codable{}

extension Habit: Hashable{
  static func == (lhs: Habit, rhs: Habit) -> Bool {
    return lhs.name == rhs.name
  }
  func hash(into hasher: inout Hasher) {
    hasher.combine(name)
  }
}
extension Habit: Comparable{ // This is to make absolute order (so that each time lists won't shuffle)
  static func < (lhs: Habit, rhs: Habit) -> Bool {
    return lhs.name < rhs.name
  }
}

extension Category: Hashable{
  static func == (lhs: Category, rhs: Category) -> Bool {
    return lhs.name == rhs.name
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(name)
  }
}
