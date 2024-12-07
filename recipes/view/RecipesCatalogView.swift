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
                List(selection: $viewModel.selectedCategory) {
                    Section {
                        ForEach(viewModel.allAndFavoritesCategories.sorted(by: { $0.title < $1.title })) { category in
                            Text(category.title)
                                .tag(category)
                        }
                    }
                    
                    Section {
                        ForEach(viewModel.otherCategories) { category in
                            Text(category.title)
                                .tag(category)
                        }
                    }
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
                if selectedCategory.recipes.isEmpty {
                    Text("There are no recipes in this category")
                        .listStyle(.insetGrouped)
                        .navigationTitle("Recipes")
                } else {
                    List(selectedCategory.recipes, id: \.self, selection: $viewModel.selectedRecipe) { recipe in
                        Text(recipe.name)
                    }
                    .listStyle(.insetGrouped)
                    .navigationTitle("Recipes")
                }
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



