//
//  RecipeViewModel.swift
//  recipes
//
//  Created by Maximiliano París Gaete on 11/30/24.
//
import SwiftUI
import SwiftData

@Observable
class RecipeViewModel {
    
    //MARK: - Class properties

    private var modelContext: ModelContext
    
    var recipes: [Recipe] = []
    var categories: [Category] = []
    
    
    //MARK: - Init

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchData()
        
        if recipes.isEmpty || categories.isEmpty {
            createDefaultData()
            fetchData()
        }
    }
    
    
    //MARK: - Functions

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
    
    func createDefaultData() {
        print("createDefaultData")
        
        let ingredient = Ingredient(name: "Pasta", amount: 2, scale: "Kg")
        let recipe = Recipe(name: "Lasagna", recipeDescription: "Description", cookTime: 2, servings: 2, favorite: false, instructions: "Instructions", categories: [], ingredients: [ingredient])
        let category = Category(title: "Italian", recipes: [recipe])
        
        recipe.categories.append(category)
        
        modelContext.insert(recipe)
        modelContext.insert(category)
        
        // Save changes
        try? modelContext.save()
    }
    
    func eraseAllData() {
        let fetchRequest = FetchDescriptor<Recipe>()
        if let recipes = try? modelContext.fetch(fetchRequest) {
            // Loop through the fetched objects and delete them
            for recipe in recipes {
                modelContext.delete(recipe)
            }
            
            // Save changes to persist the deletions
        }
        
        let fetchRequest2 = FetchDescriptor<Category>()
        if let categories = try? modelContext.fetch(fetchRequest2) {
            // Loop through the fetched objects and delete them
            for category in categories {
                modelContext.delete(category)
            }
            
            // Save changes to persist the deletions
        }
        try? modelContext.save()
        
        fetchData()
    }
}
