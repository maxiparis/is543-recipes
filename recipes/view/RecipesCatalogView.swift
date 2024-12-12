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
                    .onDelete(perform: viewModel.removeCategory)
                }
            }
            .navigationTitle("Categories")
            .toolbar {
                ToolbarItemGroup {
                    Button {
                        viewModel.presentAddNewCategory = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    EditButton()
                }
            }
            .sheet(isPresented: $viewModel.presentAddNewCategory) {
                AddNewPickerView(categoriesManager: viewModel)
            }
        } content: {
            if let selectedCategory = viewModel.selectedCategory {
                if selectedCategory.recipes.isEmpty {
//                    var _ = print("CATEGORY LIST RERENDERED")
                    List {
                        Text("There are no recipes in this category")
                            .listRowBackground(Color.clear)
                    }
                    .listStyle(.insetGrouped)
                    .navigationTitle(selectedCategory.title)
                } else {
                    List(selection: $viewModel.selectedRecipe) {
//                        var _ = print("CATEGORY LIST RERENDERED")
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
                    RecipeDetailsView(recipeManager: RecipeDetailsManager(recipe: selectedRecipe, dataHandler: viewModel.dataHandler, selectedRecipe: $viewModel.selectedRecipe))
                }
            } else {
                Text("Select a recipe.")
            }
        }
    }
}
