//
//  RecipeSectionItem.swift
//  ChefCraft
//
//  Created by Ivan Fomenko on 18.11.2019.
//  Copyright © 2019 Ivan Fomenko. All rights reserved.
//

import Foundation
import Differentiator
import RxASDataSources

// MARK: - RecipesCategorySection
struct RecipeSectionItem {
    
    var id: String
    var models: [RecipeModel]
    
    init(id: String, models: [RecipeModel]) {
        self.id = id
        self.models = models
    }

}

// MARK: - RecipesCategorySection: Equatable
extension RecipeSectionItem: Equatable {
    static func == (lhs: RecipeSectionItem, rhs: RecipeSectionItem) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - RecipesCategorySection: AnimatableSectionModelType, IdentifiableType
extension RecipeSectionItem: AnimatableSectionModelType, IdentifiableType {
    
    typealias Item = RecipeModel
    
    var items: [RecipeModel] {
        return models
    }
    
    var identity: String {
        return id
    }
    
    init(original: RecipeSectionItem, items: [Item]) {
        self = original
        self.models = items
    }
}
