//
//  ReactiveUIControl.swift
//  ChefCraft
//
//  Created by Ivan Fomenko on 20.11.2019.
//  Copyright © 2019 Ivan Fomenko. All rights reserved.
//

import RxCocoa
import RxSwift

extension Reactive where Base: UIControl {
    var isSelected: Observable<Bool> {
        let anyObservable = self.base.rx.methodInvoked(#selector(setter: self.base.isSelected))
        
        let boolObservable = anyObservable
            .flatMap { Observable.from(optional: $0.first as? Bool) }
            .startWith(self.base.isSelected)
            .distinctUntilChanged()
            .share()
        
        return boolObservable
    }
}
