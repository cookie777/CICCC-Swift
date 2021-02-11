//
//  APIService.swift
//  Habits
//
//  Created by Takayuki Yamaguchi on 2021-02-11.
//

import Foundation

struct HabitRequest: APIRequest {
  
  
  typealias Response = [String: Habit]
  var habitName: String?
  var path: String {"/habits"} // why as computed var?
  
}
