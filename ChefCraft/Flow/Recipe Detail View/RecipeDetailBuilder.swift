//
//  RecipeDetailBuilder.swift
//  ChefCraft
//
//  Created by Ivan Fomenko on 19.11.2019.
//  Copyright © 2019 Ivan Fomenko. All rights reserved.
//

import Foundation
import UIKit
import Swinject

class RecipeDetailBuilder {
    static func build(injector: Container, recipe: RecipeModel) -> RecipeDetailViewController {
        let viewController = RecipeDetailViewController.initFromStoryboard(name: injector.resolve(AppStoryboards.self)!.recipeDetail)

        let router = RecipeDetailRouter(injector: injector)
        router.viewController = viewController
        
        let repository = RecipeDetailRepository()
        
        let viewModel = RecipeDetailViewModel(router: router, repository: repository, data: recipe)
        
        viewController.viewModel = viewModel
        viewController.hidesBottomBarWhenPushed = true
        viewController.setCustomBackButton()
        return viewController
    }
}
