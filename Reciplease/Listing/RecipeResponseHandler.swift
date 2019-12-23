//
//  RecipeResponseHandler.swift
//  RecipleaseTests
//
//  Created by Alexandre Quiblier on 13/12/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

protocol RecipeResponseHandlerType {
    func process(_ response: HTTPResponse<RecipeResponse>, success: @escaping ([Recipe]) -> Void, failure: @escaping (() -> Void))
}

final class RecipeResponseHandler: RecipeResponseHandlerType {
    func process(_ response: HTTPResponse<RecipeResponse>, success: @escaping ([Recipe]) -> Void, failure: @escaping (() -> Void)) {
        switch response.result {
        case .success(let response):
            let item: [Recipe] = response.hits.map { Recipe(name: $0.recipe.label,
                                                            urlImage: $0.recipe.image,
                                                            urlRecipe: $0.recipe.url,
                                                            source: $0.recipe.source,
                                                            servings: $0.recipe.yield,
                                                            ingredient: $0.recipe.ingredientLines)}
            success(item)
        case .failure(_):
            failure()
        }
    }
}
