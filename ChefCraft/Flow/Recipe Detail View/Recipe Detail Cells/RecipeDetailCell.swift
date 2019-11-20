//
//  RecipeDetailCell.swift
//  ChefCraft
//
//  Created by Ivan Fomenko on 19.11.2019.
//  Copyright © 2019 Ivan Fomenko. All rights reserved.
//

import UIKit

class RecipeDetailCell: UITableViewCell, CellInizializable {

    @IBOutlet weak var mainContainer: UIView!
    @IBOutlet weak var likeButton: SelectableButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.mainContainer.layer.cornerRadius = 20.0
    }
    
    @IBAction func likeActionAreaTouched(_ sender: Any) {
        self.likeButton.isSelected = !self.likeButton.isSelected
    }
}
