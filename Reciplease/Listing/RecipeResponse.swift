//
//  Response.swift
//  Reciplease
//
//  Created by Alexandre Quiblier on 10/10/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

// MARK: - RecipeResponse
struct RecipeResponse: Codable {
    let q: String
    let from, to: Int
    let more: Bool
    let count: Int
    let hits: [Hit]

    // MARK: - Hit
    struct Hit: Codable {
        let recipe: Recipe
        let bookmarked, bought: Bool

        // MARK: - Recipe
        struct Recipe: Codable {
            let uri: String
            let label: String
            let image: String
            let source: String
            let url: String
            let shareAs: String
            let yield: Int
            let healthLabels, cautions, ingredientLines: [String]
            let ingredients: [Ingredient]

            // MARK: - Ingredient
            struct Ingredient: Codable {
                let text: String
                let quantity: Double
                let measure: String?
                let food: String
                let weight: Double
            }
        }
    }
}
