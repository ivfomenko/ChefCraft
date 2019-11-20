//
//  AppError.swift
//  ChefCraft
//
//  Created by Ivan Fomenko on 18.11.2019.
//  Copyright © 2019 Ivan Fomenko. All rights reserved.
//

import Foundation

// MARK: - AppError
/// Global App Error Enum
enum AppError: Error {
    case unknowError
}

// MARK: - HomeViewError
/// Error Enum for Home View Controller
enum HomeViewError: Error {
    case handleListError
}
