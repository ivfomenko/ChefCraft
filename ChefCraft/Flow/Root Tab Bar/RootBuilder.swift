//
//  RootBuilder.swift
//  ChefCraft
//
//  Created by Ivan Fomenko on 12.11.2019.
//  Copyright © 2019 Ivan Fomenko. All rights reserved.
//

import Foundation
import UIKit
import Swinject

class RootBuilder {
    
    static func build(injector: Container) -> UITabBarController {
        
        /* RootViewController init */
        let tabBarController = RootViewController.initFromStoryboard(name: injector.resolve(AppStoryboards.self)!.root)
        
        tabBarController.tabBar.tintColor = .darkGreen
//         tabBarController.tabBar.unselectedItemTintColor = .purply
        let router = RootRouter(injector: injector)
        router.viewController = tabBarController
        
        let repository = RootRepository()
        
        let viewModel = RootViewModel(router: router, repository: repository)
        
        tabBarController.viewModel = viewModel
        
        /* Contained View Controllers Init */
        let homeViewController = UINavigationController(rootViewController: HomeBuilder.build(injector: injector))
        
        homeViewController.tabBarItem = UITabBarItem(title: "Home".localized, image: UIImage(named: "home"), tag: 0)
        tabBarController.setViewControllers([homeViewController], animated: false)
        
        return tabBarController
    }
}
