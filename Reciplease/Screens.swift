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

protocol SearchViewControllerDelegate: class {
    func presentListing(with ingredients: [Ingredient])
}

extension Screens {
    func createSearchViewController(delegate: SearchViewControllerDelegate?) -> UIViewController {
        let viewController = storyboard.instantiateViewController(identifier: "SearchViewController") as! SearchViewController
        let viewModel = SearchViewModel(delegate: delegate)
        viewController.viewModel = viewModel
        return viewController
    }
}

// MARK: - Favorite

extension Screens {
    func createRecipeViewController(delegate: RecipeViewModelDelegate?) -> UIViewController {
        let viewController = storyboard.instantiateViewController(identifier: "RecipeViewController") as! RecipeViewController
        let repository = RecipeRepository()
        let viewModel = RecipeViewModel(repository: repository,
                                        delegate: delegate)
        viewController.viewModel = viewModel
        return viewController
    }
}

// MARK: - Listing

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

    func createFavoritesRecipesViewController(delegate: ListingViewModelDelegate?) -> UIViewController {
        let viewController = storyboard.instantiateViewController(identifier: "ListingViewController") as! ListingViewController
        let repository = FavoriteListingRepository()
        let viewModel = ListingViewModel(repository: repository,
                                         delegate: delegate,
                                         ingredients: [])
        viewController.viewModel = viewModel
        return viewController
    }
}
