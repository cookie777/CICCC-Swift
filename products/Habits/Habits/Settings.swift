//
//  Settings.swift
//  Habits
//
//  Created by Takayuki Yamaguchi on 2021-02-11.
//

import Foundation




enum Setting{
  static let favoriteHabits = "favoriteHabits"
}


/// Here, we save and load data using user defaults
struct Settings {
  static var shared = Settings()
  private let defaults = UserDefaults.standard
  
  
  /// save data <T> into defaults
  /// - Parameters:
  ///   - value: saving value <T>
  ///   - key: for <T>
  private func archiveJSON<T: Encodable>(value: T, key: String){
    let data =  try! JSONEncoder().encode(value)
    let string = String(data: data, encoding: .utf8)
    defaults.set(string, forKey: key)
  }
  
  
  /// load data <T> from defaults
  /// - Parameters:
  ///   - value: loading value <T>
  ///   - key: for <T>
  /// - Returns: <T>
  private func unarchiveJSON<T: Decodable>(key: String) -> T?{
    guard let string = defaults.string(forKey: key),
          let data = string.data(using: .utf8) else { return nil}
    
    return try! JSONDecoder().decode(T.self, from: data)
  }

  
  var favoriteHabits: [Habit]{
    get {
      return unarchiveJSON(key: Setting.favoriteHabits) ?? []
    }
    set {
      archiveJSON(value: newValue, key: Setting.favoriteHabits)
    }
  }
}
