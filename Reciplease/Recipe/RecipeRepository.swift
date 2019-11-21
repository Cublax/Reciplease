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
    func checkIfFavorite(recipeName: String, completion: (Bool) -> Void)
    func removeFavorite(recipeName: String)
}

final class RecipeRepository: RecipeRepositoryType {
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func checkIfFavorite(recipeName: String, completion: (Bool) -> Void) {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", recipeName)
        request.sortDescriptors = [NSSortDescriptor(keyPath: \RecipeEntity.name, ascending: true)]
        
        guard let recipes = try? context.fetch(request) else { print("error") ; return }
        
        if recipes == [] {completion(false); return }
        
        completion(true)
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
    
    func removeFavorite(recipeName: String) {
        
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", recipeName)
        
        do {
            let object = try context.fetch(request)
            if !object.isEmpty {
                context.delete(object[0])
                try? context.save()
            }
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
