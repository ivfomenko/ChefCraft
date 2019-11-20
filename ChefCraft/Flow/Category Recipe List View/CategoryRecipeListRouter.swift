//
//  CategoryRecipeListRouter.swift
//  ChefCraft
//
//  Created by Ivan Fomenko on 20.11.2019.
//  Copyright © 2019 Ivan Fomenko. All rights reserved.
//

import Foundation

class CategoryRecipeListRouter: Router<CategoryRecipeListViewController>, CategoryRecipeListRouter.Routes {
    
    typealias Routes = RecipeDetailRoute
    
    var RecipeDetailTransition: Transition {
        return PushTransition()
    }
    
}
