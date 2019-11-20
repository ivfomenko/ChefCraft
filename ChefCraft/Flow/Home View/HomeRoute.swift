//
//  HomeRoute.swift
//  ChefCraft
//
//  Created by Ivan Fomenko on 12.11.2019.
//  Copyright © 2019 Ivan Fomenko. All rights reserved.
//

import Foundation

protocol HomeRoute {
    var HomeTransition: Transition { get }
    
    func showHome()
}

extension HomeRoute where Self: RouterProtocol {
    func showHome() {
        let viewController = HomeBuilder.build(injector: injector)
        open(viewController, transition: HomeTransition)
    }
}
