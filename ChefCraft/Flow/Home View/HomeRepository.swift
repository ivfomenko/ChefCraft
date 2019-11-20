//
//  HomeRepository.swift
//  ChefCraft
//
//  Created by Ivan Fomenko on 12.11.2019.
//  Copyright © 2019 Ivan Fomenko. All rights reserved.
//

import RxCocoa
import RxSwift

// MARK: - HomeRepositoryProtocol
protocol HomeRepositoryProtocol {
    
    /// Observable List of Recepies Categories
    var recepiesCategyDataSource: BehaviorRelay<[RecipesCategorySection]> { get set }
    
    /// Observable List of Available  Recipes
    var recipiesDataSourcce: BehaviorRelay<[RecipeSectionItem]> { get set }
    
    func getRecipes(for category: RecipesCategory) -> Single<[RecipeModel]>
}

// MARK: - HomeRepository
class HomeRepository: HomeRepositoryProtocol {

    // MARK: - Properties
    private var disposeBag = DisposeBag()
    
    var recipiesDataSourcce: BehaviorRelay<[RecipeSectionItem]>
    var recepiesCategyDataSource: BehaviorRelay<[RecipesCategorySection]>
    
    var mokedDataStore = MokedStore()

    init() {
        self.recipiesDataSourcce = BehaviorRelay<[RecipeSectionItem]>(value: mokedDataStore.recipeSections)
        self.recepiesCategyDataSource = BehaviorRelay<[RecipesCategorySection]>(value: mokedDataStore.categorySections)
    }

}

// MARK: - HomeRepository: HomeRepositoryProtocol
extension HomeRepository {
    
    func getRecipes(for category: RecipesCategory) -> Single<[RecipeModel]> {
        return Single.just([])
    }
}
