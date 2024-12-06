//
//  RecipeDetailsManager.swift
//  recipes
//
//  Created by Maximiliano París Gaete on 12/6/24.
//

import Foundation

@Observable
class RecipeDetailsManager {
    var recipe: Recipe
    
    var isRecipeFavorite: Bool {
        recipe.isFavorite
    }
    
    var imageURL: String {
        recipe.imageURL
    }
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
}
