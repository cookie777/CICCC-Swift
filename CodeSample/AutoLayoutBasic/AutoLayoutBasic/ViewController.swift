//
//  ViewController.swift
//  AutoLayoutBasic
//
//  Created by Derrick Park on 12/7/20.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    stackViewExample()
//    let rect = CGRect(x: 12, y: 50, width: 100, height: 100)
//    let greenView = UIView()
//    greenView.backgroundColor = .green
//    view.addSubview(greenView)
//    // MUST! autolayout programmatically (constraints)
//    greenView.translatesAutoresizingMaskIntoConstraints = false
//    greenView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12).isActive = true
//    greenView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
//    greenView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12).isActive = true
//    greenView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
//
//    let redCircleView = UIView()
//    redCircleView.backgroundColor = .red
//
//    view.addSubview(redCircleView)
//    redCircleView.translatesAutoresizingMaskIntoConstraints = false
//    redCircleView.topAnchor.constraint(equalTo: greenView.bottomAnchor, constant: 12).isActive = true
//    redCircleView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//    redCircleView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3).isActive = true
//    redCircleView.heightAnchor.constraint(equalTo: redCircleView.widthAnchor).isActive = true
//    redCircleView.layer.cornerRadius = (view.frame.width * 0.3) / 2
    
  }

  func stackViewExample() {
    let label1 = UILabel()
    label1.text = "Vancouver is raining..."
    label1.textAlignment = .center
    label1.translatesAutoresizingMaskIntoConstraints = false
    
    let label2 = UILabel()
    label2.text = "Tokyo is cloudy..."
    label2.textAlignment = .center
    label2.translatesAutoresizingMaskIntoConstraints = false
    
    let label3 = UILabel()
    label3.text = "Toronto is cold..."
    label3.textAlignment = .center
    label3.translatesAutoresizingMaskIntoConstraints = false
    
    let stackView = UIStackView(arrangedSubviews: [label1, label2, label3])
    stackView.axis = .vertical
    stackView.alignment = .center
//    stackView.distribution = .fillEqually
//    stackView.spacing = 20
    stackView.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(stackView)
    stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
    stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
    stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    stackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7).isActive = true
  }

}

