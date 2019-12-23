//
//  SearchRepository.swift
//  Reciplease
//
//  Created by Alexandre Quiblier on 01/10/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

protocol SearchRepositoryType {
    
}

final class SearchRepository: SearchRepositoryType {
    
    // MARK: - Properties
    
    private let client: HTTPClient
    
    private let token = RequestCancellationToken()
    
    // MARK: - Initializer

    init() {
        self.client = HTTPClient(cancellationToken: token)
    }
    // MARK: - Requests

}
