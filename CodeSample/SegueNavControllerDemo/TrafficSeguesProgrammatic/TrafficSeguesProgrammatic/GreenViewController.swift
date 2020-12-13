//
//  GreenViewController.swift
//  TrafficSeguesProgrammatic
//
//  Created by Derrick Park on 2020-12-11.
//

import UIKit

class GreenViewController: UIViewController {
  
  let dismissButton: UIButton = {
    let btn = UIButton(type: .system)
    btn.setTitle("Dismiss", for: .normal)
    btn.translatesAutoresizingMaskIntoConstraints = false
    return btn
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // set title navigation item title
    title = "Green"
    navigationController?.navigationBar.prefersLargeTitles = true
    view.backgroundColor = .green
    view.addSubview(dismissButton)
    dismissButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    dismissButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    dismissButton.addTarget(self, action: #selector(dismissButtonTapped(_:)), for: .touchUpInside)

  }

  @objc func dismissButtonTapped(_ sender: UIButton) {
    navigationController?.popToRootViewController(animated: true)
  }
}
