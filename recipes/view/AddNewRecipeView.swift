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
            }
            .onDelete(perform: newRecipeManager.deleteIngredient)
            
            HStack {
                TextField("Name", text: $newRecipeManager.newIngredientName)
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
        
        Section(header: Text("Instructions")) {
            ForEach(newRecipeManager.sortedInstructions) { instruction in
                VStack(alignment: .leading, spacing: 15) {
                    Text("\(instruction.order) - \(instruction.title)")
                    Text(instruction.descriptions)
                }
            }
            .onDelete(perform: newRecipeManager.deleteInstruction)
            
            VStack(alignment: .leading) {
                HStack {
                    TextField("Order", text: $newRecipeManager.newInstructionOrder)
                    TextField("Title", text: $newRecipeManager.newInstructionTitle)
                    Button(action: {
                        newRecipeManager.handleNewInstruction()
                    }) {
                        Image(systemName: "plus.circle")
                            .tint(.green)
                    }
                    .disabled(!newRecipeManager.isValidInstruction)
                }
                 
                TextEditor(text: $newRecipeManager.newInstructionDescription)
            }
        }
        
        Section(header: Text("Categories"), footer: Text("Swipe left to delete an added category")) {
            ForEach(newRecipeManager.recipeCategories) { category in
                Text("\(category.emoji) \(category.title)")
            }
            .onDelete(perform: withAnimation { newRecipeManager.deleteCategoryFromRecipe })
                        
            ForEach(newRecipeManager.categoriesThisRecipeIsNotIn) { category in
                Button {
                    withAnimation {
                        newRecipeManager.handleAddCategory(category)
                    }
                } label: {
                    Label("\(category.emoji) \(category.title)", systemImage: "plus")
                }
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
