//
//  ListingResponseHandlerTests.swift
//  RecipleaseTests
//
//  Created by Alexandre Quiblier on 13/12/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import XCTest
@testable import Reciplease

final class ListingResponseHandlerTests: XCTestCase {
    
    func testGivenAListingResponseHandlerWhenEnterACorrectResultThenIsSuccess() {
        let result = Result<RecipeResponse>.success(RecipeResponse(q: "1",
                                                                   from: 1,
                                                                   to: 1,
                                                                   hits: [RecipeResponse.Hit(recipe: RecipeResponse.Hit.Recipe(label: "1",
                                                                                                                               image: "1",
                                                                                                                               yield: 1,
                                                                                                                               source: "1",
                                                                                                                               url: "1",
                                                                                                                               shareAs: "1",
                                                                                                                               cautions: ["1"],
                                                                                                                               ingredientLines: ["1"]),
                                                                                             bookmarked: true,
                                                                                             bought: true)]))
        
        let response: HTTPResponse<RecipeResponse> = HTTPResponse<RecipeResponse>(result: result,
                                                                                  originalData: nil,
                                                                                  statusCode: 200)
        
        let handler = RecipeResponseHandler()
        
        let expectedResult = [Recipe(name: "1",
                                     urlImage: "1",
                                     urlRecipe: "1",
                                     source: "1",
                                     servings: 1,
                                     ingredient: ["1"])]
        
        handler.process(response, success: { result in
            XCTAssertEqual(result, expectedResult)
        }, failure: {
            XCTFail()
        })
    }
    
    func testGivenAListingResponseHandlerWhenEnterAWrongResultThenIsFail() {
        
        let error = NSError()
        
        let result = Result<RecipeResponse>.failure(error)
        
        
        let response: HTTPResponse<RecipeResponse> = HTTPResponse<RecipeResponse>(result: result,
                                                                                  originalData: nil,
                                                                                  statusCode: 200)
        
        let handler = RecipeResponseHandler()
        
        let expectation = self.expectation(description: "Fail")
        
        handler.process(response, success: { result in
            XCTFail()
        }, failure: {
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 5)
    }
    
    
}
