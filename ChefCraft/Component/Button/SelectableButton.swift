//
//  SelectableButton.swift
//  ChefCraft
//
//  Created by Ivan Fomenko on 20.11.2019.
//  Copyright © 2019 Ivan Fomenko. All rights reserved.
//

import RxCocoa
import RxSwift

@IBDesignable
class SelectableButton: UIButton {
    
    @IBInspectable var selectedColor: UIColor?
    
    @IBInspectable var defaultColor: UIColor = .unActive1 {
        didSet(newValue) {
            self.tintColor = newValue
        }
    }
    
    private let bag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    private func commonInit() {
        self.rx.isSelected
            .subscribe(onNext: { [weak self] isSelected in
                guard let self = self, let selectedColor = self.selectedColor else { return }
                UIView.transition(with: self, duration: 0.3, options: .curveEaseInOut, animations: {
                    self.tintColor = isSelected ? selectedColor : self.defaultColor
                })
                
            })
            .disposed(by: self.bag)
    }
    
}
