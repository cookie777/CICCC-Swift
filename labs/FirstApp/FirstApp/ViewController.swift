//
//  ViewController.swift
//  FirstApp
//
//  Created by Takayuki Yamaguchi on 2020-12-01.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var printButton: UIButton!
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var displayLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        userNameTextField.text = ""
        displayLabel.text = ""
    }

    @IBAction func printButtonTapped(_ sender: UIButton) {
        print("printButtonTapped")
        displayLabel.text = userNameTextField.text
        
    }
    
}

