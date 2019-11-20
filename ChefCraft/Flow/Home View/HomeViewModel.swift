//
//  HomeViewModel.swift
//  ChefCraft
//
//  Created by Ivan Fomenko on 12.11.2019.
//  Copyright © 2019 Ivan Fomenko. All rights reserved.
//

import RxSwift
import RxCocoa

class HomeViewModel {
    
    // MARK: - Router
    var router: HomeRouter
    var repository: HomeRepositoryProtocol
    
    // MARK: - Data Sources
    var recepiesCategyDataSource = BehaviorRelay<[RecipesCategorySection]>(value: [])
    var recipiesDataSourcce = BehaviorRelay<[RecipeSectionItem]>(value: [])
    
    // MARK: - Observers
    var errorSignaler = PublishSubject<HomeViewError>()
    
    // MARK: - Properties
    private var disposeBag = DisposeBag()

    init(router: HomeRouter, repository: HomeRepositoryProtocol) {
        self.router = router
        self.repository = repository
        
        self.binding()
    }
    
    private func binding() {
        self.repository.recepiesCategyDataSource
            .bind(to: self.recepiesCategyDataSource)
            .disposed(by: self.disposeBag)
        
        self.repository.recipiesDataSourcce
            .bind(to: self.recipiesDataSourcce)
            .disposed(by: self.disposeBag)
    }
    
    // MARK: - Navigation
    func openReceipe(with model: RecipeModel) {
        self.router.showRecipeDetail(recipe: model)
    }
    
    func openReceipeList(for category: RecipesCategory) {
        // TODO: - Add DB & Logic for categories recipes
        self.router.showCategoryRecipeList()
    }

}
