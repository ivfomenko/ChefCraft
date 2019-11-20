//
//  CategoryRecipeListViewModel.swift
//  ChefCraft
//
//  Created by Ivan Fomenko on 20.11.2019.
//  Copyright © 2019 Ivan Fomenko. All rights reserved.
//

import RxSwift
import RxCocoa

class CategoryRecipeListViewModel {
    
    // MARK: - Router
    var router: CategoryRecipeListRouter
    var repository: CategoryRecipeListRepositoryProtocol
    
    // MARK - Data Sources
    var recipiesDataSourcce = BehaviorRelay<[RecipeSectionItem]>(value: [])
    
    // MARK: - Properties
    private var disposeBag = DisposeBag()

    init(router: CategoryRecipeListRouter, repository: CategoryRecipeListRepositoryProtocol) {
        self.router = router
        self.repository = repository
        
        self.binding()
    }
    
    private func binding() {
        self.repository.recipiesDataSourcce
            .bind(to: self.recipiesDataSourcce)
            .disposed(by: self.disposeBag)
    }
    
    func openReceipe(with model: RecipeModel) {
        self.router.showRecipeDetail(recipe: model)
    }

}
