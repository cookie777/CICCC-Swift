//
//  MenuController.swift
//  Restaurant
//
//  Created by Takayuki Yamaguchi on 2021-01-15.
//

import Foundation

/*
 A controller for managing networking(api)
 */

class MenuController {
  
  // Use singliton
  static let shared = MenuController()
  private init(){}
  
  private let baseURL = URL(string: "http://localhost:8080/")!
  
  
  // GET: Fetch categories as [String], by categoriesURL
  func fetchCategories(completion: @escaping (Result<[String],Error>) -> () )  {
    
    // just adding "path" to base url,
    // eg, http://localhost:8080/categories
    let categoriesURL = baseURL.appendingPathComponent("categories")
    
    
    URLSession.shared.dataTask(with: categoriesURL) { (data, response, error) in
      
      // try to get data. If can not && there is an error ->  pass error.
      guard let data = data else{
        guard let error = error else{return}
        completion(.failure(error))
        return
      }
      
      // Try to decode from json to your prepared data type.
      do{
        let jsonDecoder = JSONDecoder()
        let categoriesResponse =  try jsonDecoder.decode(CategoryResponse.self, from: data)
        completion(.success(categoriesResponse.categories))
      }catch{
        completion(.failure(error))
      }
      
    }.resume()
    
  }
  
  // GET: Fetch menu items as [MenuItem], by specifying categoryName
  func fetchMenuItems(forCategory categoryName: String,
                      completion: @escaping (Result<[MenuItem],Error>) -> () ){
    
    let categoriesURL = baseURL.appendingPathComponent("menu")
    
    // Create url component so that you can easily attach your query
    var component = URLComponents(url: categoriesURL, resolvingAgainstBaseURL: true)!
    // attach query by using URLQueryItem, name(key) as "category", value as \(categoryName)
    // this will be like http://localhost:8080/categories/?category=\(categoryName)
    component.queryItems = [URLQueryItem(name: "category", value: categoryName)]
    // and get the combined url form component
    let mainURL = component.url!
    
    
    URLSession.shared.dataTask(with: mainURL) { (data, response, error) in
      
      if let data = data{
        let jsonDecoder = JSONDecoder()
        do {
          let menuResponse = try jsonDecoder.decode(MenuResponse.self, from: data)
          completion(.success(menuResponse.items))
        }catch{
          completion(.failure(error))
        }
        
        
      }else if let error = error{
        completion(.failure(error))
      }
      
    }.resume()
    
  }
  
  
  // This is to make it easily understand what is Int?
  typealias MinutesToPrepare = Int
  // POST: get prep time as Int, by specifying(submitting) menuID[Int]
  func submitOrder(forMenuIDs menuIDs: [Int],
                   completion: @escaping (Result<MinutesToPrepare, Error>) -> ()) {
    let orderURL = baseURL.appendingPathComponent("order")
    

    //As for post, we make request instead of url
    var request = URLRequest(url: orderURL)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-type")
    
    // set the data(you're going to post) to request.
    let data = ["menuIds": menuIDs]
    let jsonEncoder = JSONEncoder()
    let jsonData =  try? jsonEncoder.encode(data)
    request.httpBody = jsonData
    
    URLSession.shared.dataTask(with: request) { (data, response, error) in
      // try to get data. If can not && there is an error ->  pass error.
      guard let data = data else{
        guard let error = error else{return}
        completion(.failure(error))
        return
      }
      
      // Try to decode from json to your prepared data type.
      do{
        let jsonDecoder = JSONDecoder()
        let orderResponse =  try jsonDecoder.decode(OrderResponse.self, from: data)
        completion(.success(orderResponse.prepTime))
      }catch{
        completion(.failure(error))
      }
    }.resume()
    
  }
}
