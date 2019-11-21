//
//  ListingViewModel.swift
//  Reciplease
//
//  Created by Alexandre Quiblier on 08/10/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

struct VisibleRecipe: Equatable {
    let name: String
    let urlImage: String
    let urlRecipe: String
    let source: String
    let servings: Int
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
        refresh()
    }
    
    private func refresh() {
        repository.getRecipes(for: ingredients, success: { (recipes) in
            self.requestedRecipes = recipes.map { VisibleRecipe(name: $0.name, urlImage: $0.urlImage, urlRecipe: $0.urlRecipe, source: $0.source, servings: $0.servings, ingredient: $0.ingredient) }
        }, failure: { [weak self] in
            self?.delegate?.shouldDisplayAlert(for: .requestError)
        })
    }
    
    // MARK: - Inputs
    
    func didSelectRecipe(at index: Int) {
        guard index < requestedRecipes.count else { return }
        
        delegate?.didSelectRecipe(recipe: requestedRecipes[index])
    }
}

