//
//  FavoriteViewModel.swift
//  Reciplease
//
//  Created by Alexandre Quiblier on 01/10/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

final class RecipeViewModel {
    
    // MARK: - Properties
    
    var recipe: VisibleRecipe
    
    private let repository: RecipeRepositoryType
    
    // MARK: - Initializer
    
    init(recipe: VisibleRecipe, repository: RecipeRepositoryType) {
        self.recipe = recipe
        self.repository = repository
    }
    
    // MARK: - Outputs
    
    func viewDidLoad() {
        informations?(recipe)
        
        repository.checkIfFavorite(recipeName: recipe.name) { state in
            self.isFavorite?(state)
        }
    }
    
    var informations: ((VisibleRecipe) -> Void)?
    
    var isFavorite: ((Bool) -> Void)?
    
    // MARK: - Inputs
    
    func clickedOnFavorite() {
        repository.checkIfFavorite(recipeName: recipe.name) { (favoriteState) in
            switch favoriteState {
            case true:
                repository.removeFavorite(recipeName: recipe.name)
                isFavorite?(false)
            case false:
                repository.addToFavorite(recipe: recipe)
                isFavorite?(true)
            }
        }
    }
}
