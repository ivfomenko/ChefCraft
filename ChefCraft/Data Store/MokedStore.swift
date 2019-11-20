//
//  MokedStore.swift
//  ChefCraft
//
//  Created by Ivan Fomenko on 19.11.2019.
//  Copyright © 2019 Ivan Fomenko. All rights reserved.
//

import Foundation

// MARK: - Moked Store
struct MokedStore {
    var recipeSections: [RecipeSectionItem] {
        let items = [
            RecipeModel(id: String.objectId(), imageKey: "egg", title: "Cheese Grill Sandwic".localized, authorName: "Sarah Smith"),
            RecipeModel(id: String.objectId(), imageKey: "fish", title: "Fish Curryc".localized, authorName: "Sarah Smith"),
            RecipeModel(id: String.objectId(), imageKey: "egg", title: "Cheese Grill Sandwic".localized, authorName: "Sarah Smith"),
            RecipeModel(id: String.objectId(), imageKey: "fish", title: "Fish Curry".localized, authorName: "Sarah Smith"),
            RecipeModel(id: String.objectId(), imageKey: "egg", title: "Cheese Grill Sandwic".localized, authorName: "Sarah Smith"),
            RecipeModel(id: String.objectId(), imageKey: "fish", title: "Fish Curry".localized, authorName: "Sarah Smith"),
            RecipeModel(id: String.objectId(), imageKey: "egg", title: "Cheese Grill Sandwic".localized, authorName: "Sarah Smith"),
            RecipeModel(id: String.objectId(), imageKey: "fish", title: "Fish Curry".localized, authorName: "Sarah Smith"),
            RecipeModel(id: String.objectId(), imageKey: "egg", title: "Cheese Grill Sandwic".localized, authorName: "Sarah Smith"),
            RecipeModel(id: String.objectId(), imageKey: "fish", title: "Fish Curry".localized, authorName: "Sarah Smith"),
            RecipeModel(id: String.objectId(), imageKey: "egg", title: "Cheese Grill Sandwic".localized, authorName: "Sarah Smith")
        ]
        let section = RecipeSectionItem(id: "recipeSection", models: items)
        return [section]
    }
    
    var categorySections: [RecipesCategorySection] {
        let items = [
            RecipesCategory(key: "cat_1", title: "Soup Recipies".localized, imageKey: "cat_1"),
            RecipesCategory(key: "cat_2", title: "Main Course Special".localized, imageKey: "cat_2"),
            RecipesCategory(key: "cat_3", title: "Grill Chesse Burgur".localized, imageKey: "cat_3")
        ]
        
        let section = RecipesCategorySection(id: "categorySection", models: items)
        return [section]
    }
}
