//
//  HomeViewController.swift
//  ChefCraft
//
//  Created by Ivan Fomenko on 12.11.2019.
//  Copyright © 2019 Ivan Fomenko. All rights reserved.
//

import RxCocoa
import RxSwift
import AsyncDisplayKit
import Differentiator
import RxASDataSources

class HomeViewController: UIViewController, StoryboardInitializable {

    // MARK: - Outlets
    @IBOutlet weak var barView: HomeBarView!
    @IBOutlet weak var recipesCategoryContainer: UIView!
    @IBOutlet weak var recipesListContainer: UIView!
    
    // MARK: - Nodes
    internal var recipesCategoryNode: ASCollectionNode!
    internal var recipesNode: ASCollectionNode!

    // MARK: - Properties
    private var disposeBag = DisposeBag()

    var viewModel: HomeViewModel!
    
    private var recipeRangeSizeForCollection: ASSizeRange {
        let minSize = CGSize(width: self.recipesListContainer.bounds.width * 0.9, height: self.recipesListContainer.frame.height)
        let maxSize = CGSize(width: .infinity, height: self.recipesListContainer.frame.height)
        return ASSizeRangeMake(minSize, maxSize)
    }
    
    private var recipesCategoryRangeSizeForCollection: ASSizeRange {
        let minSize = CGSize(width: self.recipesCategoryContainer.bounds.width * 0.4, height: self.recipesCategoryContainer.frame.height)
        let maxSize = CGSize(width: .infinity, height: self.recipesCategoryContainer.frame.height)
        return ASSizeRangeMake(minSize, maxSize)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBinding()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.recipesCategoryNode.frame = self.recipesCategoryContainer.bounds
        self.recipesNode.frame = self.recipesListContainer.bounds
    }

    // MARK: - Setup
    private func setupUI() {
        self.configureNavBar()
        self.configureASNodes()
    }

    private func setupBinding() {
        self.viewModel.errorSignaler
            .subscribe(onNext: { [weak self] viewError in
                // handle error for view with custom alerts
            })
            .disposed(by: self.disposeBag)
    }
    
    // MARK: - Configures
    private func configureNavBar() {
        self.navigationController?.isNavigationBarHidden = true
        
        barView.didTapNofication = { [weak self] in
            debugPrint("Notifaction action")
        }
        
        barView.didTapSearch = { [weak self] in
            debugPrint("Search action")
        }
    }
    
    private func configureASNodes() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let recipesCategoryNodeLayout = UICollectionViewFlowLayout()
        recipesCategoryNodeLayout.scrollDirection = .vertical
        recipesCategoryNodeLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        recipesCategoryNodeLayout.minimumLineSpacing = 0
        recipesCategoryNodeLayout.minimumInteritemSpacing = 0
        recipesCategoryNodeLayout.scrollDirection = .horizontal
        
        self.recipesNode = ASCollectionNode(frame: .zero, collectionViewLayout: layout)
        self.recipesCategoryNode = ASCollectionNode(frame: .zero, collectionViewLayout: recipesCategoryNodeLayout)
        
        recipesNode.isUserInteractionEnabled = true
        recipesNode.automaticallyRelayoutOnLayoutMarginsChanges = true
        recipesNode.backgroundColor = .clear
        recipesNode.showsVerticalScrollIndicator = false
        recipesNode.showsHorizontalScrollIndicator = false
        recipesNode.cellLayoutMode = .alwaysAsync
        recipesNode.delegate = self
        
        recipesCategoryNode.isUserInteractionEnabled = true
        recipesCategoryNode.automaticallyRelayoutOnLayoutMarginsChanges = true
        recipesCategoryNode.backgroundColor = .clear
        recipesCategoryNode.showsVerticalScrollIndicator = false
        recipesCategoryNode.showsHorizontalScrollIndicator = false
        recipesCategoryNode.cellLayoutMode = .alwaysAsync
        recipesCategoryNode.delegate = self
        
        self.viewModel.recipiesDataSourcce
            .bind(to: self.recipesNode.rx.items(dataSource: self.recipesDataSource))
            .disposed(by: self.disposeBag)
        
        self.viewModel.recepiesCategyDataSource
            .bind(to: self.recipesCategoryNode.rx.items(dataSource: self.recipesCategoriesDataSource))
            .disposed(by: self.disposeBag)
        
        self.recipesNode.rx.modelSelected(RecipeModel.self)
            .debounce(.milliseconds(3), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] choosenModel in
                self?.viewModel.openReceipe(with: choosenModel)
            })
            .disposed(by: self.disposeBag)
        
        self.recipesCategoryNode.rx.modelSelected(RecipesCategory.self)
            .debounce(.milliseconds(3), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] choosenCategory in
                self?.viewModel.openReceipeList(for: choosenCategory)
            })
            .disposed(by: self.disposeBag)
        
        self.recipesListContainer.addSubnode(self.recipesNode)
        self.recipesCategoryContainer.addSubnode(self.recipesCategoryNode)
        self.view.layoutIfNeeded()
    }
    
    private func configureASNodeView(for node: ASCollectionNode) {

    }
    
    // MARK: - Selectors
    @objc
    func ringAction() {}
    
    @objc
    func searchAction() {}

}

// MARK: - ViewController: ASCollectionDelegate
extension HomeViewController: ASCollectionDelegate {
    
    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        if collectionNode == self.recipesCategoryNode {
            return self.recipesCategoryRangeSizeForCollection
        } else {
            return recipeRangeSizeForCollection
        }
    }
    
    func shouldBatchFetch(for collectionNode: ASCollectionNode) -> Bool {
        return true
    }
}

// MARK: - RxASCollectionAnimatedDataSource
extension HomeViewController {
    
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
    
    var recipesCategoriesDataSource: RxASCollectionAnimatedDataSource<RecipesCategorySection> {
        let animationConfiguration = RowAnimation(insertAnimation: .fade,
                                                  reloadAnimation: .fade,
                                                  deleteAnimation: .fade)
        let dataSource = RxASCollectionAnimatedDataSource<RecipesCategorySection>(
            animationConfiguration: animationConfiguration,
            configureCell: { _, _, _, model -> ASCellNode in
                let cell = CategoryItemNode(model: model)
                
                return cell
            }
        )
        
        return dataSource
        
    }
}
