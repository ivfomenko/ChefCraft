//
//  HomeBarView.swift
//  ChefCraft
//
//  Created by Ivan Fomenko on 16.11.2019.
//  Copyright © 2019 Ivan Fomenko. All rights reserved.
//

import UIKit

class HomeBarView: UIView {

    // MARK: - IBOutlet
    @IBOutlet var view: UIView!
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var notificationButton: UIButton!
    @IBOutlet var searchButton: UIButton!
    
    // MARK: - Clousers
    var didTapNofication: (() -> Void)?
    var didTapSearch: (() -> Void)?
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }
    
    init(width: CGFloat) {
        super.init(frame: .init(x: 0, y: 0, width: width, height: 64))
        nibSetup()
    }
    
    private func nibSetup() {
        backgroundColor = .clear
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        addSubview(view)
        
        self.setUpUI()
    }
    
    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return nibView
    }
    
    private func setUpUI() {
        self.titleLabel.text = "Looking for your favorite meal".localized
        self.notificationButton.addTarget(self, action: #selector(notificationAction), for: .touchUpInside)
        self.searchButton.addTarget(self, action: #selector(searchAction), for: .touchUpInside)
    }
    
    // MARK: - Selectors
    @objc
    func notificationAction() {
        self.didTapNofication?()
    }
    
    @objc
    func searchAction() {
        self.didTapSearch?()
    }
    
}
