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

extension Screens {
    func createSearchViewController(delegate: SearchViewModelDelegate?) -> UIViewController {
        let viewController = storyboard.instantiateViewController(identifier: "SearchViewController") as! SearchViewController
        let repository = SearchRepository()
        let viewModel = SearchViewModel(repository: repository,
                                        delegate: delegate)
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

    extension Screens {
        func createListingViewController(delegate: ListingViewModelDelegate?) -> UIViewController {
            let viewController = storyboard.instantiateViewController(identifier: "ListingViewController") as! ListingViewController
            let repository = ListingRepository()
            let viewModel = ListingViewModel(repository: repository,
                                             delegate: delegate)
            viewController.viewModel = viewModel
            return viewController
        
    }
}
