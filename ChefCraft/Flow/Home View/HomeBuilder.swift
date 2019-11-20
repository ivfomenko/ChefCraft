//
//  HomeBuilder.swift
//  ChefCraft
//
//  Created by Ivan Fomenko on 12.11.2019.
//  Copyright © 2019 Ivan Fomenko. All rights reserved.
//

import Foundation
import UIKit
import Swinject

class HomeBuilder {
    static func build(injector: Container) -> HomeViewController {
        let viewController = HomeViewController.initFromStoryboard(name: injector.resolve(AppStoryboards.self)!.home)

        let router = HomeRouter(injector: injector)
        router.viewController = viewController
        
        let repository = HomeRepository()
        
        let viewModel = HomeViewModel(router: router, repository: repository)
        
        viewController.viewModel = viewModel
        viewController.setCustomBackButton()
        return viewController
    }
}
