//
//  AddRecipeManager 2.swift
//  recipes
//
//  Created by Maximiliano París Gaete on 12/11/24.
//


//
//  NewRecipeManager.swift
//  recipes
//
//  Created by Maximiliano París Gaete on 12/11/24.
//

import Foundation
import SwiftUI

@Observable
class EditRecipeManager {
    
    //MARK: - Class properties

    var dataHandler: DataHandler
    var isPresented: Binding<Bool>
    
    var name: String = ""
    var imageURL: String = ""
    var recipeDescription: String = ""
    var servings: String = ""
    var cookTime: String = ""
    
    var allOtherCategories: [Category] {
        dataHandler.otherCategories
    }
    
    var ingredients: [Ingredient] = []
    var newIngredientName = ""
    var newIngredientAmount = ""
    var newIngredientScale = ""
    
    var instructions: [Instruction] = []
    var sortedInstructions: [Instruction] {
        instructions.sorted(by: { $0.order < $1.order })
    }
    var newInstructionTitle = ""
    var newInstructionOrder = ""
    var newInstructionDescription = NEW_INSTRUCTION_DESCRIPTION_PLACEHOLDER
    
    var recipeCategories: [Category] = []
    var categoriesThisRecipeIsNotIn: [Category] {
        allOtherCategories.filter { category in
            !recipeCategories.contains(category)
        }
    }
    
    
    //MARK: - Initializers
    
    init(dataHandler: DataHandler, isPresented: Binding<Bool>, recipe: Recipe) {
        self.dataHandler = dataHandler
        self._isPresented = isPresented
        
        self.name = recipe.name
        self.imageURL = recipe.imageURL
        self.recipeDescription = recipe.recipeDescription
        self.servings = String(recipe.servings)
        self.cookTime = String(recipe.cookTime)
        self.ingredients = recipe.ingredients
        self.instructions = recipe.instructions
        self.recipeCategories = recipe.categories
    }
    
    //MARK: - Computed Properties

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
    
    var isValidInstruction: Bool {
        newInstructionTitle.count > 0 &&
        newInstructionOrder.count > 0 &&
        Int(newInstructionOrder) != nil &&
        newInstructionDescription.count > 0 &&
        newInstructionDescription != NEW_INSTRUCTION_DESCRIPTION_PLACEHOLDER
    }
    
    //MARK: - User Intents
    
    func handleCreateNewRecipe() {
        guard let servings = Int(servings), let cookTime = Int(cookTime) else { print("Creating new recipe FAILED"); return }
        
        let newRecipe = Recipe(name: name,
               imageURL: imageURL,
               recipeDescription: recipeDescription,
               cookTime: cookTime,
               servings: servings,
               instructions: instructions,
               categories: recipeCategories,
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
    
    func handleNewInstruction() {
        guard let order = Int(newInstructionOrder) else { print("Creating new instruction failed."); return }
        instructions.append(Instruction(order: order, title: newInstructionTitle, descriptions: newInstructionDescription))
        
        newInstructionOrder = ""
        newInstructionTitle = ""
        newInstructionDescription = NEW_INSTRUCTION_DESCRIPTION_PLACEHOLDER
    }
    
    func deleteInstruction(at offset: IndexSet) {
        if let offset = offset.first {
            let instruction = sortedInstructions[offset]
            
            instructions.removeAll(where: { $0.id == instruction.id })
        }
    }

    func handleAddCategory(_ category: Category) {
        recipeCategories.append(category)
    }
    
    func deleteCategoryFromRecipe(at offset: IndexSet) {
        if let offset = offset.first {
            recipeCategories.remove(at: offset)
        }
    }
    
    func updateExistingRecipe() {
        
    }
}
