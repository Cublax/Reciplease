//
//  SearchViewModelTests.swift
//  RecipleaseTests
//
//  Created by Alexandre Quiblier on 15/11/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import XCTest
@testable import Reciplease

fileprivate final class MockSearchViewModelDelegate: SearchViewModelDelegate {
    var ingredients = [""]
    
    func presentListing(with ingredients: [Ingredient]) {
        self.ingredients = ingredients
    }
}

fileprivate final class SearchViewModelTests: XCTestCase {
    
    func testGivenASearchViewModelWhenAddIngredientThenIngredientsAreSentVia
        () {
        let delegate = MockSearchViewModelDelegate()
        let viewModel = SearchViewModel(delegate: delegate)
        let expectation = self.expectation(description: "When calling the addIngredient func the ingredient is correctly added to the ingredients array")
        
        let expectedResult = ["Patatas"]
        
        viewModel.visibleItems = { items in
            XCTAssertEqual(items, expectedResult)
            expectation.fulfill()
        }
        
        viewModel.viewDidLoad()
        
        viewModel.addIngredient(for: "Patatas")
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenASearchViewModelWhenclearIngredientListThenIngredientIngredientListIsEmptied() {
        let delegate = MockSearchViewModelDelegate()
        let viewModel = SearchViewModel(delegate: delegate)
        let expectation = self.expectation(description: "When calling the addIngredient func the ingredient is correctly added to the ingredients array")
        
        let expectedResult: [String] = []
        
        viewModel.visibleItems = { items in
            XCTAssertEqual(items, expectedResult)
            expectation.fulfill()
        }
        
        viewModel.viewDidLoad()
        
        viewModel.clearIngredientList()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenASearchViewModelWhenSearchForIngredientsThenDelegateIsCorrectlyCalled() {
        let delegate = MockSearchViewModelDelegate()
        let viewModel = SearchViewModel(delegate: delegate)
        
        
        let expectedResult = ["Patatas"]
        
        viewModel.viewDidLoad()
        
        viewModel.addIngredient(for: "Patatas")
        
        viewModel.searchForIngredients()
        
        XCTAssertEqual(delegate.ingredients, expectedResult)
    }
}
