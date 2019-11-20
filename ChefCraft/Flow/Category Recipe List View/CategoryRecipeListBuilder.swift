//
//  CategoryRecipeListBuilder.swift
//  ChefCraft
//
//  Created by Ivan Fomenko on 20.11.2019.
//  Copyright © 2019 Ivan Fomenko. All rights reserved.
//

import Foundation
import UIKit
import Swinject

class CategoryRecipeListBuilder {
    static func build(injector: Container) -> CategoryRecipeListViewController {
        let viewController = CategoryRecipeListViewController.initFromStoryboard(name: injector.resolve(AppStoryboards.self)!.categoryRecipeList)

        let router = CategoryRecipeListRouter(injector: injector)
        router.viewController = viewController
        
        let repository = CategoryRecipeListRepository()
        
        let viewModel = CategoryRecipeListViewModel(router: router, repository: repository)
        
        viewController.viewModel = viewModel
        viewController.hidesBottomBarWhenPushed = true
        viewController.setCustomBackButton()
        return viewController
    }
}
