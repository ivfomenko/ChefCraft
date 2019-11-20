//
//  UINavigationBar+MultiLineTitle.swift
//  ChefCraft
//
//  Created by Ivan Fomenko on 16.11.2019.
//  Copyright © 2019 Ivan Fomenko. All rights reserved.
//

import UIKit

extension UIViewController {
    func applyMiltuLineTitle() {
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        for sview in navigationBar.subviews {
            for ssview in sview.subviews {
                guard let label = ssview as? UILabel else { break }
                if label.text == self.title {
                    label.numberOfLines = 0
                    label.lineBreakMode = .byWordWrapping
                    label.sizeToFit()
                    UIView.animate(withDuration: 0.3, animations: {
                        navigationBar.frame.size.height = 57 + label.frame.height
                    })
                }
            }
        }
    }
}
