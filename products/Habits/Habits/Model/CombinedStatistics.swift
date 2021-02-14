//
//  CombinedStatistics.swift
//  Habits
//
//  Created by Takayuki Yamaguchi on 2021-02-13.
//

import Foundation

struct CombinedStatistics {
    let userStatistics: [UserStatistics]
    let habitStatistics: [HabitStatistics]
}

extension CombinedStatistics: Codable  {}
