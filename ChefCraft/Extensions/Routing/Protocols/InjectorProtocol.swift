//
//  InjectorProtocol.swift
//  ChefCraft
//
//  Created by Ivan Fomenko on 12.11.2019.
//  Copyright © 2019 Ivan Fomenko. All rights reserved.
//

import Swinject

protocol InjectorProtocol {
    var injector: Container { get set }
}
