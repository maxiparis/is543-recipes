//
//  ContentView.swift
//  recipes
//
//  Created by Maximiliano París Gaete on 11/29/24.
//
 
import SwiftUI
import SwiftData

struct RecipesCatalogView: View {
    @Bindable var viewModel: RecipeCategoriesManager
    
    var body: some View {
        NavigationSplitView {
            ZStack(alignment: .bottom) {
                List(viewModel.categories, id: \.self, selection: $viewModel.selectedCategory) { category in
                    Text(category.title)
                }
                VStack {
                    Button("Reset Data") {
                        viewModel.resetData()
                    }
                    
                    Button("Erase all data") {
                        viewModel.handleEraseAllData()
                    }
                }
            }
            .navigationTitle("Categories")
        } content: {
            if let selectedCategory = viewModel.selectedCategory {
                List(selectedCategory.recipes, id: \.self, selection: $viewModel.selectedRecipe) { recipe in
                    Text(recipe.name)
                }
                .listStyle(.insetGrouped)
                .navigationTitle("Recipes")
            } else {
                Text("Select a category")
                .navigationTitle("Recipes")
            }
        } detail: {
            if let selectedRecipe = viewModel.selectedRecipe {
                withAnimation {
                    RecipeDetailsView(recipeManager: RecipeDetailsManager(recipe: selectedRecipe, dataHandler: viewModel.dataHandler))
                }
            } else {
                Text("Select a recipe.")
            }
        }
    }
}



