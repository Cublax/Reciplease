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
    
    // MARK: - Initializer

    init(recipe: VisibleRecipe) {
        self.recipe = recipe
    }
    // MARK: - Outputs

    func viewDidLoad() {
      informations?(recipe)
    }
    
    var informations: ((VisibleRecipe) -> Void)?
    
    // MARK: - Inputs


}
