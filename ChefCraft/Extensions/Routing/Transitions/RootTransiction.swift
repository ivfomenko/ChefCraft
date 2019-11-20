//
//  RootTransition.swift
//  ChefCraft
//
//  Created by Ivan Fomenko on 12.11.2019.
//  Copyright © 2019 Ivan Fomenko. All rights reserved.
//
import UIKit

class RootTransition: NSObject {
    
    var animator: AnimatorProtocol?
    var isAnimated: Bool = true
    
    var modalTransitionStyle: UIModalTransitionStyle
    var modalPresentationStyle: UIModalPresentationStyle
    
    weak var viewController: UIViewController?
    
    init(animator: AnimatorProtocol? = nil,
         isAnimated: Bool = true,
         modalTransitionStyle: UIModalTransitionStyle = .coverVertical,
         modalPresentationStyle: UIModalPresentationStyle = .fullScreen) {
        self.animator = animator
        self.isAnimated = isAnimated
        self.modalTransitionStyle = modalTransitionStyle
        self.modalPresentationStyle = modalPresentationStyle
    }
}

// MARK: - Transition

extension RootTransition: Transition {
    
    func open(_ viewController: UIViewController) {
        viewController.transitioningDelegate = self
        viewController.modalTransitionStyle = modalTransitionStyle
        viewController.modalPresentationStyle = modalPresentationStyle
        
        if isAnimated {
            UIView.transition(with: UIApplication.shared.windows.first!, duration: 0.5, options: .transitionCrossDissolve, animations: {
                let oldState: Bool = UIView.areAnimationsEnabled
                UIView.setAnimationsEnabled(false)
                UIApplication.shared.windows.first?.rootViewController = viewController
                UIApplication.shared.windows.first?.rootViewController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                UIView.setAnimationsEnabled(oldState)
            }, completion: nil)
        } else {
            UIApplication.shared.windows.first?.rootViewController = viewController
            UIApplication.shared.windows.first?.rootViewController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
    }
    
    func close(_ viewController: UIViewController) {
        //        viewController.dismiss(animated: isAnimated, completion: completionHandler)
    }
}

// MARK: - UIViewControllerTransitioningDelegate

extension RootTransition: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let animator = animator else {
            return nil
        }
        animator.isPresenting = true
        return animator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let animator = animator else {
            return nil
        }
        animator.isPresenting = false
        return animator
    }
}
