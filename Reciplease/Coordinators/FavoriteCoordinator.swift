//
//  FavoriteCoordinator.swift
//  Reciplease
//
//  Created by Alexandre Quiblier on 01/10/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

final class FavoriteCoordinator {
    // MARK: - Properties
    
    private let presenter: UINavigationController
    
    private let screens: Screens
    
    // MARK: - Initializer
    
    init(presenter: UINavigationController, screens: Screens) {
        self.presenter = presenter
        self.screens = screens
    }
    // MARK: - Coordinator
    
    func start() {
        showFavorite()
    }
    
    private func showFavorite() {
        let viewController = screens.createRecipeViewController(delegate: self)
        presenter.viewControllers = [viewController]
    }
}

extension FavoriteCoordinator: RecipeViewModelDelegate {
    
}
