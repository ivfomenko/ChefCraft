//
//  SplashRouter.swift
//  ChefCraft
//
//  Created by Ivan Fomenko on 12.11.2019.
//  Copyright © 2019 Ivan Fomenko. All rights reserved.
//

import Foundation

class SplashRouter: Router<SplashViewController>, SplashRouter.Routes {
    typealias Routes = RootRoute
    
    var rootTransition: Transition {
        return RootTransition()
    }
}
