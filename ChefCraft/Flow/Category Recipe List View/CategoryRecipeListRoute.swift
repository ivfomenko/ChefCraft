//
//  CategoryRecipeListRoute.swift
//  ChefCraft
//
//  Created by Ivan Fomenko on 20.11.2019.
//  Copyright © 2019 Ivan Fomenko. All rights reserved.
//

import Foundation

protocol CategoryRecipeListRoute {
    var CategoryRecipeListTransition: Transition { get }
    
    func showCategoryRecipeList()
}

extension CategoryRecipeListRoute where Self: RouterProtocol {
    func showCategoryRecipeList() {
        let viewController = CategoryRecipeListBuilder.build(injector: injector)
        open(viewController, transition: CategoryRecipeListTransition)
    }
}
