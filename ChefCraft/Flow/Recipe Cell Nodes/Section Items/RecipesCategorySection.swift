//
//  HomeCollectionStruct.swift
//  ChefCraft
//
//  Created by Ivan Fomenko on 18.11.2019.
//  Copyright © 2019 Ivan Fomenko. All rights reserved.
//

import Foundation
import Differentiator
import RxASDataSources

// MARK: - RecipesCategorySection
struct RecipesCategorySection {
    var id: String
    var models: [RecipesCategory]
    
    init(id: String, models: [RecipesCategory]) {
        self.id = id
        self.models = models
    }

}

// MARK: - RecipesCategorySection: Equatable
extension RecipesCategorySection: Equatable {
    static func == (lhs: RecipesCategorySection, rhs: RecipesCategorySection) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - RecipesCategorySection: AnimatableSectionModelType, IdentifiableType
extension RecipesCategorySection: AnimatableSectionModelType, IdentifiableType {
    
    typealias Item = RecipesCategory
    
    var items: [RecipesCategory] {
        return models
    }
    
    var identity: String {
        return id
    }
    
    init(original: RecipesCategorySection, items: [Item]) {
        self = original
        self.models = items
    }
}
