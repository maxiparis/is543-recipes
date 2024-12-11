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
    var selectedRecipe: Binding<Recipe?>
    
    var allCategories: [Category] {
        dataHandler.categories
    }
    
    var allOtherCategories: [Category] {
        dataHandler.otherCategories
    }
    
    var recipeCategories: [Category] {
        recipe.categories
    }
    
    var categoriesThisRecipeIsNotIn: [Category] {
        allCategories.filter { category in
            !recipe.categories.contains(category)
        }
    }
    
    var isRecipeFavorite: Bool {
        recipe.isFavorite
    }
    var imageURL: String {
        recipe.imageURL
    }
    var instructions: [Instruction] {
        recipe.instructions
    }
    
    var presentAddCategory: Bool = false
    var presentRemoveRecipeConfirmation = false

    
    //MARK: - Init
    
    init(recipe: Recipe, dataHandler: DataHandler, selectedRecipe: Binding<Recipe?>) {
        self.recipe = recipe
        self.dataHandler = dataHandler
        self._selectedRecipe = selectedRecipe
    }
    
    //MARK: - Logic

    func isRecipeInCategory(_ category: Category) -> Bool {
        self.recipe.categories.contains(category)
    }
    
    
    //MARK: - User Intents
    
    func toggleRecipeIsFavorite() {
        dataHandler.toggleFavorite(self.recipe)
    }
    
    func handleAddRecipeToCategory(_ category: Category) {
        dataHandler.addRecipeToCategory(self.recipe, to: category)
    }
    
    func handleRemoveRecipeFromCategory(_ category: Category) {
        dataHandler.removeRecipeFromCategory(self.recipe, from: category)
    }
    
    func handleDeleteRecipe() {
        selectedRecipe.wrappedValue = nil
        dataHandler.deleteRecipe(self.recipe)
    }
}
