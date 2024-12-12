//
//  AddEditRecipeView 2.swift
//  recipes
//
//  Created by Maximiliano París Gaete on 12/11/24.
//


//
//  AddNewRecipeView.swift
//  recipes
//
//  Created by Maximiliano París Gaete on 12/11/24.
//

import SwiftUI

struct EditRecipeView: View {
    @Bindable var editRecipeManager: EditRecipeManager
    
    var body: some View {
        Section(header: Text("Recipe details")) {
            HStack {
                Text("Recipe Name")
                TextField("Recipe Name", text: $editRecipeManager.name)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.trailing)
            }
            
            HStack {
                Text("Image URL")
                Spacer(minLength: 20)
                TextField("Image URL", text: $editRecipeManager.imageURL)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.URL)
            }
        }
        
        Section(header: Text("Description")) {
            TextEditor(text: $editRecipeManager.recipeDescription)
                .frame(minHeight: 80)
        }
        
        Section(header: Text("Additional information")) {
            HStack {
                Text("Servings")
                TextField("Servings", text: $editRecipeManager.servings)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
            }
            
            HStack {
                Text("Cook time (in minutes)")
                TextField("Cook time (in minutes)", text: $editRecipeManager.cookTime)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
            }
        }
        
        Section(header: Text("Ingredients")) {
            ForEach(editRecipeManager.ingredients) { ingredient in
                Text("\(ingredient.name) - \(ingredient.amount) \(ingredient.scale)")
            }
            .onDelete(perform: editRecipeManager.deleteIngredient)
            
            HStack {
                TextField("Name", text: $editRecipeManager.newIngredientName)
                TextField("Amount", text: $editRecipeManager.newIngredientAmount)
                TextField("Scale", text: $editRecipeManager.newIngredientScale)
                Button(action: {
                    editRecipeManager.handleNewIngredient()
                }) {
                    Image(systemName: "plus.circle")
                        .tint(.green)
                }
                .disabled(!editRecipeManager.isValidIngredient)
            }
        }
        
        Section(header: Text("Instructions")) {
            ForEach(editRecipeManager.sortedInstructions) { instruction in
                VStack(alignment: .leading, spacing: 15) {
                    Text("\(instruction.order) - \(instruction.title)")
                    Text(instruction.descriptions)
                }
            }
            .onDelete(perform: editRecipeManager.deleteInstruction)
            
            VStack(alignment: .leading) {
                HStack {
                    TextField("Order", text: $editRecipeManager.newInstructionOrder)
                    TextField("Title", text: $editRecipeManager.newInstructionTitle)
                    Button(action: {
                        editRecipeManager.handleNewInstruction()
                    }) {
                        Image(systemName: "plus.circle")
                            .tint(.green)
                    }
                    .disabled(!editRecipeManager.isValidInstruction)
                }
                 
                TextEditor(text: $editRecipeManager.newInstructionDescription)
                    .frame(minHeight: 80)
            }
        }
        
        Section(header: Text("Categories"), footer: Text("Swipe left to delete an added category")) {
            ForEach(editRecipeManager.recipeCategoriesExcepAllAndFavs) { category in
                Text("\(category.emoji) \(category.title)")
            }
            .onDelete(perform: withAnimation { editRecipeManager.deleteCategoryFromRecipe })
                        
            ForEach(editRecipeManager.categoriesThisRecipeIsNotIn) { category in
                Button {
                    withAnimation {
                        editRecipeManager.handleAddCategory(category)
                    }
                } label: {
                    Label("\(category.emoji) \(category.title)", systemImage: "plus")
                }
            }
        }
        
        
        Button {
//            editRecipeManager.updateExistingRecipe()
        } label: {
            Text("Update recipe")
        }
        .disabled(!editRecipeManager.isValid)
    }
}
