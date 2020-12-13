//
//  YellowViewController.swift
//  TrafficSeguesProgrammatic
//
//  Created by Derrick Park on 2020-12-11.
//

import UIKit

class YellowViewController: UIViewController {
  
  let goButton: UIButton = {
    let btn = UIButton(type: .system)
    btn.setTitle("Go Next", for: .normal)
    btn.translatesAutoresizingMaskIntoConstraints = false
    return btn
  }()
  
  let label: UILabel = {
    let lb = UILabel()
    lb.textAlignment = .center
    lb.translatesAutoresizingMaskIntoConstraints = false
    return lb
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // set title navigation item title
//    title = "Yellow"
    navigationController?.navigationBar.prefersLargeTitles = true
    view.backgroundColor = .yellow
    view.addSubview(goButton)
    goButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    goButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    goButton.addTarget(self, action: #selector(goButtonTapped(_:)), for: .touchUpInside)
    
    view.addSubview(label)
    label.bottomAnchor.constraint(equalTo: goButton.topAnchor, constant: -50).isActive = true
    label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80).isActive = true
    label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80).isActive = true
    label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
  }

  @objc func goButtonTapped(_ sender: UIButton) {
    let greenVC = GreenViewController()
    navigationController?.pushViewController(greenVC, animated: true)
  }
}
