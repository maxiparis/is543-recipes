//
//  recipesApp.swift
//  recipes
//
//  Created by Maximiliano París Gaete on 11/29/24.
//

import SwiftUI
import SwiftData

@main
struct recipesApp: App {
    
    let container: ModelContainer
    var viewModel: RecipeCategoriesManager

    var body: some Scene {
        WindowGroup {
            RecipesCatalogView(viewModel: viewModel)
        }
        .modelContainer(container)
//        .environment(viewModel)
    }
    
    init() {
        do {
            container = try ModelContainer(for: Recipe.self, Category.self, Ingredient.self)
        } catch {
            fatalError("""
                Failed to create ModelContainer.
                """)
        }
        
        viewModel = RecipeCategoriesManager(modelContext: container.mainContext)
    }
    
}
