//
//  ListingRepositoryTests.swift
//  RecipleaseTests
//
//  Created by Alexandre Quiblier on 13/12/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import XCTest
@testable import Reciplease

final class MockRepository: ListingRepositoryType {
    
    var isSuccess = true
    var recipes: [Recipe] = []
    
    func getRecipes(for ingredients: [Ingredient],
                    success: @escaping ([Recipe]) -> Void,
                    failure: @escaping (() -> Void)) {
        isSuccess ? success(recipes) : failure()
    }
}

var mockHttpClient: HTTPClient {
    return HTTPClient(engine: .urlSession(.default))
}


final class MockHandler: RecipeResponseHandlerType {
    var isSuccess = true
    var recipes: [Recipe] = []
    func process(_ response: HTTPResponse<RecipeResponse>, success: @escaping ([Recipe]) -> Void, failure: @escaping (() -> Void)) {
        isSuccess ? success(recipes) : failure()
    }
}

final class ListingRepositoryTests: XCTestCase {
    
    
    func testGivenAlistingRepositoryWhenMakeARequestThenIsSuccess() {
        let handler = MockHandler()
        
        let repository = SearchRepository(networkClient: mockHttpClient, handler: handler)
        
        let expectation = self.expectation(description: "The response is a success")
        
        repository.getRecipes(for: ["Potatoes"], success: { _ in
            expectation.fulfill()
        }, failure: {
            XCTFail()
        })
        
        waitForExpectations(timeout: 5)
    }
    
    func testGivenAlistingRepositoryWhenMakeARequestThenIsFailure() {
        let handler = MockHandler()
        handler.isSuccess = false
        let repository = SearchRepository(networkClient: mockHttpClient, handler: handler)
        
        let expectation = self.expectation(description: "The response is a success")
        
        repository.getRecipes(for: ["Potatoes"], success: { _ in
            XCTFail()
        }, failure: {
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 5)
    }
}
