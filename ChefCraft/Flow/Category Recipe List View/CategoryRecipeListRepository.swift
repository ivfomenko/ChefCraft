//
//  CategoryRecipeListRepository.swift
//  ChefCraft
//
//  Created by Ivan Fomenko on 20.11.2019.
//  Copyright © 2019 Ivan Fomenko. All rights reserved.
//

import RxCocoa
import RxSwift

// MARK: - CategoryRecipeListRepositoryProtocol
protocol CategoryRecipeListRepositoryProtocol {
    /// Observable List of Available  Recipes
    var recipiesDataSourcce: BehaviorRelay<[RecipeSectionItem]> { get set }
}

// MARK: - CategoryRecipeListRepository
class CategoryRecipeListRepository: CategoryRecipeListRepositoryProtocol {

    // MARK: - Properties
    private var disposeBag = DisposeBag()
    
    var recipiesDataSourcce: BehaviorRelay<[RecipeSectionItem]>
    
    var mokedDataStore = MokedStore()

    init() {
        self.recipiesDataSourcce = BehaviorRelay<[RecipeSectionItem]>(value: mokedDataStore.recipeSections)
    }
}

