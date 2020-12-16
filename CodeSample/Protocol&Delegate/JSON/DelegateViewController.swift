//
//  DelegateViewController.swift
//  JSON
//
//  Created by Derrick Park on 2020-12-15.
//

import UIKit

protocol Accountant {
  var certificate: String { get }
  func calculateTax(revenue: Double) -> Double
}
// UITextField
struct Boss {
  // delegate: UITextFieldDelegate
  var taxDelegate: Accountant?
  
  func payTax() -> Double? {
    if let taxDelegate = taxDelegate {
      return taxDelegate.calculateTax(revenue: 1_000_000)
    } else {
      print("You need to assign an accountant! (delegate)")
      return nil
    }
  }
}

// ViewController: UITextFieldDelegate
struct Kazu: Accountant {
  static let hello = "Hello"
  var a = "ehllo"
  var certificate: String {
    return "JA certificate"
  }
  // textFieldShouldReturn
  func calculateTax(revenue: Double) -> Double {
    return revenue * 0.3
  }
}
// ViewController: UITextFieldDelegate
struct Nobu: Accountant {
  var certificate: String {
    return "CA certificate"
  }
  // textFieldShouldReturn
  func calculateTax(revenue: Double) -> Double {
    return revenue * 0.01
  }
}

class DelegateViewController: UIViewController, UITextFieldDelegate {
  
  @IBOutlet var textField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
//    let kazu = Kazu()
//    let nobu = Nobu()
//    var boss = Boss()
//    boss.taxDelegate = kazu
    // when hit 'return'
//    print(boss.payTax() ?? 0)
    textField.delegate = self
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    print("Hello!")
    return true
  }
  
}

// Singleton - the singleton pattern is a software design pattern that restricts the instantiation of a class/struct to one "single" instance.
struct GPSTracker {
  static let shared = GPSTracker()
  private init() { }
}


class TextField {
  var delegate: UITextFieldDelegate?
  func onReturnKeyPressed(_ sender: UITextField) -> Bool {
    if let delegate = delegate {
      return delegate.textFieldShouldReturn!(sender)
    }
    return false
  }
}
