//
//  SplashRoute.swift
//  ChefCraft
//
//  Created by Ivan Fomenko on 12.11.2019.
//  Copyright © 2019 Ivan Fomenko. All rights reserved.
//

import Foundation

protocol SplashRoute {
    var SplashTransition: Transition { get }
    
    func showSplash()
}

extension SplashRoute where Self: RouterProtocol {
    func showSplash() {
        let viewController = SplashBuilder.build(injector: injector)
        open(viewController, transition: SplashTransition)
    }
}
