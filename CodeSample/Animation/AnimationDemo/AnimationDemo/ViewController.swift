//
//  ViewController.swift
//  AnimationDemo
//
//  Created by Derrick Park on 2021-01-12.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    example5()
  }

  // change the background color of the squre view
  func example1() {
    let square = UIView(frame: .init(x: 0, y: 44, width: 100, height: 100))
    square.backgroundColor = .purple
    view.addSubview(square)
    UIView.animate(withDuration: 3.0) {
      square.backgroundColor = .orange
    }
  }

  // make the square larger and move it to the center of the view
  func example2() {
    let square = UIView(frame: .init(x: 0, y: 44, width: 100, height: 100))
    square.backgroundColor = .purple
    view.addSubview(square)
    UIView.animate(withDuration: 3.0) {
      square.backgroundColor = .orange
      square.frame = CGRect(x: self.view.frame.size.width / 2 - 100, y: self.view.frame.size.height / 2 - 100, width: 200, height: 200)
    }
  }
  
  // make the square larger and move it to the center of the view, and then move back to the original position
  func example3() {
    let originalFrame = CGRect(x: 0, y: 44, width: 100, height: 100)
    let square = UIView(frame: originalFrame)
    square.backgroundColor = .purple
    view.addSubview(square)
    
    UIView.animate(withDuration: 3.0) {
      square.backgroundColor = .orange
      square.frame = CGRect(x: self.view.frame.size.width / 2 - 100, y: self.view.frame.size.height / 2 - 100, width: 200, height: 200)
    } completion: { (isDone: Bool) in
      UIView.animate(withDuration: 3.0) {
        square.backgroundColor = .purple
        square.frame = originalFrame
      }
    }
  }
  
  // make the square move from the top-left corner to the bottom-right over 3 seconds.
  // after 2 seconds delay (just for the first time), repeat the same animation indefinitely with no completion closure.
  func example4() {
    let originalFrame = CGRect(x: 0, y: 44, width: 100, height: 100)
    let square = UIView(frame: originalFrame)
    square.backgroundColor = .purple
    square.alpha = 0.0
    view.addSubview(square)
    
    UIView.animate(withDuration: 3.0, delay: 2.0, options: [.repeat], animations: {
      square.backgroundColor = .orange
      square.alpha = 1.0
      square.frame = CGRect(x: self.view.frame.size.width / 2 - 100, y: self.view.frame.size.height / 2 - 100, width: 200, height: 200)
    }, completion: nil)
  }
  
  // CG'AffineTransform'
  // UIKit
  // CA: CoreAnimation
  // CG: CoreGraphics
  // 'Metal'
  func example5() {
    let originalFrame = CGRect(x: 0, y: 44, width: 100, height: 100)
    let square = UIView(frame: originalFrame)
    square.backgroundColor = .purple
    view.addSubview(square)
    
    UIView.animate(withDuration: 2.0) {
      let scaleTransform = CGAffineTransform(scaleX: 2.0, y: 2.0)
      let translateTransform = CGAffineTransform(translationX: self.view.frame.size.width / 2 - 50, y: self.view.frame.size.height / 2 - 50)
      let rotateTransform = CGAffineTransform(rotationAngle: .pi) // max - .pi (180)
      square.transform = scaleTransform.concatenating(rotateTransform).concatenating(translateTransform)
    } completion: { (_) in
      UIView.animate(withDuration: 2.0) {
        square.transform = .identity
      }
    }
  }
  
}

