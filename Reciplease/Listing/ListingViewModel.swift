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
    let name: String
    let urlImage: String
    let ingredient : [String]
}

final class ListingViewModel {
    
    // MARK: - Properties
    
    private let repository: ListingRepositoryType
    
    private weak var delegate: ListingViewModelDelegate?
    
    private var ingredients: [Ingredient]
    
    private var requestedRecipes: [VisibleRecipe] = [] {
        didSet {
            recipes?(self.requestedRecipes)
        }
    }
 
    // MARK: - Init
    
    init(repository: ListingRepositoryType, delegate: ListingViewModelDelegate?, ingredients: [Ingredient]) {
        self.repository = repository
        self.delegate = delegate
        self.ingredients = ingredients
    }

    // MARK: - Outputs
    
    var recipes: (([VisibleRecipe]) -> Void)?
    
    func viewDidLoad() {
        repository.getRecipes(for: ingredients) { (recipes) in
            let item: [VisibleRecipe] = recipes.map { VisibleRecipe(name: $0.name, urlImage: $0.urlImage, ingredient: $0.ingredient) }
            self.requestedRecipes = item
        }
    }
    
    // MARK: - Inputs

    func didSelectRecipe(at index: Int) {
        //tu prends l'item à lindex dans ton tableau de recipe
        // Tu send au coordinator le delagete.didSelctRecipe(recipe)
    }
}
