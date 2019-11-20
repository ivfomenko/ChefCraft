//
//  DependenciesHolder.swift
//  ChefCraft
//
//  Created by Ivan Fomenko on 12.11.2019.
//  Copyright © 2019 Ivan Fomenko. All rights reserved.
//

import Foundation
import Swinject

class DependenciesHolder {
    
    func injector() -> Container {
        let container = Container()
        
        // Register SINGLETON 'AppStoryboards' instance
        container.register(AppStoryboards.self) { _ -> AppStoryboards in
            return AppStoryboards()
        }.inObjectScope(.container)

        return container
    }
}
