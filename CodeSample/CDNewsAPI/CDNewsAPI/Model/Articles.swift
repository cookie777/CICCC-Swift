//
//  Articles.swift
//  CDNewsAPI
//
//  Created by Derrick Park on 2021-02-16.
//

import Foundation

struct Articles: Codable {
  let articles: [Article]
  let totalResults: Int
}

struct Article: Codable {
  struct Source: Codable {
    let name: String
  }
  let source: Source
  let author: String?
  let title: String
  let url: URL
  let urlToImage: String?
  let searchText: String?
}

extension Article: Hashable {
  static func == (lhs: Article, rhs: Article) -> Bool {
    return lhs.title == rhs.title
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(title)
  }
}
