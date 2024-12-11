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
        Section {
            TextField("Recipe Name", text: $newRecipeManager.name)
            TextField("Image URL", text: $newRecipeManager.imageURL)
                .keyboardType(.URL)
        }
        
        Section(header: Text("Description")) {
            TextEditor(text: $newRecipeManager.recipeDescription)
        }
        
        Section() {
            TextField("Servings", text: $newRecipeManager.servings)
                .keyboardType(.numberPad)
            TextField("Cook time (in minutes)", text: $newRecipeManager.cookTime)
                .keyboardType(.numberPad)
        }
        
        Button {
            //TODO:
        } label: {
            Text("Create new recipe")
        }
        //TODO: disable only when all attributes are ready
    }
}
