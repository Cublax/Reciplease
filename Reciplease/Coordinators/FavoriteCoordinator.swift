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
        showList()
    }
    
    private func showList() {
        let viewController = screens.createFavoriteRecipesViewController(delegate: self)
        presenter.show(viewController, sender: nil)
    }
    
    private func showRecipe(of recipe: VisibleRecipe) {
        let viewController = screens.createRecipeViewController(recipe: recipe)
        presenter.show(viewController, sender: nil)
    }
    
    func showAlert(for type: AlertType) {
        let alert = screens.createAlert(for: type)
        presenter.visibleViewController?.present(alert, animated: true, completion: nil)
    }
}

extension FavoriteCoordinator: ListingViewModelDelegate {
    func shouldDisplayAlert(for type: AlertType) {
        showAlert(for: type)
    }
    
    func didSelectRecipe(recipe: VisibleRecipe) {
        showRecipe(of: recipe)
    }
}
