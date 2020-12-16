//
//  ViewController.swift
//  JSON
//
//  Created by Derrick Park on 2020-12-15.
//

import UIKit

// JSON - JavaScript Object Notation
struct Employee: Codable {
  let firstName: String
  let lastName: String
  let jotTitle: String
}

// let emp1 = Employee(firstName: "Kazu", lastName: "Nobu", jotTitle: "Developer")
// XML
// <Employee>
//   <firstName>Kazu</firstName>
//   <lastName>Nobu</lastName>
//   <jotTitle>Developer</jotTitle>
// </Employee>

// JSON
//{
//  "firstName": "Kazu",
//  "lastName": "Nobu",
//  "jobTitle": "Developer"
//}

// Encoding (Swift -> JSON) & Decoding (JSON -> Swift)

struct StarWarsChar: Codable {
  let name: String
  let height: String
  let hairColor: String
  
  enum CodingKeys: String, CodingKey {
    case name = "name"
    case height = "height"
    case hairColor = "hair_color"
  }
}

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    fetchStarWarsChar()
  }
  
  func fetchStarWarsChar() {
    let url = URL(string: "https://swapi.dev/api/people/1/")!
    let task = URLSession.shared.dataTask(with: url) { (data, response, err) in
      guard err == nil else { return }
      guard let httpResponse = response as? HTTPURLResponse else { return }
      if 200 ... 300 ~= httpResponse.statusCode {
        if let data = data {
          do {
            let decoder = JSONDecoder()
            let skywalker = try decoder.decode(StarWarsChar.self, from: data)
            print(skywalker.name)
            print(skywalker.height)
            print(skywalker.hairColor)
          } catch (let e) {
            print(e.localizedDescription)
          }
        }
      }
    }
    task.resume()
  }
}

