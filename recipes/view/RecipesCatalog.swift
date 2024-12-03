//
//  ContentView.swift
//  recipes
//
//  Created by Maximiliano París Gaete on 11/29/24.
//
 
import SwiftUI
import SwiftData

struct RecipesCatalog: View {
    @Environment(RecipeViewModel.self) private var viewModel
    @State private var selectedCategory: Category?
    @State private var selectedRecipe: Recipe? {
        didSet {
            if let selectedRecipe {
                print("selectedRecipe: \(selectedRecipe), ingredients: \(selectedRecipe.ingredients)")
            }
        }
    }
    
    var body: some View {
        NavigationSplitView {
            ZStack(alignment: .bottom) {
                List(viewModel.categories, id: \.self, selection: $selectedCategory) { category in
                    Text(category.title)
                }
                VStack {
                    Button("Reset Data") {
                        viewModel.eraseAllData()
                        viewModel.createDefaultData()
                        viewModel.fetchData()
                    }
                    
                    Button("Erase all data") {
                        viewModel.eraseAllData()
                        viewModel.fetchData()
                    }
                }
            }
            .navigationTitle("Categories")
        } content: {
            if let selectedCategory {
                List(selectedCategory.recipes, id: \.self, selection: $selectedRecipe) { recipe in
                    Text(recipe.name)
                }
            } else {
                Text("Select a category")
            }
        } detail: {
            if let selectedRecipe {
                withAnimation {
                    RecipeView(recipe: selectedRecipe)
                }
            } else {
                Text("Select a recipe.")
            }
        }
    }
}


struct RecipeView: View {
    var recipe: Recipe
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Text(recipe.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text(recipe.recipeDescription)
                    .font(.title3)
                
                
                Text("Ingredients")
                    .font(.title)
                
                List {
                    ForEach(recipe.ingredients) { ingredient in
                        Text(ingredient.name)
                    }
                }
                
                if (recipe.ingredients.isEmpty) {
                    Text("No Ingredients")
                } else {
                    ForEach(recipe.ingredients) { ing in
                        Text("\(ing.name) - \(ing.amount) \(ing.scale)")
                    }
                    
                }
                
                Text("Instructions")
                    .font(.title)
                
                Text(recipe.instructions).font(.title3)
                
                Spacer()
            }
        }
        .padding()
    }
}
