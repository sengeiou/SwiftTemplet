//
//  SlideAnimatedTransitioning.swift
//  SwipeRightToPopController
//
//  Created by Warif Akhand Rishi on 2/19/16.
//  Copyright © 2016 Warif Akhand Rishi. All rights reserved.
//

import UIKit

class SlideAnimatedTransitioning: NSObject {

}

extension SlideAnimatedTransitioning: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
        let toVC = transitionContext.viewController(forKey: .to),
        let fromView = transitionContext.view(forKey: .from) ?? fromVC.view,
        let toView = transitionContext.view(forKey: .to) ?? toVC.view
        else { return }
        
        let containerView = transitionContext.containerView
        containerView.insertSubview(toView, belowSubview: fromView)

        let width = containerView.frame.width
        
        var offsetLeft = fromView.frame
        offsetLeft.origin.x = width
        
        var offscreenRight = toView.frame
        offscreenRight.origin.x = -width / 3.33;
        
        toView.frame = offscreenRight;
        
        fromView.layer.shadowRadius = 5.0
        fromView.layer.shadowOpacity = 1.0
        toView.layer.opacity = 0.9
        
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay:0, options:.curveLinear, animations:{
            
            toView.frame = fromView.frame
            fromView.frame = offsetLeft
            
            toView.layer.opacity = 1.0
            fromView.layer.shadowOpacity = 0.1
            
            }, completion: { finished in
                toView.layer.opacity = 1.0
                toView.layer.shadowOpacity = 0
                fromView.layer.opacity = 1.0
                fromView.layer.shadowOpacity = 0
                
                // when cancelling or completing the animation, ios simulator seems to sometimes flash black backgrounds during the animation. on devices, this doesn't seem to happen though.
                // containerView.backgroundColor = [UIColor whiteColor];
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
