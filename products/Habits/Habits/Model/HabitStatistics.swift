//
//  HabitStatistics.swift
//  Habits
//
//  Created by Takayuki Yamaguchi on 2021-02-12.
//

import Foundation

struct HabitStatistics {
    let habit: Habit
    let userCounts: [UserCount]
}

extension HabitStatistics: Codable { }

struct UserCount {
    let user: User
    let count: Int
}

extension UserCount: Codable { }

extension UserCount: Hashable { }
