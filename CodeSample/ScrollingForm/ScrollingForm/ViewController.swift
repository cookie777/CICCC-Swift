//
//  ViewController.swift
//  ScrollingForm
//
//  Created by Derrick Park on 2021-01-04.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet var scrollView: UIScrollView!

  override func viewDidLoad() {
    super.viewDidLoad()
    registerForKeyboardNotification()
    let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
    view.addGestureRecognizer(gestureRecognizer)
    
    scrollView.delegate = self
  }
  
  @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
    view.endEditing(true)
  }
  
  fileprivate func registerForKeyboardNotification() {
    // 1. I want to listen to the keyboard showing / hiding
    //    - "hey iOS, tell(notify) me when keyboard shows / hides"
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  @objc func keyboardWasShown(_ notification: NSNotification) {
    // 2. When notified, I want to ask iOS the size(height) of the keyboard
    
    guard let info = notification.userInfo, let keyboardFrameValue = info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else { return }
    
    let keyboardFrame = keyboardFrameValue.cgRectValue
    let keyboardHeight = keyboardFrame.size.height
    
    // 3. Tell scrollview to scroll up (height)
    let insets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
    scrollView.contentInset = insets
    scrollView.scrollIndicatorInsets = insets
  }

  @objc func keyboardWillBeHidden(_ notification: NSNotification) {
    // 2. When notified, I want to ask iOS the size(height) of the keyboard
    // 3. Tell scrollview to scroll down (height)
    let insets = UIEdgeInsets.zero
    scrollView.contentInset = insets
    scrollView.scrollIndicatorInsets = insets
  }

}

extension ViewController: UIScrollViewDelegate {
  // page 88: Lab scrollView Zoom
  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    return nil
  }
}
