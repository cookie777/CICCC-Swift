//
//  ViewController.swift
//  AutoLayout
//
//  Created by Takayuki Yamaguchi on 2020-12-07.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let subview = UIView()
        subview.backgroundColor = UIColor.blue
        view.addSubview(subview)
        
        subview.translatesAutoresizingMaskIntoConstraints = false
    }


    
    
}

