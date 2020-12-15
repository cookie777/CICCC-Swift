//
//  NVAnimationController.swift
//  Assignment4
//
//  Created by Takayuki Yamaguchi on 2020-12-14.
//  Copyright © 2020 Derrick Park. All rights reserved.
//

import UIKit

class AnimationController: UIViewController, UIViewControllerAnimatedTransitioning{

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.5
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {


    let toView = transitionContext.view(forKey: .to)!
    
    transitionContext.containerView.addSubview(toView)
    
    toView.alpha = 0.0
    toView.transform = CGAffineTransform(translationX: 200, y: 0)
    
    UIView.animate(
      withDuration: transitionDuration(using: transitionContext),
      animations: {
        
        toView.alpha = 1.0
        toView.transform = CGAffineTransform(translationX: 0, y: 0)
      },
      completion: { _ in
        transitionContext.completeTransition(true)
      }
    )
  }

}
