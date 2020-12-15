//
//  DetailsViewController.swift
//  Assignment4
//
//  Created by Takayuki Yamaguchi on 2020-12-14.
//  Copyright © 2020 Derrick Park. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
  
  var city: City!
  
  let createDetailView =  { (label : String, value : String) -> UIStackView in
    let lb   = UILabel()
    lb.text  = label
    lb.font  = UIFont.boldSystemFont(ofSize: 20.0)
    let val  = UILabel()
    val.text = value
    
    let sv  = UIStackView(arrangedSubviews: [lb,val])
    sv.translatesAutoresizingMaskIntoConstraints = false
    sv.axis            = .vertical
    sv.alignment       = .center
    sv.distribution    = .equalSpacing
    sv.spacing         = 16
    
    sv.isLayoutMarginsRelativeArrangement = true
    sv.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
    
    return sv
  }
  
  lazy var detailViews   : [UIStackView] = {
    var dvs : [UIStackView] = []
    dvs = [
      createDetailView("Country"    ,"\(city.emoji) \(city.icon)"),
      createDetailView("City"       ,city.name        ),
      createDetailView("Temperature",String(city.temp)),
      createDetailView("Summary"    ,city.summary     )
    ]
    return dvs
  }()
  
  lazy var mainStackView : UIStackView = {
    let sv  = UIStackView(arrangedSubviews: detailViews)
    sv.translatesAutoresizingMaskIntoConstraints = false
    sv.axis            = .vertical
    sv.alignment       = .center
    sv.distribution    = .equalSpacing
    
    sv.isLayoutMarginsRelativeArrangement = true
    sv.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
    
    return sv
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setLayout()
      // Do any additional setup after loading the view.
  }
  
  func setLayout() {
    view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    view.addSubview(mainStackView)
    NSLayoutConstraint.activate([
      mainStackView.centerXAnchor.constraint  (equalTo: view.safeAreaLayoutGuide.centerXAnchor),
      mainStackView.topAnchor.constraint      (equalTo: view.safeAreaLayoutGuide.topAnchor,    constant: 0),
      mainStackView.bottomAnchor.constraint   (equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
    ])
  }


  

  

    
}
