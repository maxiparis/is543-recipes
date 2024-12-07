//
//  RecipeViewModel.swift
//  recipes
//
//  Created by Maximiliano París Gaete on 11/30/24.
//
import SwiftUI
import SwiftData

@Observable
class RecipeCategoriesManager {
    
    //MARK: - Class properties
    private(set) var dataHandler: DataHandler
    var categories: [Category] {
        dataHandler.categories
    }
    
    var selectedCategory: Category?
    var selectedRecipe: Recipe? {
        didSet {
            if let selectedRecipe {
                print("selectedRecipe: \(selectedRecipe), ingredients: \(selectedRecipe.ingredients)")
            }
        }
    }
    
    
    //MARK: - Init

    init(modelContext: ModelContext) {
        self.dataHandler = DataHandler(modelContext: modelContext)
    }
    
    
    //MARK: - User Intents
    func resetData() {
        dataHandler.resetData()
    }
    
    func handleEraseAllData() {
        dataHandler.handleEraseAllData()
    }
    

}
