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
                            Text("\(category.emoji)  \(category.title)")
                                .tag(category)
                        }
                    }
                    
                    Section {
                        ForEach(viewModel.otherCategories) { category in
                            Text("\(category.emoji)  \(category.title)")
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
                    List {
                        Text("There are no recipes in this category")
                            .listRowBackground(Color.clear)
                    }
                    .listStyle(.insetGrouped)
                    .navigationTitle(selectedCategory.title)
                } else {
                    List(selection: $viewModel.selectedRecipe) {
                        if selectedCategory.title != CategoryNames.All.rawValue {
                            ForEach(viewModel.filteredOrderedRecipes, id: \.self) { recipe in
                                Text(recipe.name)
                            }
                            .onDelete(perform: viewModel.handleOnDelete)
                        } else {
                            ForEach(viewModel.filteredOrderedRecipes, id: \.self) { recipe in
                                Text(recipe.name)
                            }
                        }
                        
                            
                    }
                    .listStyle(.insetGrouped)
                    .searchable(text: $viewModel.searchText)
                    .navigationTitle(selectedCategory.title)
                    .toolbar {
                        if selectedCategory.title != CategoryNames.All.rawValue {
                            EditButton()
                        }
                    }
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



