//
//  Heritage.swift
//  WWW
//
//  Created by Derrick Park on 2021-01-13.
//

import Foundation

struct Heritage: Codable {
  var records: [Record]
  
  struct Record: Codable {
    var datasetid: String
    var recordid: String
    var fields: Fields
    var geometry: Geometry
    
    struct Fields: Codable {
      var category: String
      var region: String
      var site: String
    }
    struct Geometry: Codable {
      var type: String
    //  var coordinates: [Double]
    }
  }
  
  static func fetchHeritageList() {
    URLSession.shared.dataTask(with: URL(string: "https://data.opendatasoft.com/api/records/1.0/search/?dataset=world-heritage-list%40public-us&sort=date_inscribed&facet=category&facet=region&facet=states")!) { (data, res, err) in
      
      let decoder = JSONDecoder()
      if let err = err {
        print(err)
      }
      if let data = data {
        do {
          let heritage = try decoder.decode(Heritage.self, from: data)
          for record in heritage.records {
            print(record)
          }
          
        } catch {
          print(error)
        }
      }
    }.resume()
  }
}
