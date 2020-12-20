//
//  ViewController.swift
//  PresentTest
//
//  Created by Takayuki Yamaguchi on 2020-12-19.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    view.backgroundColor = .blue
    let tap = UITapGestureRecognizer(target: self, action: #selector(goNext))
    tap.numberOfTapsRequired = 1
    view.addGestureRecognizer(tap)
  }

  @objc func goNext(){
    print("aaa")
    present(ViewController(), animated: true, completion: nil)
  }
    

}

