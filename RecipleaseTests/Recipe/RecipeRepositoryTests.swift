//
//  RecipeRepositoryTests.swift
//  RecipleaseTests
//
//  Created by Alexandre Quiblier on 27/11/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

@testable import Reciplease
import XCTest
import CoreData

class RecipeRepositoryTests: XCTestCase {

    func testGivenARecipeRepositoryWhenAddedToFavoriteThenIsCorrectlyAdded() {
        let stack = CoreDataStack(modelName: "Model", type: CoreDataStackType.test)
        let repository = RecipeRepository(stack: stack)
        let recipe = VisibleRecipe(name: "Choucroute",
                                   urlImage: "imageString",
                                   urlRecipe: "url",
                                   source: "Recipe.com",
                                   servings: 5,
                                   ingredient: ["Choux",
                                                "Saucisse",
                                                "Vin Blanc"])
        
        let expectation1 = self.expectation(description: "Correctly added to Favorites")
        
        repository.addToFavorite(recipe: recipe)
        
        repository.checkIfFavorite(recipeName: recipe.name) { (status) in
            XCTAssertEqual(status, true)
            expectation1.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenARecipeRepositoryWhenRemoveFromFavoriteThenIsCorrectlyRemoved() {
           let stack = CoreDataStack(modelName: "Model", type: CoreDataStackType.test)
           let repository = RecipeRepository(stack: stack)
           let recipe = VisibleRecipe(name: "Choucroute",
                                      urlImage: "imageString",
                                      urlRecipe: "url",
                                      source: "Recipe.com",
                                      servings: 5,
                                      ingredient: ["Choux",
                                                   "Saucisse",
                                                   "Vin Blanc"])
           
           let expectation1 = self.expectation(description: "Correctly removed from Favorites")
           
           repository.addToFavorite(recipe: recipe)
        
        repository.removeFavorite(recipeName: recipe.name)
           
           repository.checkIfFavorite(recipeName: recipe.name) { (status) in
               XCTAssertEqual(status, false)
               expectation1.fulfill()
           }
           waitForExpectations(timeout: 1.0, handler: nil)
       }

}


