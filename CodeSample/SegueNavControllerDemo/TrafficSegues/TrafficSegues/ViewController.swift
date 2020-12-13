//
//  ViewController.swift
//  TrafficSegues
//
//  Created by Derrick Park on 2020-12-11.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet var textField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "RedToYellow" {
      let yellowVC = segue.destination as! YellowViewController
      yellowVC.textStringFromRed = textField.text
      yellowVC.navigationItem.title = textField.text
    }
  }
  
  @IBAction func unwindToRed(unwindSegue: UIStoryboardSegue) {
  }
  
  @IBAction func primaryActionTriggered(_ sender: UITextField) {
    if sender.text?.lowercased() == "swift" {
      performSegue(withIdentifier: "GoBlue", sender: nil)
    } 
  }
  
}

