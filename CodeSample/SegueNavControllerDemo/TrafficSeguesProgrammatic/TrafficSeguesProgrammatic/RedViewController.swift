//
//  ViewController.swift
//  TrafficSeguesProgrammatic
//
//  Created by Derrick Park on 2020-12-11.
//

import UIKit

// Access modifiers
// ------- library ---------
// * open
// * public
// --------- App -----------
// * internal - default (same mudule (app))
// * fileprivate (same file)
// * private (scope)
class RedViewController: UIViewController {
  
  let goButton: UIButton = {
    let btn = UIButton(type: .system)
    btn.setTitle("Go Next", for: .normal)
    btn.translatesAutoresizingMaskIntoConstraints = false
    return btn
  }()
  
  let textField: UITextField = {
    let tf = UITextField()
    tf.textAlignment = .center
    tf.borderStyle = .roundedRect
    tf.translatesAutoresizingMaskIntoConstraints = false
    return tf
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // set title navigation item title
    title = "Red"
    navigationController?.navigationBar.prefersLargeTitles = true
    view.backgroundColor = .red
    view.addSubview(goButton)
    goButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    goButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    goButton.addTarget(self, action: #selector(goButtonTapped(_:)), for: .touchUpInside)
    
    view.addSubview(textField)
    textField.bottomAnchor.constraint(equalTo: goButton.topAnchor, constant: -50).isActive = true
    textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80).isActive = true
    textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80).isActive = true
    textField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    
    textField.addTarget(self, action: #selector(primaryActionTriggered), for: .primaryActionTriggered)
  }
  
  @objc func primaryActionTriggered(_ sender: UITextField) {
    if sender.text?.lowercased() == "swift" {
      let blueVC = BlueViewController()
      present(blueVC, animated: true, completion: nil)
    }
  }
  
  @objc func goButtonTapped(_ sender: UIButton) {
    let yellowVC = YellowViewController()
    yellowVC.navigationItem.title = textField.text
    yellowVC.label.text = textField.text
    navigationController?.pushViewController(yellowVC, animated: true)
  }
  
}
