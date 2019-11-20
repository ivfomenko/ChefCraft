//
//  RoundView.swift
//  ChefCraft
//
//  Created by Ivan Fomenko on 16.11.2019.
//  Copyright © 2019 Ivan Fomenko. All rights reserved.
//

import UIKit

class RoundView: UIView {
    override func draw(_ rect: CGRect) {
        layer.masksToBounds = true
        layer.cornerRadius = rect.height / 2.0
    }
}
