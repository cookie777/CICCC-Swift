//
//  BlueViewController.swift
//  TrafficSeguesProgrammatic
//
//  Created by Derrick Park on 2020-12-11.
//

import UIKit

class BlueViewController: UIViewController {
  
  let imageView: UIImageView = {
    let iv = UIImageView(image: UIImage(named: "swift"))
    iv.translatesAutoresizingMaskIntoConstraints = false
    iv.contentMode = .scaleAspectFit
    return iv
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBlue
    view.addSubview(imageView)
    
    imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
    imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true    
  }
}
