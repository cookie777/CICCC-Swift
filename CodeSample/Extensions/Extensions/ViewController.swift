//
//  ViewController.swift
//  Extensions
//
//  Created by Derrick Park on 2020-12-18.
//

import UIKit

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.random
    let imageView = UIImageView(image: UIImage(named: "christmas"))
    imageView.contentMode = .scaleAspectFit
    view.addSubview(imageView)
//    imageView.matchParent(padding: .init(top: 50, left: 20, bottom: 50, right: 20))
    imageView.constraintWidth(equalToConstant: 150, heightEqualToConstant: 150)
    imageView.centerXYin(view)
    
    let redView = UIView()
    redView.backgroundColor = .red
    view.addSubview(redView)
    redView.anchors(topAnchor: view.topAnchor, leadingAnchor: view.leadingAnchor, trailingAnchor: view.trailingAnchor, bottomAnchor: imageView.topAnchor, padding: .init(top: 100, left: 100, bottom: 50, right: 100))
    
//    let vStackView = VerticalStackView(
//      arrangedSubviews: [redView, imageView],
//      spacing: 20,
//      alignment: .center,
//      distribution: .fill
//    )
//    view.addSubview(vStackView)
    let str1 = "Hello"
    //          01234
    print(str1[0, 4])
    print(str1[3])
    print(str1[2, 4])
    print(str1[1, 5])
    // addTwo(10, 20)
  }
  
  // Docstring: (shortcut) cmd + option + /
  
  /// Returns the **sum** of two integers
  /// - Parameters:
  ///   - a: the first *integer*
  ///   - b: the second *integer*
  /// - Returns: the sum of `a` and `b`
  func addTwo(_ a: Int, _ b: Int) -> Int {
    return a + b
  }
}

// MARK: - Lifecycle methods appear
extension ViewController {
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
}

// MARK: - Lifecycle methods disappear
extension ViewController {
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
  }
}
