//
//  ResponseModels.swift
//  Restaurant
//
//  Created by Takayuki Yamaguchi on 2021-01-14.
//

import Foundation

// For storing (Menu : [MenuItem] ) in the Response
struct MenuResponse: Codable {
  let items: [MenuItem]
}

// For storing (category: [String] ) in the Response
struct CategoryResponse: Codable {
  let categories: [String]
}

// For storing order data (== prep time) in the Response
struct OrderResponse: Codable{
  let prepTime: Int

  enum CodingKeys: String, CodingKey {
    case prepTime = "preparation_time"
  }

}
