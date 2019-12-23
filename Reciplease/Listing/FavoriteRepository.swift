//
//  FavoriteRepository.swift
//  Reciplease
//
//  Created by Alexandre Quiblier on 13/12/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import CoreData

final class FavoriteRepository: ListingRepositoryType {
    
    let stack: CoreDataStack
    
    init(stack: CoreDataStack) {
        self.stack = stack
    }
    
    func getRecipes(for ingredients: [Ingredient], success: @escaping ([Recipe]) -> Void, failure: @escaping (() -> Void)) {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        guard let response = try? stack.context.fetch(request) else { return }
        let items: [Recipe] = response.map  { Recipe(recipeEntity: $0) }
        success(items)
    }
}
