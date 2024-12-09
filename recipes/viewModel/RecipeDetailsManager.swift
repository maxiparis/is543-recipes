//
//  RecipeDetailsManager.swift
//  recipes
//
//  Created by Maximiliano París Gaete on 12/6/24.
//

import Foundation
import SwiftData
import SwiftUI

@Observable
class RecipeDetailsManager {
    
    //MARK: - Properties
    private var dataHandler: DataHandler
    var recipe: Recipe
    
    var isRecipeFavorite: Bool {
        recipe.isFavorite
    }
    var imageURL: String {
        recipe.imageURL
    }
    var instructions: [Instruction] {
        recipe.instructions
    }

    
    //MARK: - Init
    
    init(recipe: Recipe, dataHandler: DataHandler) {
        self.recipe = recipe
        self.dataHandler = dataHandler
    }
    
    
    //MARK: - User Intents
    
    func toggleRecipeIsFavorite() {
        dataHandler.toggleFavorite(self.recipe)
    }
}
