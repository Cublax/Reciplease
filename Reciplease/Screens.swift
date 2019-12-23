//
//  Screens.swift
//  Reciplease
//
//  Created by Alexandre Quiblier on 01/10/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

final class Screens {
    
    // MARK: - Properties
    
    let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: Screens.self))
    private let context: Context
    
    // MARK: - Initializer
    
    init(context: Context) {
        self.context = context
    }
}

// MARK: - Search

protocol SearchViewModelDelegate: class {
    func presentListing(with ingredients: [Ingredient])
}

extension Screens {
    func createSearchViewController(delegate: SearchViewModelDelegate?) -> UIViewController {
        let viewController = storyboard.instantiateViewController(identifier: "SearchViewController") as! SearchViewController
        let viewModel = SearchViewModel(delegate: delegate)
        viewController.viewModel = viewModel
        return viewController
    }
}

// MARK: - Recipe

extension Screens {
    func createRecipeViewController(recipe: VisibleRecipe) -> UIViewController {
        let viewController = storyboard.instantiateViewController(identifier: "RecipeViewController") as! RecipeViewController
        let repository = RecipeRepository(stack: context.stack)
        let viewModel = RecipeViewModel(recipe: recipe,
                                        repository: repository)
        viewController.viewModel = viewModel
        viewController.imageProvider = context.imageProvider
        return viewController
    }
}

// MARK: - Listing

protocol ListingViewModelDelegate: class {
    func didSelectRecipe(recipe: VisibleRecipe)
    func shouldDisplayAlert(for type: AlertType)
}

extension Screens {
    func createSearchRecipesViewController(delegate: ListingViewModelDelegate?, ingredients: [Ingredient]) -> UIViewController {
        let viewController = storyboard.instantiateViewController(identifier: "ListingViewController") as! ListingViewController
        let handler = RecipeResponseHandler()
        let repository = SearchRepository(networkClient: context.networkClient, handler: handler)
        let viewModel = ListingViewModel(repository: repository,
                                         delegate: delegate,
                                         ingredients: ingredients)
        viewController.viewModel = viewModel
        viewController.imageProvider = context.imageProvider
        return viewController
        
    }
    
    func createFavoriteRecipesViewController(delegate: ListingViewModelDelegate?) -> UIViewController {
        let viewController = storyboard.instantiateViewController(identifier: "ListingViewController") as! ListingViewController
        let repository = FavoriteRepository(stack: context.stack)
        let viewModel = ListingViewModel(repository: repository,
                                         delegate: delegate,
                                         ingredients: [])
        viewController.viewModel = viewModel
        viewController.imageProvider = context.imageProvider
        return viewController
    }
}

// MARK: - Alert

extension Screens {
    func createAlert(for type: AlertType) -> UIAlertController {
        let alert = Alert(type: type)
        let alertController = UIAlertController(title: alert.title,
                                                message: alert.message,
                                                preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok",
                                   style: .cancel,
                                   handler: nil)
        alertController.addAction(action)
        return alertController
    }
}

