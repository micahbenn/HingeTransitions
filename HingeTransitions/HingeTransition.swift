//
//  HingeTransition.swift
//  HingeTransitions
//
//  Created by Micah Benn on 6/6/19.
//  Copyright © 2020 Micah Benn. All rights reserved.
//

import Foundation
import UIKit

class HingeTransition: NSObject, UIViewControllerAnimatedTransitioning {
    private let operation: UINavigationController.Operation

    init(operation: UINavigationController.Operation) {
        self.operation = operation
        super.init()
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.8
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let isPresenting = operation == .push

        guard let toView = transitionContext.view(forKey: .to) else { return }
        guard let fromView = transitionContext.view(forKey: .from) else { return }

        if (isPresenting) {
            transitionContext.containerView.addSubview(toView)
        } else {
            transitionContext.containerView.insertSubview(toView, belowSubview: fromView)
        }

        let presentedFrame = transitionContext.containerView.frame
        var dismissedFrame = presentedFrame
        dismissedFrame.origin.y = transitionContext.containerView.frame.height

        let startFrame = isPresenting ? dismissedFrame : presentedFrame
        let endFrame = isPresenting ? presentedFrame : dismissedFrame

        let transitioningView = isPresenting ? toView : fromView

        transitioningView.frame = startFrame
        UIView.animate(withDuration: transitionDuration(using: transitionContext),
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.7,
                       options: .curveEaseOut,
                       animations: {
                        transitioningView.frame = endFrame
        }) { _ in
            if (!isPresenting) {
                transitioningView.removeFromSuperview()
            }
            transitionContext.completeTransition(true)
        }
    }
}
