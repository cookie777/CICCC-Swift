//
//  NetworkController.swift
//  MyCollections
//
//  Created by Takayuki Yamaguchi on 2021-02-06.
//

import Foundation
import UIKit


class NetworkController{
    
    static var shared = NetworkController()
    private init(){}
    
    func fetchImage(urlStr: String?, completionHandler: @escaping (UIImage?) -> Void) {
        
        // check if its type is URL
        guard let urlStr = urlStr, let url = URL(string: urlStr) else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else{
              if let error = error { print(error.localizedDescription)}
              return
            }
            guard let image = UIImage(data: data) else {
//              print("error: couldn't get dat or couldn't convert data into image")
              return
            }
            completionHandler(image)
        }
        task.resume()
        
    }
    
}
