//
//  SplashViewModel.swift
//  ChefCraft
//
//  Created by Ivan Fomenko on 12.11.2019.
//  Copyright © 2019 Ivan Fomenko. All rights reserved.
//

import RxSwift
import RxCocoa

class SplashViewModel {
    
    // MARK: - Router
    var router: SplashRouter
    var repository: SplashRepositoryProtocol
    
    // MARK: - Properties
    private var disposeBag = DisposeBag()

    init(router: SplashRouter, repository: SplashRepositoryProtocol) {
        self.router = router
        self.repository = repository
    }
    
    func rootViewNavigation() {
        self.router.showRoot()
    }

}
