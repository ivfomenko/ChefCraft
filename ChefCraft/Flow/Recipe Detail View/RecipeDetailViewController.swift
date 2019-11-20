//
//  RecipeDetailViewController.swift
//  ChefCraft
//
//  Created by Ivan Fomenko on 19.11.2019.
//  Copyright © 2019 Ivan Fomenko. All rights reserved.
//

import RxCocoa
import RxSwift

class RecipeDetailViewController: UIViewController, StoryboardInitializable {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    weak var headerImageView: UIImageView?

    // MARK: - Properties
    private var disposeBag = DisposeBag()
    
    private let mokedCellHeight: CGFloat = 900.0

    var viewModel: RecipeDetailViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }

    // MARK: - Setup
    private func setupUI() {
        self.setUpTableView()
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    private func setUpTableView() {
        let imageView = UIImageView()
        imageView.image = UIImage(named: self.viewModel.model.imageKey)
        imageView.contentMode = .scaleAspectFill

        headerImageView = imageView
        
        tableView.parallaxHeader.view = imageView
        tableView.parallaxHeader.height = 325
        tableView.parallaxHeader.minimumHeight = 0
        tableView.parallaxHeader.mode = .centerFill
        
        tableView.parallaxHeader.parallaxHeaderDidScrollHandler = { [weak self] parallaxHeader in
            guard let self = self else { return }
            imageView.alpha = 0 + parallaxHeader.progress
            if parallaxHeader.progress < 0.5 {
                UIView.transition(with: self.view, duration: 0.3, options: .curveEaseInOut, animations: {
                    self.navigationController?.navigationBar.tintColor = .darkGreen
                })
                
            } else {
                UIView.transition(with: self.view, duration: 0.3, options: .curveEaseInOut, animations: {
                    self.navigationController?.navigationBar.tintColor = .white
                })
                
            }
        }
        
        self.tableView.register(RecipeDetailCell.nib, forCellReuseIdentifier: RecipeDetailCell.identifier)
        self.tableView.backgroundColor = .clear
        self.tableView.separatorStyle = .none
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

}

// MARK: - RecipeDetailViewController: UITableViewDelegate, UITableViewDataSource
extension RecipeDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.mokedCellHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecipeDetailCell.identifier) as! RecipeDetailCell
        cell.selectionStyle = .none
        return cell
    }
}
