//
//  SecondViewController.swift
//  TestDelegate
//
//  Created by Takayuki Yamaguchi on 2020-12-23.
//

import UIKit

class SecondViewController: UIViewController, BossButtonDelegate {

    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray
        
        let bt = BossButton()
        view.addSubview(bt)
        
        bt.delegate = self
    }
    
    
    func additonalActionIfTheButtonPressed() {
        print("The second vc will do this task instead of boss😎")
    }


}
