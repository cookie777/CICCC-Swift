//
//  ViewController.swift
//  ViewControllerLifeCycle
//
//  Created by Derrick Park on 2019-08-22.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class ViewController: VCLLoggingViewController {
  
  /// Primary Setup
  override func viewDidLoad() {
    super.viewDidLoad() // always let super have a chance in lifecycle methods
    // do the primary setup of your ViewController(MVC) here
    // good time to update my View using my Model, for example, because my outlets are set
    
    // * Do not do geometry-related setup here! Your bounds are not yet set!
  }

  /// This method will be sent just before your ViewController(MVC) appears (or re-appears) on screen
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    // catch my View up to date with what went on while I was off-screen
    
    // Note: this method can be called repeatedly (vs. viewDidLoad which is only called once)
  }
  
  /// This method will be called after your ViewController(MVC) has finished appearing on screen
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    // start a time or an animation or start observing something (e.g. GPS position)
    
    // This is also a good place to start something expensive (e.g. network fetch) going.
    // Why kick off expensive things here instead of in viewDidLoad?
    // Because we know we're on screen so it won't be a waste.
    // By "expensive" we usually mean "time consuming" but could also mean battery or storage.
    
    // We must never block our UI from user interaction (thus background fetching, etc.)
    // Our UI might need to come up incomplete and later fill in when expensive operation is done.
    // We use "spinning wheels" and such to let the user know we're fetching something expensive.
  }
  
  /// Your ViewController(MVC) is still on screen, but it's about to go off screen.
  /// Maybe the user hit "back" in a UINavigationController?
  /// Or they switched to another tab in a UITabBarController?
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    // often you undo what you did in viewDidAppear
    // for example, stop a timer that you started there or stop observing something
  }
  
  /// Your ViewController(MVC) went off screen.
  /// Somewhat rare to do something here, but occasionally you might want to "clean up" your ViewController(MVC).
  /// For example, you could save some state or release some large, recreatable resource.
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    // clean up ViewController(MVC)
    
  }
  
  /// * Geometry
  /// You get notified when your top-level view's bounds change (or otherwise needs a re-layout).
  /// In other words, when it receives layoutSubviews, you get to find out (before and after).
  /// * Usually you don't need to do anything here because of Autolayout.
  /// But if you do have geometry-related setup to do, this is the place to do it (not in viewDidLoad)
  /// These can be called often (just as layoutSubviews() in UIView can be called often).
  /// Be prepared for that.
  /// Don't do anything here that can't be properly (and efficiently) done repeatedly.
  /// It doesn't always mean your view's bounds actually changed.
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
  }
  
  /// * AutoRotation
  /// When your device rotates, there's a lot going on.
  /// Of course your view's bounds change (and thus you'll get viewWill/DidLayoutSubviews).
  /// But the resultant changes are also automatically animated.
  /// You get to find out about that and even participate in the animation if you want ...
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    // You join in using coordinator's animate(alongsideTransition:) methods.
    
  }
  
  /// * Low Memory
  /// It's rare, but occasionally your device will run low on memory.
  /// This usually means a buildup of very large videos, images or maybe sounds.
  /// If your app keeps strong pointers to these things in your heap, you might be able to help!
  /// When a low-memory situation occurs, iOS will call this method in your Controller...
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // stop pointing to any large-memory things (i.e. let them go from my heap)
    // that I am not currently using (e.g. displaying on screen or processing somehow)
    // and that I can recreate as needed (by refetching from network, for example)
    
    // If your app persists in using an unfair amount of memory, you can get killed by iOS.
  }
  
  /// Waking up from an storyboard
  /// This method is sent to all objects that come out of a storyboard (including your Controller)
  override func awakeFromNib() {
    super.awakeFromNib()
    // can initialize stuff here, but it's VERY early
    // it happens way before outlets are set and before you're prepared as part of a segue.
    
    // This is pretty much a place of last resort.
    // Use other View Controller Lifecycle methods first if at all possible.
    // It's primarily for situations where code has to be executed VERY EARLY in the lifecycle.
  }
}

// Summary
// 1. Instantiated init (from storyboard or code)
// 2. awakeFromNib (only if instantiated from a storyboard)
// 3. segue preparation happens
// 4. outlets get set
// 5. viewDidLoad
// 6. These pairs will be called each time your Controller's view goes on/off screen
//  - viewWillAppear and viewDidAppear
//  - viewWillDisappear and viewDidDisappear
// 7. These "geometry changed" methods might be called at any time after viewDidLoad
//  - viewWillLayoutSubviews and viewDidLayoutSubviews
// 8. At any time, if memory gets low, you might get ...
//  - didReceiveMemoryWarning
