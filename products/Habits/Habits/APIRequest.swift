//
//  APIRequest.swift
//  Habits
//
//  Created by Takayuki Yamaguchi on 2021-02-11.
//

import Foundation

protocol APIRequest {
  associatedtype Response // This is to use generic type in protocol

  var path: String { get }
  var queryItems: [URLQueryItem]? { get }
  var request: URLRequest { get }
  var postData: Data? { get }
  
}

// by using extension, we can set default var and func
extension APIRequest {
  var host: String { "localhost" }
  var port: Int { 8080 }
}

extension APIRequest {
  var queryItems: [URLQueryItem]? { nil }
  var postData: Data? { nil }
}

extension APIRequest {
  var request: URLRequest {
    var components = URLComponents()
    
    components.scheme = "http"
    components.host = host
    components.port = port
    components.path = path
    components.queryItems = queryItems
    
    var request = URLRequest(url: components.url!)
    
    // If there is a postData -> try post
    if let data = postData {
      request.httpBody = data
      request.addValue("application/json",forHTTPHeaderField: "Content-Type")
      request.httpMethod = "POST"
    }
    
    return request
  }
}

// by using where, you can set protocol to generic type
extension APIRequest where Response: Decodable{
  
  func send(completion: @escaping ((Result<Response, Error>) -> Void)){
    
    URLSession.shared.dataTask(with: request){ (data, _ , error) in
      do {
        if let data = data {
          let decoded = try JSONDecoder().decode(Response.self, from: data)
          completion(.success(decoded))
        }else if let e = error {
          completion(.failure(e))
        }
      }catch{
        
      }
    }.resume()
    
  }
}
