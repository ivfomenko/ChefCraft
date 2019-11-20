//
//  RootRoute.swift
//  ChefCraft
//
//  Created by Ivan Fomenko on 12.11.2019.
//  Copyright © 2019 Ivan Fomenko. All rights reserved.
//

import Foundation

protocol RootRoute {
    var rootTransition: Transition { get }
    
    func showRoot()
}

extension RootRoute where Self: RouterProtocol {
    func showRoot() {
        let viewController = RootBuilder.build(injector: injector)
        open(viewController, transition: rootTransition)
    }
}
