//
//  RootViewModel.swift
//  ChefCraft
//
//  Created by Ivan Fomenko on 12.11.2019.
//  Copyright © 2019 Ivan Fomenko. All rights reserved.
//

import RxSwift
import RxCocoa

class RootViewModel {
    
    // MARK: - Router
    var router: RootRouter
    var repository: RootRepositoryProtocol
    
    // MARK: - Properties
    private var disposeBag = DisposeBag()

    init(router: RootRouter, repository: RootRepositoryProtocol) {
        self.router = router
        self.repository = repository
    }

}
