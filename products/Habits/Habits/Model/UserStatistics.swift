//
//  UserStatistics.swift
//  Habits
//
//  Created by Takayuki Yamaguchi on 2021-02-12.
//

import Foundation

struct UserStatistics {
  let user: User
  let habitCounts: [HabitCount]
}

extension UserStatistics: Codable { }

struct HabitCount {
  let habit: Habit
  let count: Int
}


extension HabitCount: Codable { }

extension HabitCount: Hashable { }

extension HabitCount: Comparable {
  static func < (lhs: HabitCount, rhs: HabitCount) -> Bool {
    return lhs.habit < rhs.habit
  }
}
