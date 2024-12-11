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
               ingredients: []
        )
        
        isPresented.wrappedValue = false
        dataHandler.createNewRecipe(newRecipe)
    }

}
