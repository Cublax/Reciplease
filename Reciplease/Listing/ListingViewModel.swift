//
//  ListingViewModel.swift
//  Reciplease
//
//  Created by Alexandre Quiblier on 08/10/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

protocol ListingViewModelDelegate: class {
    
}

struct VisibleRecipe {
    
}

final class ListingViewModel {
    
    // MARK: - Properties
    
    private let repository: ListingRepositoryType
    
    private weak var delegate: ListingViewModelDelegate?
    
    private var ingredients: [Ingredient]
    
    // MARK: - Init
    
    init(repository: ListingRepositoryType, delegate: ListingViewModelDelegate?, ingredients: [Ingredient]) {
        self.repository = repository
        self.delegate = delegate
        self.ingredients = ingredients
    }

    // MARK: - Outputs
    
    func viewDidLoad() {
        repository.getRecipes(for: ingredients) { [weak self] recipes in
            // transformer le tableau de Recipes en tableau de VisibleRecipes
        }
    }
    
    // MARK: - Inputs

    func didSelectRecipe(at index: Int) {
        //tu prends l'item à lindex dans ton tableau de recipe
        // Tu send au coordinator le delagete.didSelctRecipe(recipe)
    }
}
