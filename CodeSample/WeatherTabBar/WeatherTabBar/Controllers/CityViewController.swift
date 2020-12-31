//
//  CityViewController.swift
//  WeatherTabBar
//
//  Created by Derrick Park on 2019-04-24.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class CityViewController: UIViewController {
  // depedency injection
  // (you have to initialize all properties -> Optional)
  var city: City! {
    didSet {
      tabBarItem = UITabBarItem(title: city.name, image: UIImage(named: city.icon), selectedImage: nil)
    }
  }
  
  let goDetailsButt: UIButton = {
    let butt = UIButton(title: "Go See Details...", fontSize: 20, cornerRadius: 20)
    butt.addTarget(self, action: #selector(showDetailVC), for: .touchUpInside)
    return butt
  }()
  
  lazy var cityLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    let attr: [NSAttributedString.Key:Any] = [
      .font: UIFont(name: "Chalkduster", size: 30)!,
      .foregroundColor: UIColor.black
    ]
    // NSMutableAttributedString - you can append strings with diff attributes
    label.attributedText = NSAttributedString(string: city.name, attributes: attr)
    label.textAlignment = .center
    return label
  }()
  
  @objc private func showDetailVC() {
    let detailVC = DetailViewController()
    detailVC.city = city
    navigationController?.pushViewController(detailVC, animated: true)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = city.country
    view.backgroundColor = .white
    view.addSubview(cityLabel)
    view.addSubview(goDetailsButt)
    
    NSLayoutConstraint.activate([
      goDetailsButt.widthAnchor.constraint(equalToConstant: 200),
      goDetailsButt.heightAnchor.constraint(equalToConstant: 50),
      goDetailsButt.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      goDetailsButt.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      cityLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
      cityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      ])
  }
  
}

extension UIButton {
  convenience init(title: String, fontSize: CGFloat, cornerRadius: CGFloat) {
    self.init()
    self.translatesAutoresizingMaskIntoConstraints = false
    self.backgroundColor = UIColor.black
    self.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize)
    self.setTitle(title, for: .normal)
    self.layer.cornerRadius = cornerRadius
  }
}
