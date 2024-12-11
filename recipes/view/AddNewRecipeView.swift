//
//  AddNewRecipeView.swift
//  recipes
//
//  Created by Maximiliano París Gaete on 12/11/24.
//

import SwiftUI

struct AddNewRecipeView: View {
    @Bindable var newRecipeManager: NewRecipeManager
    
    var body: some View {
        Section(header: Text("Recipe details")) {
            TextField("Recipe Name", text: $newRecipeManager.name)
            TextField("Image URL", text: $newRecipeManager.imageURL)
                .keyboardType(.URL)
        }
        
        Section(header: Text("Description")) {
            TextEditor(text: $newRecipeManager.recipeDescription)
        }
        
        Section(header: Text("Additional information")) {
            TextField("Servings", text: $newRecipeManager.servings)
                .keyboardType(.numberPad)
            TextField("Cook time (in minutes)", text: $newRecipeManager.cookTime)
                .keyboardType(.numberPad)
        }
        
        Section(header: Text("Ingredients")) {
            ForEach(newRecipeManager.ingredients) { ingredient in
                Text("\(ingredient.name) - \(ingredient.amount) \(ingredient.scale)")
            }.onDelete(perform: newRecipeManager.deleteIngredient)
            
            HStack {
                TextField("New Ingredient", text: $newRecipeManager.newIngredientName)
                TextField("Amount", text: $newRecipeManager.newIngredientAmount)
                TextField("Scale", text: $newRecipeManager.newIngredientScale)
                Button(action: {
                    newRecipeManager.handleNewIngredient()
                }) {
                    Image(systemName: "plus.circle")
                        .tint(.green)
                }
                .disabled(!newRecipeManager.isValidIngredient)
            }
        }
        
        
        
        Button {
            newRecipeManager.handleCreateNewRecipe()
        } label: {
            Text("Create new recipe")
        }
        .disabled(!newRecipeManager.isValid)
    }
}
