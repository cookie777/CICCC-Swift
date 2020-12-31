//
//  DetailViewController.swift
//  WeatherTabBar
//
//  Created by Derrick Park on 2019-04-24.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  var city: City!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    if let detailsView = Bundle.main.loadNibNamed("DetailsView", owner: self, options: nil)?.first as? DetailsView {
      view.addSubview(detailsView)
      detailsView.setupView(city: city)
      NSLayoutConstraint.activate([
        detailsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        detailsView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
  }
}

