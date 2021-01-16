//
//  Error\.swift
//  Restaurant
//
//  Created by Takayuki Yamaguchi on 2021-01-15.
//

import UIKit

struct Alert {
  // IF failure -> create alert and display it by using UIAlertController.
  static func displayError(target: UIViewController, _ error: Error, title: String){
    let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert )
    alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
    target.present(alert, animated: true)
  }
}
