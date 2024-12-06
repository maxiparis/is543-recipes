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
    private var modelContext: ModelContext
    private var defaulRecipes: DefaultRecipesManager
    
    
    var recipes: [Recipe] = []
    var categories: [Category] = []
    
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
        self.modelContext = modelContext
        self.defaulRecipes = DefaultRecipesManager(modelContext: modelContext)
        
        fetchData()
        
        if recipes.isEmpty && categories.isEmpty {
            defaulRecipes.createDefaultData()
            fetchData()
        }
    }
    
    
    //MARK: - User Intents
    func resetData() {
        eraseAllData()
        defaulRecipes.createDefaultData()
        fetchData()
    }
    
    func handleEraseAllData() {
        eraseAllData()
        fetchData()
    }

    
    //MARK: - Data Access

    func fetchData() {
        print("FetchData")
        try? modelContext.save()
        do {
            let recipesDescriptor = FetchDescriptor<Recipe>(sortBy: [SortDescriptor(\.name)])
            recipes = try modelContext.fetch(recipesDescriptor)
            
            let categoriesDescriptor = FetchDescriptor<Category>()
            categories = try modelContext.fetch(categoriesDescriptor)
        } catch {
            print("Failed to fetch data.")
        }
    }
    
    func eraseAllData() {
        let fetchRequest = FetchDescriptor<Recipe>()
        if let recipes = try? modelContext.fetch(fetchRequest) {
            for recipe in recipes {
                modelContext.delete(recipe)
            }
        }
        
        let fetchRequest2 = FetchDescriptor<Category>()
        if let categories = try? modelContext.fetch(fetchRequest2) {
            for category in categories {
                modelContext.delete(category)
            }
        }
        
        let fetchRequest3 = FetchDescriptor<Ingredient>()
        if let ingredients = try? modelContext.fetch(fetchRequest3) {
            for ingredient in ingredients {
                modelContext.delete(ingredient)
            }
        }
        
        try? modelContext.save()
    }
}
