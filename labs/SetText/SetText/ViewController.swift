//
//  ViewController.swift
//  SetText
//
//  Created by Takayuki Yamaguchi on 2020-12-04.
//

import UIKit

class ViewController: UIViewController {
   
    @IBOutlet weak var textFiled: UITextField!
    @IBOutlet weak var textFiledLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initTextFiledLabel()
    }

    @IBAction func clearTextPressed(_ sender: UIButton) {
        initTextFiledLabel()
    }
    @IBAction func setTextPressed(_ sender: UIButton) {
        textFiledLabel.text = textFiled.text
    }
    
    func initTextFiledLabel() {
        textFiledLabel.text = ""
    }
    
}

