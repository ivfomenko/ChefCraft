//
//  CategoryRecipeListViewController.swift
//  ChefCraft
//
//  Created by Ivan Fomenko on 20.11.2019.
//  Copyright © 2019 Ivan Fomenko. All rights reserved.
//

import RxCocoa
import RxSwift
import AsyncDisplayKit
import Differentiator
import RxASDataSources

class CategoryRecipeListViewController: UIViewController, StoryboardInitializable {

    // MARK: - Outlets
    @IBOutlet weak var nodeContainer: UIView!
    
    internal var recipesNode: ASCollectionNode!

    // MARK: - Properties
    private var disposeBag = DisposeBag()

    var viewModel: CategoryRecipeListViewModel!
    
    private var recipeRangeSizeForCollection: ASSizeRange {
        let minSize = CGSize(width: self.nodeContainer.bounds.width, height: self.nodeContainer.bounds.width)
        let maxSize = CGSize(width: self.nodeContainer.bounds.width, height: .infinity)
        return ASSizeRangeMake(minSize, maxSize)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = .darkGreen
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.recipesNode.frame = self.nodeContainer.bounds
    }

    // MARK: - Setup
    private func setupUI() {
        self.configureASNode()
    }

    private func configureASNode() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 8

        self.recipesNode = ASCollectionNode(frame: .zero, collectionViewLayout: layout)
        
        recipesNode.isUserInteractionEnabled = true
        recipesNode.automaticallyRelayoutOnLayoutMarginsChanges = true
        recipesNode.backgroundColor = .clear
        recipesNode.showsVerticalScrollIndicator = false
        recipesNode.showsHorizontalScrollIndicator = false
        recipesNode.cellLayoutMode = .alwaysAsync
        recipesNode.delegate = self
        
        self.viewModel.recipiesDataSourcce
            .bind(to: self.recipesNode.rx.items(dataSource: self.recipesDataSource))
            .disposed(by: self.disposeBag)
        
        self.recipesNode.rx.modelSelected(RecipeModel.self)
            .debounce(.milliseconds(3), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] choosenModel in
                self?.viewModel.openReceipe(with: choosenModel)
            })
            .disposed(by: self.disposeBag)
        
        self.nodeContainer.addSubnode(self.recipesNode)
        self.view.layoutIfNeeded()
    }

}

// MARK: - ViewController: ASCollectionDelegate
extension CategoryRecipeListViewController: ASCollectionDelegate {
    
    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        return recipeRangeSizeForCollection
    }
    
    func shouldBatchFetch(for collectionNode: ASCollectionNode) -> Bool {
        return true
    }
}

// MARK: - RxASCollectionAnimatedDataSource
extension CategoryRecipeListViewController {
    
    var recipesDataSource: RxASCollectionAnimatedDataSource<RecipeSectionItem> {
        let animationConfiguration = RowAnimation(insertAnimation: .fade,
                                                  reloadAnimation: .fade,
                                                  deleteAnimation: .fade)
        let dataSource = RxASCollectionAnimatedDataSource<RecipeSectionItem>(
            animationConfiguration: animationConfiguration,
            configureCell: { _, _, _, model -> ASCellNode in
                let cell = RecipeItemNode(model: model)
                
                return cell
                
            }
        )
        
        return dataSource
    }
}
