//
//  SearchViewModel.swift
//  Reciplease
//
//  Created by Alexandre Quiblier on 01/10/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

protocol SearchViewModelDelegate: class {
    
}

final class SearchViewModel {
    
    // MARK: - Properties

    private let repository: SearchRepositoryType
    
    private weak var delegate: SearchViewModelDelegate?
    
    // MARK: - Initializer

    init(repository: SearchRepositoryType, delegate: SearchViewModelDelegate?) {
        self.repository = repository
        self.delegate = delegate
    }
    // MARK: - Outputs
    
    func viewDidLoad() {
        
    }

    // MARK: - Inputs

}
