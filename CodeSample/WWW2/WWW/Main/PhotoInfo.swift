//
//  PhotoInfo.swift
//  WWW
//
//  Created by Derrick Park on 2021-01-13.
//

import Foundation

struct PhotoInfo: Codable {
  var title: String
  var description: String // description
  var url: URL
  var copyright: String?
  
  enum CodingKeys: String, CodingKey {
    case title
    case description = "explanation"
    case url
    case copyright
  }
}
