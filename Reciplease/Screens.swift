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
        let repository = RecipeRepository()
        let viewModel = RecipeViewModel(repository: repository,
                                        recipe: recipe)
        viewController.viewModel = viewModel
        return viewController
    }
}

// MARK: - Listing

protocol ListingViewModelDelegate: class {
    func didSelectRecipe(recipe: VisibleRecipe)
}

extension Screens {
    func createSearchRecipesViewController(delegate: ListingViewModelDelegate?, ingredients: [Ingredient]) -> UIViewController {
        let viewController = storyboard.instantiateViewController(identifier: "ListingViewController") as! ListingViewController
        let repository = SearchListingRepository()
        let viewModel = ListingViewModel(repository: repository,
                                         delegate: delegate,
                                         ingredients: ingredients)
        viewController.viewModel = viewModel
        return viewController
        
    }

    func createFavoriteRecipesViewController(delegate: ListingViewModelDelegate?) -> UIViewController {
        let viewController = storyboard.instantiateViewController(identifier: "ListingViewController") as! ListingViewController
        let repository = FavoriteListingRepository()
        let viewModel = ListingViewModel(repository: repository,
                                         delegate: delegate,
                                         ingredients: [])
        viewController.viewModel = viewModel
        return viewController
    }
}
