//
//  SplashViewController.swift
//  ChefCraft
//
//  Created by Ivan Fomenko on 12.11.2019.
//  Copyright © 2019 Ivan Fomenko. All rights reserved.
//

import RxCocoa
import RxSwift

class SplashViewController: UIViewController, StoryboardInitializable {

    // MARK: - Outlets
    
    // MARK: - Properties
    private var disposeBag = DisposeBag()

    var viewModel: SplashViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true 
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.applyRootNavigation()
    }
    
    func applyRootNavigation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.viewModel.rootViewNavigation()
        }
    }
}
