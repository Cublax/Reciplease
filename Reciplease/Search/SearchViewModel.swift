//
//  SearchViewModel.swift
//  Reciplease
//
//  Created by Alexandre Quiblier on 01/10/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

typealias Ingredient = String

final class SearchViewModel {
    
    // MARK: - Properties
    
    private weak var delegate: SearchViewModelDelegate?
    
    private var ingredients: [Ingredient] = [] {
        didSet {
            visibleItems?(ingredients)
        }
    }
    
    // MARK: - Initializer
    
    init(delegate: SearchViewModelDelegate?) {
        self.delegate = delegate
    }
    // MARK: - Outputs
    
    func viewDidLoad() {
    
    }
    
    var visibleItems: (([String]) -> Void)?
    
    // MARK: - Inputs
    
    func addIngredient(for ingredient: String) {
        ingredients.append(ingredient)
    }
    
    func clearIngredientList() {
        ingredients = []
    }
    
    func searchForIngredients() {
        guard !ingredients.isEmpty else {return} // + alert?
        delegate?.presentListing(with: ingredients)
    }
}


