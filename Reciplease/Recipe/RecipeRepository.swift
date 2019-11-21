//
//  RecipeRepository.swift
//  Reciplease
//
//  Created by Alexandre Quiblier on 14/11/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation
import CoreData

protocol RecipeRepositoryType: class {
    func addToFavorite(recipe: VisibleRecipe)
}

final class RecipeRepository: RecipeRepositoryType {
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func addToFavorite(recipe: VisibleRecipe) {
        let recipeObject = RecipeEntity(context: context)
        recipeObject.name = recipe.name
        recipeObject.urlImage = recipe.urlImage
        recipeObject.servings = "\(recipe.servings)"
        recipeObject.urlRecipe = recipe.urlRecipe
        recipeObject.ingredients = recipe.ingredient.joined(separator: "@")
        recipeObject.source = recipe.source
        try? context.save()
    }
}
