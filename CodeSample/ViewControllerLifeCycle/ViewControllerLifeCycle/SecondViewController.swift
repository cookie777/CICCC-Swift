//
//  SecondViewController.swift
//  LifeCycle
//
//  Created by Derrick Park on 2019-05-09.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class SecondViewController: VCLLoggingViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // When the view controller loads the view into Memory.
    // (not yet visible)
    // This process creates the views that the controller will manage.
    // Gets called once when the views are loaded to the memory.
    // 1. Initialization of views (set attributes of views)
    // 2. Network requests
    // 3. Database access
//    print("SecondViewController - View Did Load")
  }

  // For work that will be performed multiple times, your app
  // can rely on these view event notifications (life cycle methods)
  // When the visibility of its views changes, a view controller will
  // automatically call its life cycle methods.


  // This method gets called right before the view is displayed (everytime).
  // 1. Updating user location.
  // 2. Updating or refreshing some views. (everytime)
  // 3. Starting network requests.
  // 4. Adjust screen orientations. (portrait, landscape)
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
//    print("SecondViewController - View Will Appear")
  }

  // Gets called right after the view appears on the screen.
  // 1. Start an animation
  // 2. long running code (fetching data, database access)
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
//    print("SecondViewController - View Did Appear")
  }

  // These methods execute when the user navigates away from the screen
  // by tapping the back button, switching tabs, or presenting or dismissing
  // a modal view controller.

  // Gets called right before the disappear from the screen.
  // 1. Saving edits.
  // 2. Hiding the keyboards
  // 3. Canceling network requests.
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
//    print("SecondViewController - View Will Disappear")
  }

  // Gets called right after the view disappears from the screen.
  // (usually after the user navigated to a new view)
  // 1. Stop services related to the view.
  //    (playing audio, removing notification observers)
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
//    print("SecondViewController - View Did Disappear")
  }
 
}
