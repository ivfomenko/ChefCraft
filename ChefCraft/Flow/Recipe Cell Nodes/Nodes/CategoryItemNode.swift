//
//  CategoryItemNode.swift
//  ChefCraft
//
//  Created by Ivan Fomenko on 18.11.2019.
//  Copyright © 2019 Ivan Fomenko. All rights reserved.
//

import UIKit
import Foundation
import AsyncDisplayKit

class CategoryItemNode: ASCellNode {
    
    // MARK: - Data
    var viewModel: RecipesCategory
    
    // MARK: - Nodes
    let imageNode = ASImageNode()
    let titleNode = ASTextNode()
    
    required init(model: RecipesCategory) {
        self.viewModel = model
        super.init()
        self.automaticallyManagesSubnodes = true
    }
    
    override func didLoad() {
        super.didLoad()
        self.setUpNodes()
    }
    
    // MARK: - SetUps
    private func setUpNodes() {
        self.setUpImageNode()
        self.setUpTitleNode()
    }
    
    private func setUpImageNode() {
        self.imageNode.image = UIImage(named: self.viewModel.imageKey)
        self.imageNode.cornerRoundingType = .precomposited
        self.imageNode.layer.cornerRadius = 10.0
        self.imageNode.contentMode = .scaleAspectFill
        self.imageNode.style.preferredSize = CGSize(width: self.frame.width, height: self.frame.width)
        self.imageNode.layoutIfNeeded()
    }
    
    private func setUpTitleNode() {
        self.titleNode.attributedText = NSAttributedString(
            string: viewModel.title,
            attributes: [
                NSAttributedString.Key.font: UIFont(font: .metrapolisMedium, size: 14.0)!,
                NSAttributedString.Key.foregroundColor: UIColor.darkGreen
            ]
        )
    }
    
    // MARK: - layoutSpecThatFits
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let imageLayout = ASInsetLayoutSpec(insets: .zero, child: imageNode)
        let titleLayout = ASInsetLayoutSpec(insets: .zero, child: titleNode)
        
        let parentLayoutStack = ASStackLayoutSpec(direction: .vertical, spacing: 16.0, justifyContent: .start, alignItems: .baselineFirst, children: [imageLayout, titleLayout])
        
        let mainLayout = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16), child: parentLayoutStack)
        
        return mainLayout
    }
    
}
