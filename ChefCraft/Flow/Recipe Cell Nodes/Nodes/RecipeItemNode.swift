//
//  RecipeItemNode.swift
//  ChefCraft
//
//  Created by Ivan Fomenko on 18.11.2019.
//  Copyright © 2019 Ivan Fomenko. All rights reserved.
//

import UIKit
import Foundation
import AsyncDisplayKit

class RecipeItemNode: ASCellNode {
    
    // MARK: - Data
    var viewModel: RecipeModel
    
    // MARK: - Nodes
    let imageNode = ASImageNode()
    let titleNode = ASTextNode()
    let authorNode = ASTextNode()
    
    required init(model: RecipeModel) {
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
        self.setUpLabelsNodes()
    }
    
    private func setUpImageNode() {
        self.imageNode.image = UIImage(named: self.viewModel.imageKey)
        self.imageNode.cornerRoundingType = .precomposited
        self.imageNode.layer.cornerRadius = 10.0
        self.imageNode.contentMode = .scaleAspectFill
        
        self.imageNode.style.preferredSize = CGSize(width: self.frame.width, height: self.frame.width)
        self.imageNode.layoutIfNeeded()
    }
    
    private func setUpLabelsNodes() {
        self.titleNode.attributedText = NSAttributedString(
            string: viewModel.title,
            attributes: [
                NSAttributedString.Key.font: UIFont(font: .metrapolisMedium, size: 14.0)!,
                NSAttributedString.Key.foregroundColor: UIColor.darkGreen
            ]
        )
        
        self.authorNode.attributedText = NSAttributedString(
            string: "by".localized + " \(viewModel.authorName)",
            attributes: [
                NSAttributedString.Key.font: UIFont(font: .metrapolisLight, size: 14.0)!,
                NSAttributedString.Key.foregroundColor: UIColor.darkGreen
            ]
        )
    }
    
    // MARK: - layoutSpecThatFits
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let imageLayout = ASInsetLayoutSpec(insets: .zero, child: imageNode)
        let titleLayout = ASInsetLayoutSpec(insets: .zero, child: titleNode)
        let authorNameLayot = ASInsetLayoutSpec(insets: .zero, child: authorNode)
        
        let titleGroupedLayour = ASStackLayoutSpec(direction: .vertical, spacing: 8.0, justifyContent: .start, alignItems: .baselineFirst, children: [titleLayout, authorNameLayot])
        
        let parentLayoutStack = ASStackLayoutSpec(direction: .vertical, spacing: 16.0, justifyContent: .start, alignItems: .baselineFirst, children: [imageLayout, titleGroupedLayour])
        
        let mainLayout = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0), child: parentLayoutStack)
        
        return mainLayout
    }
    
}
