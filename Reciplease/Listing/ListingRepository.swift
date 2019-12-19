//
//  ListingRepository.swift
//  Reciplease
//
//  Created by Alexandre Quiblier on 08/10/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation
import CoreData

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

final class SearchRepository: ListingRepositoryType {
    
    // MARK: - Properties
    
    private let networkClient: HTTPClient
    
    private let urlRequestBuilder = URLRequestBuilder()
    
    private let cancellationToken = RequestCancellationToken()
    
    private let handler: RecipeResponseHandlerType
    
    // MARK: - Initializer
    
    init(networkClient: HTTPClient, handler: RecipeResponseHandlerType) {
        self.networkClient = networkClient
        self.handler = handler
    }
    
    // MARK: - Requests
    
    func getRecipes(for ingredients: [Ingredient], success: @escaping ([Recipe]) -> Void, failure: @escaping (() -> Void)) {
        let myurl: String = "https://api.edamam.com/search?q=\(ingredients.joined(separator: ","))&app_id=64cf657f&app_key=bae5284db1b8f58ddf457036eb46c3d5&from=0&to=50"
        
        guard let urlForRequest = myurl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        guard let url = URL(string: urlForRequest) else {return}
        
        let urlRequest = URLRequest(url: url)
        
        networkClient
            .executeTask(urlRequest, cancelledBy: cancellationToken)
            .processCodableResponse { (response: HTTPResponse<RecipeResponse>) in
                self.handler.process(response, success: success, failure: failure)
        }
    }
}
