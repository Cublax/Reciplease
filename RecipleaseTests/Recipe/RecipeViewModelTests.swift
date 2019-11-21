//
//  RecipeViewModelTests.swift
//  RecipleaseTests
//
//  Created by Alexandre Quiblier on 21/11/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import XCTest
@testable import Reciplease

fileprivate final class MockRecipeRepository: RecipeRepositoryType {
    
    var favorite = true
    func addToFavorite(recipe: VisibleRecipe) {
    }
    
    func checkIfFavorite(recipeName: String, completion: (Bool) -> Void) {
        completion(favorite)
    }
    
    func removeFavorite(recipeName: String) {
    }
}

fileprivate final class MockRecipeRepository2: RecipeRepositoryType {
    
    var favorite = false
    func addToFavorite(recipe: VisibleRecipe) {
    }
    
    func checkIfFavorite(recipeName: String, completion: (Bool) -> Void) {
        completion(favorite)
    }
    
    func removeFavorite(recipeName: String) {
    }
}

fileprivate final class RecipeViewModelTests: XCTestCase {
    
    func testGivenARecipeViewModelWhenAViewDidLoadThenGetInformationIfFavorite() {
        let recipe = VisibleRecipe(name: "1", urlImage: "1", urlRecipe: "1", source: "1", servings: 1, ingredient: ["1"])
        let repository = MockRecipeRepository()
        let viewModel = RecipeViewModel(recipe: recipe, repository: repository)
        let expectation = self.expectation(description: "Returned true")
        
        viewModel.isFavorite = { answer in
            XCTAssertEqual(answer, true)
            expectation.fulfill()
        }
        
        viewModel.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenARecipeViewModelWhenclickedOnFavoriteThenIsFavoriteReturnFalse() {
        let recipe = VisibleRecipe(name: "1", urlImage: "1", urlRecipe: "1", source: "1", servings: 1, ingredient: ["1"])
        let repository = MockRecipeRepository()
        let viewModel = RecipeViewModel(recipe: recipe, repository: repository)
        
        let expectation = self.expectation(description: "Returned true")
        
        var counter = 0
        viewModel.isFavorite = { answer in
            if counter == 1 {
                XCTAssertEqual(answer, false)
                expectation.fulfill()
            }
            counter += 1
        }
        
        viewModel.viewDidLoad()
        viewModel.clickedOnFavorite()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenARecipeViewModelWhenclickedOnFavoriteThenIsFavoriteReturnTrue() {
        let recipe = VisibleRecipe(name: "1", urlImage: "1", urlRecipe: "1", source: "1", servings: 1, ingredient: ["1"])
        let repository = MockRecipeRepository2()
        let viewModel = RecipeViewModel(recipe: recipe, repository: repository)
        
        let expectation = self.expectation(description: "Returned true")
        
        var counter = 0
        viewModel.isFavorite = { answer in
            if counter == 1 {
                XCTAssertEqual(answer, true)
                expectation.fulfill()
            }
            counter += 1
        }
        
        viewModel.viewDidLoad()
        viewModel.clickedOnFavorite()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
