//
//  ListingViewModelTests.swift
//  RecipleaseTests
//
//  Created by Alexandre Quiblier on 21/11/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import XCTest
@testable import Reciplease

fileprivate final class MockListingRepository: ListingRepositoryType {
    func getRecipes(for ingredients: [Ingredient], success: @escaping ([Recipe]) -> Void, failure: @escaping (() -> Void)) {
        success([Recipe(name: "1",
                        urlImage: "1",
                        urlRecipe: "1",
                        source: "1",
                        servings: 1,
                        ingredient: ["1"])])
    }
}

fileprivate final class MockListingViewModelDelegate: ListingViewModelDelegate {
    var recipe = VisibleRecipe(name: "1",
                               urlImage: "1",
                               urlRecipe: "1",
                               source: "1",
                               servings: 1,
                               ingredient: ["1"])
    var alert: AlertType? = nil
    
    func didSelectRecipe(recipe: VisibleRecipe) {
        self.recipe = recipe
    }
    
    func shouldDisplayAlert(for type: AlertType) {
        self.alert = type
    }
    
    
}

fileprivate final class ListingViewModelTests: XCTestCase {
    
    func testGivenAViewModelWhenViewDidLoadThenRecipesIsCorrectlyFetched() {
        let delegate = MockListingViewModelDelegate()
        let repository = MockListingRepository()
        let viewModel = ListingViewModel(repository: repository,
                                         delegate: delegate,
                                         ingredients: [""])
        let expectation = self.expectation(description: "Meteo request on berlin is correctly returned")
        
        let expectedResult: [VisibleRecipe] = [VisibleRecipe(name: "1",
                                                             urlImage: "1",
                                                             urlRecipe: "1",
                                                             source: "1",
                                                             servings: 1,
                                                             ingredient: ["1"])]
        
        viewModel.recipes = { items in
            XCTAssertEqual(items, expectedResult)
            expectation.fulfill()
        }
        
        
        viewModel.viewDidLoad()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenAViewModelWhenDidSelectRecipeThenDelegateSendRightRecipe() {
        let delegate = MockListingViewModelDelegate()
        let repository = MockListingRepository()
        let viewModel = ListingViewModel(repository: repository,
                                         delegate: delegate,
                                         ingredients: [""])
        
        
        let expectedResult: VisibleRecipe = VisibleRecipe(name: "1",
                                                          urlImage: "1",
                                                          urlRecipe: "1",
                                                          source: "1",
                                                          servings: 1,
                                                          ingredient: ["1"])
        
        viewModel.viewDidLoad()
        viewModel.didSelectRecipe(at: 0)
        
        XCTAssertEqual(delegate.recipe, expectedResult)
    }
}
