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
    
    var allAndFavoritesCategories: [Category] {
        dataHandler.allAndFavoritesCategories
    }

    var otherCategories: [Category] {
        dataHandler.otherCategories
    }
    
    var selectedCategory: Category?
    var selectedRecipe: Recipe?
    
    var searchText: String = ""
    var filteredOrderedRecipes: [Recipe] {
        guard let selectedCategory else { return [] }
        
        if searchText.isEmpty {
            return selectedCategory.recipes.sorted(by: {$0.name < $1.name})
        } else {
            return selectedCategory.recipes.filter({ $0.name.contains(searchText)}).sorted(by: {$0.name < $1.name})
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
    
    func handleOnDelete(at offsets: IndexSet) {
        let itemToRemove = filteredOrderedRecipes[offsets.first ?? 0]
        dataHandler.removeRecipeFromCategory(itemToRemove, from: selectedCategory!)
    }
    
    func removeCategory(at offsets: IndexSet) {
        let itemToRemove = otherCategories[offsets.first ?? 0]
        dataHandler.removeCategory(itemToRemove)
    }
    

}
