//
//  SearchCoordinator.swift
//  Reciplease
//
//  Created by Alexandre Quiblier on 01/10/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

final class SearchCoordinator {
    
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
        showSearch()
    }
    
    private func showSearch() {
        let viewController = screens.createSearchViewController(delegate: self)
        presenter.viewControllers = [viewController]
    }
    
    private func showList(ingredients: [Ingredient]) {
        let viewController = screens.createSearchRecipesViewController(delegate: self, ingredients: ingredients)
        presenter.show(viewController, sender: nil)
    }
    
    private func showRecipe(of recipe: VisibleRecipe) {
        let viewController = screens.createRecipeViewController(recipe: recipe)
        presenter.show(viewController, sender: nil)
    }
}

extension SearchCoordinator: SearchViewModelDelegate {
    func presentListing(with ingredients: [Ingredient]) {
        showList(ingredients: ingredients)
    }
}

extension SearchCoordinator: ListingViewModelDelegate {
    func didSelectRecipe(recipe: VisibleRecipe) {
        showRecipe(of: recipe)
    }
}
