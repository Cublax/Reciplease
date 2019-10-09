//
//  FavoriteViewModel.swift
//  Reciplease
//
//  Created by Alexandre Quiblier on 01/10/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

protocol RecipeViewModelDelegate: class {
     
}

final class RecipeViewModel {
    
    // MARK: - Properties

    private let repository: RecipeRepositoryType
    
    private weak var delegate: RecipeViewModelDelegate?
    
    // MARK: - Initializer

    init(repository: RecipeRepositoryType, delegate: RecipeViewModelDelegate?) {
        self.repository = repository
        self.delegate = delegate
    }
    // MARK: - Outputs

    func viewDidLoad() {
        
    }
    // MARK: - Inputs

}
