//
//  FavoriteListingRepositoryTests.swift
//  RecipleaseTests
//
//  Created by Alexandre Quiblier on 13/12/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import XCTest
@testable import Reciplease

final class FavoriteRepositoryTests: XCTestCase {
    
    func testGivenAListingFavoriteRepositoryWhenMakeARequestInCoreDataThenIsCorrectlyReturned() {
        let stack = CoreDataStack(modelName: "Model",
                                  type: .test)
        let repository = FavoriteRepository(stack: stack)
        
        let expectation = self.expectation(description: "The response is a success")
        
        repository.getRecipes(for: ["Toto"], success: { _ in
            expectation.fulfill()
        }, failure: {
            XCTFail()
        })
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
}


