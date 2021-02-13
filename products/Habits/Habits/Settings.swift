//
//  Settings.swift
//  Habits
//
//  Created by Takayuki Yamaguchi on 2021-02-11.
//

import Foundation




enum Setting{
  static let favoriteHabits = "favoriteHabits"
  static let followedUserIDs = "followedUserIDs"
}


/// Here, we save and load data using user defaults
struct Settings {
  static var shared = Settings()
  private let defaults = UserDefaults.standard
  let currentUser = User(id: "theRock", name: "Dwayne Johnson", color: nil, bio: "Dwayne Douglas Johnson, also known by his ring name the Rock, is an American-Canadian actor, producer, businessman, retired professional wrestler, and former American football and Canadian football player.")
  
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
  
  
  // Get and set favoriteHabits
  var favoriteHabits: [Habit]{
    get {
      return unarchiveJSON(key: Setting.favoriteHabits) ?? []
    }
    set {
      archiveJSON(value: newValue, key: Setting.favoriteHabits)
    }
  }
  
  mutating func toggleFavorite(_ habit: Habit) {
    var favorites = favoriteHabits
    if favorites.contains(habit) {
      favorites = favorites.filter { $0 != habit }
    } else {
      favorites.append(habit)
    }
    favoriteHabits = favorites
  }
  
  
  var followedUserIDs: [String] {
    get {
      return unarchiveJSON(key: Setting.followedUserIDs) ?? []
    }
    set{
      archiveJSON(value: newValue, key: Setting.followedUserIDs)
    }
  }
  
}
