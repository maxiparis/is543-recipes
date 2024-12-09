//
//  DataHandler.swift
//  recipes
//
//  Created by Maximiliano París Gaete on 12/6/24.
//

import Foundation
import SwiftData

@Observable
class DataHandler {
    
    //MARK: - Properties

    private var modelContext: ModelContext
    private var defaulRecipes: DefaultRecipesManager
    
    var recipes: [Recipe] = []
    var categories: [Category] = []
    
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
    
    //MARK: - Data Access

    func fetchData() {
        print("FetchData")
        try? modelContext.save()
        do {
            let recipesDescriptor = FetchDescriptor<Recipe>(sortBy: [SortDescriptor(\.name)])
            recipes = try modelContext.fetch(recipesDescriptor)
            
            let categoriesDescriptor = FetchDescriptor<Category>()
            categories = try modelContext.fetch(categoriesDescriptor)
            
//            //Sort "All" category recipes
//            let allCategory = categories.first(where: { $0.title == CategoryNames.All.rawValue })
//            
//            if let allCategory {
//                print("Sorting 'All' category's recipes by name")
//                allCategory.recipes.sort(by: { $0.name < $1.name })
//                
//                print("Recipes in 'All' category in order:")
//                categories.first(where: { $0.title == CategoryNames.All.rawValue })?.recipes.forEach { recipe in
//                    print("\(recipe.name)")
//                }
//                
//                try? modelContext.save()
//            }
            
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
    
    func resetData() {
        eraseAllData()
        defaulRecipes.createDefaultData()
        fetchData()
    }
    
    func handleEraseAllData() {
        eraseAllData()
        fetchData()
    }
    
    func toggleFavorite(_ recipe: Recipe) {
        let favorites = categories.first(where: { $0.title == CategoryNames.Favorites.rawValue })!

        if recipe.isFavorite {
            recipe.categories.removeAll(where: { $0.title == CategoryNames.Favorites.rawValue } )
//            favorites.recipes.removeAll(where: { $0 == recipe })
        } else {
            recipe.categories.append(favorites)
//            favorites.recipes.append(recipe)
        }
        
        try? modelContext.save()
    }
}
