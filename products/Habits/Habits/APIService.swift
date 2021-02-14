//
//  APIService.swift
//  Habits
//
//  Created by Takayuki Yamaguchi on 2021-02-11.
//

import UIKit




/// fetch habit
struct HabitRequest: APIRequest {
  typealias Response = [String: Habit]
  var habitName: String?
  var path: String {"/habits"} // why as computed var?
}


/// fetch user
struct UserRequest: APIRequest {
  typealias Response = [String: User]
  var path: String {"/users"}
}


/// fetch Habit Statistics
struct HabitStatisticsRequest: APIRequest {
  typealias Response = [HabitStatistics]
  
  var habitNames: [String]?
  
  var path: String { "/habitStats" }
  
  var queryItems: [URLQueryItem]? {
    if let habitNames = habitNames {
      return [URLQueryItem(name: "names", value: habitNames.joined(separator: ","))]
    } else {
      return nil
    }
  }
}


/// fetch user Statistics
struct UserStatisticsRequest: APIRequest {
  typealias Response = [UserStatistics]
  
  var userIDs: [String]?
  
  var path: String { "/userStats" }
  
  var queryItems: [URLQueryItem]? {
    if let userIDs = userIDs {
      return [URLQueryItem(name: "ids", value: userIDs.joined(separator: ","))]
    } else {
      return nil
    }
  }
}


/// fetch habit lead Statistics
struct HabitLeadStatisticsRequest: APIRequest {
  typealias Response = UserStatistics
  
  var userID: String
  
  var path: String { "/userLeadingStats/\(userID)" }
}



struct ImageRequest: APIRequest {
  typealias Response = UIImage
  var imageID: String
  var path: String { "/images/" + imageID }
}

struct LogHabitRequest: APIRequest {
  //because the API doesn't return anything from this POST call, you can declare Void as the response type. You have to declare it explicitly; otherwise, the compiler won't have enough information to infer the API response type that fulfills the generic type requirement.
  typealias Response = Void
  var trackedEvent: LoggedHabit
  var path: String { "/loggedHabit" }
  var postData: Data? {
    let encoder = JSONEncoder()
    //The server uses the common ISO 8601 format for date values, so you set the encoder to use that format.
    encoder.dateEncodingStrategy = .iso8601
    return try! encoder.encode(trackedEvent)
  }
}

struct CombinedStatisticsRequest: APIRequest {
    typealias Response = CombinedStatistics
    var path: String { "/combinedStats" }
}
