//
//  PhotoInfoAPI.swift
//  WWW
//
//  Created by Derrick Park on 2021-01-14.
//

import Foundation
import UIKit


class PhotoInfoAPI {
  
  static let shared = PhotoInfoAPI()
  
  private var dataTask: URLSessionDataTask?
  
  private init() { }
  
  func fetchPhotoInfo(completion: @escaping (Result<PhotoInfo, NetworkError>) -> Void) {
    var urlComponents = URLComponents(string: Endpoint.baseUrl)!
    urlComponents.queryItems = [
      Parameter.apiKey: "DEMO_KEY" // hide the api_key unless private repo
    ].map { URLQueryItem(name: $0.key, value: $0.value) }
    
    fetch(from: urlComponents.url!) { (result: Result<PhotoInfo, NetworkError>) in
      completion(result)
    }
  }
  
  private func fetch<T: Decodable>(from url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
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
          completion(.failure(.client(message: "response body(data) is nil")))
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
  
  func fetchImage(from url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
      if let data = data, let image = UIImage(data: data) {
        completion(.success(image))
      } else if let error = error {
        completion(.failure(NetworkError.client(message: error.localizedDescription)))
      } else {
        completion(.failure(PhotoInfoError.imageDataMissing))
      }
    }
    task.resume()
  }
  
  struct Endpoint {
    static let baseUrl = "https://api.nasa.gov/planetary/apod"
  }
  
  struct Parameter {
    static let apiKey = "api_key"
  }
  
  enum NetworkError: Error {
    case client(message: String)
    case server
  }
  
  enum PhotoInfoError: Error, LocalizedError {
    case imageDataMissing
  }
}

extension PhotoInfoAPI.NetworkError: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .server:
      return NSLocalizedString("Server error!", comment: "")
    case .client(let message):
      return NSLocalizedString("Client error! - \(message)", comment: "")
    }
  }
}
