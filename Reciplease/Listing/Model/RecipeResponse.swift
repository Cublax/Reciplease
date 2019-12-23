//
//  Response.swift
//  Reciplease
//
//  Created by Alexandre Quiblier on 10/10/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

// MARK: - RecipeResponse
struct RecipeResponse: Codable, Equatable {
    let q: String
    let from, to: Int
    let hits: [Hit]
    
    // MARK: - Hit
    struct Hit: Codable, Equatable {
        let recipe: Recipe
        let bookmarked, bought: Bool
        
        // MARK: - Recipe
        struct Recipe: Codable, Equatable {
            let label: String
            let image: String
            let yield: Int
            let source: String
            let url: String
            let shareAs: String
            let cautions, ingredientLines: [String]
        }
    }
}
