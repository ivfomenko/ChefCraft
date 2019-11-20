//
//  ClosablePushTransition.swift
//  ChefCraft
//
//  Created by Ivan Fomenko on 12.11.2019.
//  Copyright © 2019 Ivan Fomenko. All rights reserved.
//

import UIKit

class ClosablePushTransition: NSObject {

    var animator: AnimatorProtocol?
    var isAnimated: Bool = true
    var completionHandler: (() -> Void)?

    weak var viewController: UIViewController?
    weak var closeTargetViewController: UIViewController?

    init(closeTargetViewController: UIViewController?, animator: AnimatorProtocol? = nil, isAnimated: Bool = true) {
        self.closeTargetViewController = closeTargetViewController
        self.animator = animator
        self.isAnimated = isAnimated
    }
}

// MARK: - Transition

extension ClosablePushTransition: Transition {

    func open(_ viewController: UIViewController) {
        self.viewController?.navigationController?.delegate = self
        self.viewController?.navigationController?.pushViewController(viewController, animated: isAnimated)
    }

    func close(_ viewController: UIViewController) {
        guard let target = closeTargetViewController else {
            viewController.navigationController?.popViewController(animated: true)
            return
        }
        viewController.navigationController?.popToViewController(target, animated: true)
    }
}

// MARK: - UINavigationControllerDelegate

extension ClosablePushTransition: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        completionHandler?()
    }

    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let animator = animator else {
            return nil
        }
        if operation == .push {
            animator.isPresenting = true
            return animator
        } else {
            animator.isPresenting = false
            return animator
        }
    }
}
