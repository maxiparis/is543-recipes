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
    let viewModel: RecipeViewModel

    var body: some Scene {
        WindowGroup {
            RecipesCatalog()
        }
        .modelContainer(container)
        .environment(viewModel)
    }
    
    init() {
        do {
            container = try ModelContainer(for: Recipe.self, Category.self)
        } catch {
            fatalError("""
                Failed to create ModelContainer.
                """)
        }
        
        viewModel = RecipeViewModel(modelContext: container.mainContext)
    }
    
}
