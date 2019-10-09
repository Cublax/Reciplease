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

final class ListingViewModel {
    
    // MARK: - Properties
    
    private let repository: ListingRepositoryType
    
    private weak var delegate: ListingViewModelDelegate?
    
    // MARK: - Init
    
    init(repository: ListingRepositoryType, delegate: ListingViewModelDelegate?) {
        self.repository = repository
        self.delegate = delegate
    }

    // MARK: - Outputs
    
    func viewDidLoad() {
           
       }
    
    // MARK: - Inputs


}
