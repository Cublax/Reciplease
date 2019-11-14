//
//  ListingRepository.swift
//  Reciplease
//
//  Created by Alexandre Quiblier on 08/10/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation
import UIKit

struct Recipe: Equatable {
    let name: String
    let urlImage: String
    let urlRecipe: String
    let source: String
    let servings: Int
    let ingredient : [String]
}

protocol ListingRepositoryType: class {
     func getRecipes(for ingredients: [Ingredient], success: @escaping ([Recipe]) -> Void, failure: @escaping (() -> Void))
}

final class SearchListingRepository: ListingRepositoryType {

      // MARK: - Properties
    
    private let networkClient: HTTPClient
         
    private let urlRequestBuilder = URLRequestBuilder()
    
    private let cancellationToken = RequestCancellationToken()
      
      // MARK: - Initializer

      init(networkClient: HTTPClient) {
          self.networkClient = networkClient
      }
      
      // MARK: - Requests
      
       func getRecipes(for ingredients: [Ingredient], success: @escaping ([Recipe]) -> Void, failure: @escaping (() -> Void)) {
        let myurl: String = "https://api.edamam.com/search?q=\(ingredients.joined(separator: ","))&app_id=${64cf657f}&app_key=${bae5284db1b8f58ddf457036eb46c3d5}&from=0&to=50"
        
        guard let urlForRequest = myurl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        guard let url = URL(string: urlForRequest) else {return}

        let urlRequest = URLRequest(url: url)

        networkClient
            .executeTask(urlRequest, cancelledBy: cancellationToken)
            .processCodableResponse { (response: HTTPResponse<RecipeResponse>) in
                switch response.result {
                case .success(let response):
                    let item: [Recipe] = response.hits.map { Recipe(name: $0.recipe.label, urlImage: $0.recipe.image, urlRecipe: $0.recipe.url, source: $0.recipe.source, servings: $0.recipe.yield, ingredient: $0.recipe.ingredientLines) }
                 success(item)
                case .failure(_):
                    failure()
                }
        }
        }
      }


final class FavoriteListingRepository: ListingRepositoryType {

    func getRecipes(for ingredients: [Ingredient], success: @escaping ([Recipe]) -> Void, failure: @escaping (() -> Void)) {
      
        
        }

    }





