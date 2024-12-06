//
//  RecipeView.swift
//  recipes
//
//  Created by Maximiliano París Gaete on 12/5/24.
//
import SwiftUI

struct RecipeDetailsView: View {
    var recipe: Recipe
    
    var body: some View {
            List {
                Section {
                    Text(recipe.recipeDescription)
                        .font(.title3)
                }
                
                
                
                Section {
                    Text("Ingredients")
                        .font(.title)
                    if (recipe.ingredients.isEmpty) {
                        Text("No Ingredients")
                    } else {
                        ForEach(recipe.ingredients) { ing in
                            Text("\(ing.name) - \(ing.amount) \(ing.scale)")
                        }
                    }
                }
                
                Section {
                    Text("Instructions")
                        .font(.title)
                    
                    Text(recipe.instructions).font(.title3)
                    
                }
            }
            .navigationTitle(recipe.name)
    }
}
