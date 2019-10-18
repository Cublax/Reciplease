//
//  ListingRepository.swift
//  Reciplease
//
//  Created by Alexandre Quiblier on 08/10/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

struct Recipe: Equatable {
    let name: String
    let urlImage: String
    let ingredient : [String]
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
        let myurl: String = "https://api.edamam.com/search?q=\(ingredients.joined(separator: ","))&app_id=${64cf657f}&app_key=${bae5284db1b8f58ddf457036eb46c3d5}2"
        guard let urlForRequest = myurl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        guard let url = URL(string: urlForRequest) else {return}

          client.request(type: RecipeResponse.self, requestType: .GET, url: url) { response in
    
            let item: [Recipe] = response.hits.map { Recipe(name: $0.recipe.label, urlImage: $0.recipe.image, ingredient: $0.recipe.ingredientLines) }
               
            callback(item)
        }
        }
      }
    
    


final class FavoriteListingRepository: ListingRepositoryType {

    // Let coredata blabla
    func getRecipes(for ingredients: [Ingredient], callback: @escaping ([Recipe]) -> Void) {
        
    }
}



