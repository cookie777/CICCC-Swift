//
//  LoggedHabit.swift
//  Habits
//
//  Created by Takayuki Yamaguchi on 2021-02-13.
//

import Foundation

struct LoggedHabit {
  let userID: String
  let habitName: String
  let timestamp: Date
}

extension LoggedHabit: Codable {}
