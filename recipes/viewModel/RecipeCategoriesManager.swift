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
        categories.filter { $0.title == CategoryNames.All.rawValue || $0.title == CategoryNames.Favorites.rawValue }
    }

    var otherCategories: [Category] {
        let favoritesAndAllTitles = Set([CategoryNames.All.rawValue, CategoryNames.Favorites.rawValue])
        return categories.filter { !favoritesAndAllTitles.contains($0.title) }
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
