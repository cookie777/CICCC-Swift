//
//  Request.swift
//  NewsAPI
//
//  Created by Derrick Park on 5/24/20.
//  Copyright © 2020 Derrick Park. All rights reserved.
//

import UIKit

private let API_KEY = "2a3457158d8e4fae9223d742c8d0e777"

class NewsAPIRequest {
  
  static let shared = NewsAPIRequest()
  
  private var dataTask: URLSessionDataTask?
  
  private init() { }
  
  func getEverything(with query: String, completion: @escaping (Articles?) -> Void) {
    let url = URL(string: EndPoint.everything)!
      .withQueries(
        [Parameter.q: query,
         Parameter.apiKey: API_KEY,
         Parameter.country: "us"])!
    fetch(from: url) { (result: Result<Articles, NetworkError>) in
      switch result {
        case .success(let articles):
          completion(articles)
        case .failure(let error):
          debugPrint(error.errorDescription!)
          completion(nil)
      }
    }
  }
  
  func getTopHeadlines(with query: String, completion: @escaping (Articles?) -> Void) {
    let url = URL(string: EndPoint.topHeadlines)!
      .withQueries(
        [Parameter.q: query,
         Parameter.apiKey: API_KEY,
         Parameter.country: "us"])!
    fetch(from: url) { (result: Result<Articles, NetworkError>) in
      switch result {
        case .success(let articles):
          completion(articles)
        case .failure(let error):
          debugPrint(error.errorDescription!)
          completion(nil)
      }
    }
  }
  
  func fetch<T: Decodable>(from url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
    dataTask?.cancel()
    
    dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
      guard error == nil else {
        completion(.failure(.client(message: "invalid request")))
        return
      }
      
      guard let res = response as? HTTPURLResponse, (200...299).contains(res.statusCode) else {
        completion(.failure(.server))
        return
      }
      
      do {
        guard let data = data else {
          completion(.failure(.client(message: "data is nil")))
          return
        }
        let decodable = try JSONDecoder().decode(T.self, from: data)
        completion(.success(decodable))
      } catch {
        completion(.failure(.client(message: error.localizedDescription)))
      }
    }
    dataTask?.resume()
    
  }
  
  struct EndPoint {
    static let baseURL = "https://newsapi.org/v2/"
    static let topHeadlines = "https://newsapi.org/v2/top-headlines"
    static let everything = "https://newsapi.org/v2/everything"
  }
  
  struct Parameter {
    static let q = "q"
    static let apiKey = "apiKey"
    static let country = "country"
  }
  
  enum NetworkError: Error {
    case client(message: String)
    case server
  }
}

extension NewsAPIRequest.NetworkError: LocalizedError {
  var errorDescription: String? {
    switch self {
      case .server:
        return NSLocalizedString(
          "Server error!",
          comment: ""
      )
      case .client(let message):
        return NSLocalizedString(
          "Client error! - \(message)",
          comment: ""
      )
    }
  }
}
