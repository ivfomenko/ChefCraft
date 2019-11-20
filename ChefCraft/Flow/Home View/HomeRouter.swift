//
//  HomeRouter.swift
//  ChefCraft
//
//  Created by Ivan Fomenko on 12.11.2019.
//  Copyright © 2019 Ivan Fomenko. All rights reserved.
//

import Foundation

class HomeRouter: Router<HomeViewController>, HomeRouter.Routes {
    typealias Routes = RecipeDetailRoute & CategoryRecipeListRoute
    
    var RecipeDetailTransition: Transition {
        return PushTransition()
    }
    
    var CategoryRecipeListTransition: Transition {
        return PushTransition()
    }
    
}
