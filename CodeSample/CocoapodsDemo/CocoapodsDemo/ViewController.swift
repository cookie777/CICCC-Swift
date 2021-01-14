//
//  ViewController.swift
//  CocoapodsDemo
//
//  Created by Derrick Park on 2021-01-13.
//

import UIKit
import SDWebImage
// Cocoapods - dependency (package) manager for iOS
// ex) npm, brew, gem, pip, gradle, ...

// install - `sudo gem install cocoapods`
//         - (optional m1) `sudo gem install ffi`
// navigate to your project - `pod init`  (creates Podfile)
// open Podfile - add dependencies
// `pod install`
// open "xcworkspace" instead of xcodeproj
class ViewController: UIViewController {
  
  @IBOutlet var imageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    PhotoInfo.fetchPhotoInfo { [weak self] (result) in
      switch result {
      case .success(let photoInfo):
        self?.imageView.sd_setImage(with: photoInfo.url, completed: nil)
        print("Successfully fetched PhotoInfo: \(photoInfo)")
      case .failure(let error):
        print("Fetch Photo Failed with Error: \(error)")
      }
    }
  }
}

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
