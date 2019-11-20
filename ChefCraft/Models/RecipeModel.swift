//
//  RecipeModel.swift
//  ChefCraft
//
//  Created by Ivan Fomenko on 18.11.2019.
//  Copyright © 2019 Ivan Fomenko. All rights reserved.
//

import Foundation
import Differentiator

// MARK: - RecipeModel
struct RecipeModel {
    var id: String
    var imageKey: String
    var title: String
    var authorName: String 
}

// MARK: - RecipesCategory: IdentifiableType
extension RecipeModel: IdentifiableType {

    typealias Identity = String
    
    var identity: String {
        return id
    }

}

// MARK: - RecipeModel: Equatable
extension RecipeModel: Equatable {
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == lhs.id
    }
}
