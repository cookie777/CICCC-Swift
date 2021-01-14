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

extension PhotoInfo {
  // Result
  // - .success
  // - .failure
  static func fetchPhotoInfo(completion: @escaping (Result<PhotoInfo, Error>) -> Void) {
    let jsonDecoder = JSONDecoder()
    let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY")! // 1
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in  // 2
      // data: Data? - the body of the response or the data you requested form the server
      // response: URLResponse? - info about the response itself, including a status code any header feilds
      // error: Error? - any error that may have occurred while running the network request
      if let data = data {
        do {
          let photoIno = try jsonDecoder.decode(PhotoInfo.self, from: data)
          completion(.success(photoIno))
        } catch {
          completion(.failure(error))
        }
      }
    }
    task.resume()  // 3
  } // 4
}
