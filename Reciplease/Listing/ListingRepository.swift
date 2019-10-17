//
//  ListingRepository.swift
//  Reciplease
//
//  Created by Alexandre Quiblier on 08/10/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

struct Recipe {
    
}

protocol ListingRepositoryType: class {
    func getRecipes(for ingredients: [Ingredient], callback: @escaping ([Recipe]) -> Void)
}

final class SearchListingRepository: ListingRepositoryType {

      // MARK: - Properties
    
      private let client: HTTPClient
      
      private let token = RequestCancellationToken()
      
      // MARK: - Initializer

      init() {
          self.client = HTTPClient(cancellationToken: token)
      }
      
      // MARK: - Requests
      
       func getRecipes(for ingredients: [Ingredient], callback: @escaping ([Recipe]) -> Void) {
          guard let url = URL(string: "http://data.fixer.io/api/latest?access_key=bc44d0b411a56c92c53f0b0962be3a0f&base=EUR") else { return }
          
          client.request(type: Ingredient.self, requestType: .GET, url: url) { (response) in
              let item: Recipe = Recipe()
            callback([item])
          }
      }
}

final class FavoriteListingRepository: ListingRepositoryType {

    // Let coredata blabla
    func getRecipes(for ingredients: [Ingredient], callback: @escaping ([Recipe]) -> Void) {
        
    }
}
