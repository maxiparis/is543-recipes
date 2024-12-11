//
//  NewRecipeManager.swift
//  recipes
//
//  Created by Maximiliano París Gaete on 12/11/24.
//

import Foundation
import SwiftUI

@Observable
class NewRecipeManager {
    var dataHandler: DataHandler
    var isPresented: Binding<Bool>
    
    var name: String = ""
    var imageURL: String = ""
    var recipeDescription: String = ""
    var servings: String = ""
    var cookTime: String = ""
    
    var ingredients: [Ingredient] = []
    var newIngredientName = ""
    var newIngredientAmount = ""
    var newIngredientScale = ""
    
    init(dataHandler: DataHandler, isPresented: Binding<Bool>) {
        self.dataHandler = dataHandler
        self._isPresented = isPresented
    }
    
    
    
    var isValid: Bool {
        name.count > 0 &&
        imageURL.count > 0 &&
        recipeDescription.count > 0 &&
        servings.count > 0 &&
        cookTime.count > 0
    }
    
    var isValidIngredient: Bool {
        newIngredientName.count > 0 &&
        newIngredientScale.count > 0 &&
        newIngredientAmount.count > 0
    }
    
    //MARK: - User Intents
    func handleCreateNewRecipe() {
        guard let servings = Int(servings), let cookTime = Int(cookTime) else { print("Creating new recipe FAILED"); return }
        
        let newRecipe = Recipe(name: name,
               imageURL: imageURL,
               recipeDescription: recipeDescription,
               cookTime: cookTime,
               servings: servings,
               instructions: [],
               categories: [],
               ingredients: ingredients
        )
        
        isPresented.wrappedValue = false
        dataHandler.createNewRecipe(newRecipe)
    }
    
    func handleNewIngredient() {
        ingredients.append(Ingredient(name: newIngredientName, amount: newIngredientAmount, scale: newIngredientScale))
        
        newIngredientName = ""
        newIngredientAmount = ""
        newIngredientScale = ""
    }
    
    func deleteIngredient(at offset: IndexSet) {
        if let offset = offset.first {
            ingredients.remove(at: offset)
        }
    }

}
