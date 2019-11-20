//
//  RecipeDetailViewModel.swift
//  ChefCraft
//
//  Created by Ivan Fomenko on 19.11.2019.
//  Copyright © 2019 Ivan Fomenko. All rights reserved.
//

import RxSwift
import RxCocoa

class RecipeDetailViewModel {
    
    // MARK: - Router
    var router: RecipeDetailRouter
    var repository: RecipeDetailRepositoryProtocol
    
    // MARK: - Properties
    private var disposeBag = DisposeBag()
    
    var model: RecipeModel

    init(router: RecipeDetailRouter, repository: RecipeDetailRepositoryProtocol, data: RecipeModel) {
        self.router = router
        self.repository = repository
        self.model = data
    }

}
