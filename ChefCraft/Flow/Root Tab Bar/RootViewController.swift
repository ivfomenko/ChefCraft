//
//  RootViewController.swift
//  ChefCraft
//
//  Created by Ivan Fomenko on 12.11.2019.
//  Copyright © 2019 Ivan Fomenko. All rights reserved.
//

import RxCocoa
import RxSwift

class RootViewController: UITabBarController, StoryboardInitializable {

    // MARK: - Outlets

    // MARK: - Properties
    private var disposeBag = DisposeBag()

    var viewModel: RootViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupBinding()
    }

    // MARK: - Setup
    private func setupUI() {

    }

    private func setupBinding() {

    }

}
