//
//  RecipeDetailRoute.swift
//  ChefCraft
//
//  Created by Ivan Fomenko on 19.11.2019.
//  Copyright © 2019 Ivan Fomenko. All rights reserved.
//

import Foundation

protocol RecipeDetailRoute {
    var RecipeDetailTransition: Transition { get }
    
    func showRecipeDetail(recipe: RecipeModel)
}

extension RecipeDetailRoute where Self: RouterProtocol {
    func showRecipeDetail(recipe: RecipeModel) {
        let viewController = RecipeDetailBuilder.build(injector: injector, recipe: recipe)
        open(viewController, transition: RecipeDetailTransition)
    }
}
