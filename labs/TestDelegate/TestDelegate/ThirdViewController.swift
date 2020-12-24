//
//  ThirdViewController.swift
//  TestDelegate
//
//  Created by Takayuki Yamaguchi on 2020-12-23.
//

import UIKit

class ThirdViewController: UIViewController {

    let bt = BossButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        
        view.addSubview(bt)
        bt.delegate = self
    
    }


}

extension ThirdViewController: BossButtonDelegate {
    
    func additonalActionIfTheButtonPressed() {
        print("The third vc will do this task instead of boss🤩")
    }
}
