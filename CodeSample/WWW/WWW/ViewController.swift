//
//  ViewController.swift
//  WWW
//
//  Created by Derrick Park on 2021-01-13.
//
//  Code Formatting : CMD + a (select all), Ctrl + i (format)

import UIKit

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // multithreading (concurrency)
    PhotoInfo.fetchPhotoInfo { (result) in
      switch result {
      case .success(let photoInfo):
        print("Successfully fetched PhotoInfo: \(photoInfo)")
      case .failure(let error):
        print("Fetch Photo Failed with Error: \(error)")
      }
    }
  }
}

