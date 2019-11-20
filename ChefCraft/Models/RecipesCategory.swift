//
//  RecipesCategory.swift
//  ChefCraft
//
//  Created by Ivan Fomenko on 18.11.2019.
//  Copyright © 2019 Ivan Fomenko. All rights reserved.
//

import Foundation
import Differentiator

// MARK: - RecipesCategory
struct RecipesCategory {
    var key: String
    var title: String
    var imageKey: String
}

// MARK: - RecipesCategory: IdentifiableType
extension RecipesCategory: IdentifiableType {

    typealias Identity = String
    
    var identity: String {
        return key
    }

}

// MARK: - RecipesCategory: Equatable
extension RecipesCategory: Equatable {
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.key == lhs.key
    }
}
