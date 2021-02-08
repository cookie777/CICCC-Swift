//
//  PopAnimator.swift
//  MyCollections
//
//  Created by Takayuki Yamaguchi on 2021-02-07.
//

import UIKit

class PopAnimator: NSObject,UIViewControllerAnimatedTransitioning {
    
    
    
    let duration = 0.2
    var presenting = true
    
    static let shared = PopAnimator()
    private override init() {}
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        // view that treats animation
        let containerView = transitionContext.containerView
        
        /*
            The new view finally becomes.
            As for presentation:
                preset:   nil  ------> .to
                dismiss:  .from <------ nil
         */
        let newView = presenting ?
            transitionContext.view(forKey: .to)! :
            transitionContext.view(forKey: .from)!
        containerView.addSubview(newView)
        containerView.backgroundColor = UIColor.black.withAlphaComponent(0)
        
        
        /*
                preset:   nil   ------> .to
                    scale 0.5             1.0
                    alpha 0.0             0.8
         
                dismiss:  .from <------ nil
                    scale 1.0             0.5
                    alpha 0.8             0.0
         */
        newView.transform = presenting ? CGAffineTransform(scaleX: 0.5, y: 0.5) : CGAffineTransform(scaleX: 1.0, y: 1.0)
        newView.alpha = presenting ? 0.0 : 1.0
        containerView.backgroundColor =  presenting ?
            UIColor.black.withAlphaComponent(0.0) :
            UIColor.black.withAlphaComponent(0.8)
        
        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: .curveEaseOut,
            animations: { [weak self] in
                guard let self = self else {return}
                newView.transform = self.presenting ?
                    CGAffineTransform(scaleX: 1.0, y: 1.0) :
                    CGAffineTransform(scaleX: 0.5, y: 0.5)
                newView.alpha = self.presenting ? 1.0 : 0.0
                containerView.backgroundColor =  self.presenting ? UIColor.black.withAlphaComponent(0.8) :
                    UIColor.black.withAlphaComponent(0.0)
            },
            completion: { _ in
                transitionContext.completeTransition(true)
            }
        )
        
    }
    
    
}
