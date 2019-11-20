//
//  SplashBuilder.swift
//  ChefCraft
//
//  Created by Ivan Fomenko on 12.11.2019.
//  Copyright © 2019 Ivan Fomenko. All rights reserved.
//

import Foundation
import UIKit
import Swinject

class SplashBuilder {
    static func build(injector: Container) -> SplashViewController {
        
        let viewController = SplashViewController.initFromStoryboard(name: injector.resolve(AppStoryboards.self)!.splash)

        let router = SplashRouter(injector: injector)
        router.viewController = viewController
        
        let repository = SplashRepository()
        
        let viewModel = SplashViewModel(router: router, repository: repository)
        
        viewController.viewModel = viewModel
        
        return viewController
    }
}
