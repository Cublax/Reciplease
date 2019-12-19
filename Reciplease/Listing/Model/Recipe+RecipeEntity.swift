//
//  Recipe+RecipeEntity.swift
//  Reciplease
//
//  Created by Alexandre Quiblier on 18/12/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import CoreData

extension Recipe {
    init(recipeEntity: RecipeEntity) {
        self.name = recipeEntity.name ?? ""
        self.urlImage = recipeEntity.urlImage ?? ""
        self.urlRecipe = recipeEntity.urlRecipe ?? ""
        self.source = recipeEntity.source ?? ""
        self.servings = Int(recipeEntity.servings ?? "") ?? 1
        self.ingredient = (recipeEntity.ingredients?.components(separatedBy: "@") ?? [""])
    }
}

