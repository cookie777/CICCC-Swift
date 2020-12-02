//
//  ViewController.swift
//  Light
//
//  Created by Takayuki Yamaguchi on 2020-12-01.
//

import UIKit

class ViewController: UIViewController {
    
    
    var lightOn = true

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateUI() 
    }


    func updateUI() {
        view.backgroundColor = lightOn ? .white : .black
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        lightOn.toggle()
        updateUI()
    }
}

