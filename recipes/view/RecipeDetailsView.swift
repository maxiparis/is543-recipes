//
//  RecipeView.swift
//  recipes
//
//  Created by Maximiliano París Gaete on 12/5/24.
//
import SwiftUI

struct RecipeDetailsView: View {
    //TODO: this should have a ViewModel
    var recipeManager: RecipeDetailsManager
    
    var body: some View {
            List {
                AsyncImage(url: URL(string: recipeManager.imageURL)) { image in
                            image
                                .resizable()
                                .cornerRadius(20)
                                .scaledToFit()
                        } placeholder: {
                            HStack {
                                Spacer()
                                ProgressView()
                                Spacer()
                            }
                }
                .listRowBackground(Color.clear)
                
                
                Section(header: Text("Description").font(.title3)){
                    Text(recipeManager.recipe.recipeDescription)
                        .font(.title3)
                }
                
                Section(header: Text("Details").font(.title3)) {
                    HStack {
                        Label("Servings", systemImage: "person")
                        Spacer()
                        Text("\(recipeManager.recipe.servings)")
                    }
                    
                    HStack {
                        Label("Cook Time", systemImage: "clock")
                        Spacer()
                        Text("\(recipeManager.recipe.cookTime) minutes")
                    }
                }
                
                Section(header: Text("Ingredients").font(.title3)) {
                    
                    if (recipeManager.recipe.ingredients.isEmpty) {
                        Text("No Ingredients")
                    } else {
                        ForEach(recipeManager.recipe.ingredients) { ing in
                            Text("\(ing.name) - \(ing.amount) \(ing.scale)")
                        }
                    }
                }
                
                Section(header: Text("Instructions").font(.title3)) {
                    Text(recipeManager.recipe.instructions)
                }
                
                Section(header: Text("Categories").font(.title3)) {
                    ForEach(recipeManager.recipe.categories, id: \.self) { category in
                        Text("\(category.emoji) \(category.title)")
                    }
                }
            }
            .navigationTitle(recipeManager.recipe.name)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: recipeManager.isRecipeFavorite ? "star.fill" : "star")
                        .contentTransition(.symbolEffect(.replace))
                        .foregroundStyle(.yellow)
                        .onTapGesture {
                            recipeManager.toggleRecipeIsFavorite()
                        }
                }
            }
    }
}

//#Preview {
//    var ingredients = [Ingredient(name: "🥖 Hot Buns", amount: "2", scale: "units"),
//                      Ingredient(name: "🌭 Hot dogs", amount: "2", scale: "units"),
//                      Ingredient(name: "🍅 Diced Tomatoes", amount: "500", scale: "Gr"),
//                      Ingredient(name: "🥑 Avocado", amount: "2", scale: "units")
//    ]
//    
//    var categories = [Category(title: "Favorites", emoji: "⭐️"), Category(title: "Chilean", emoji: "🇨🇱")]
//    
//    RecipeDetailsView(recipeManager: RecipeDetailsManager(recipe: Recipe(
//        name: "Completo",
//        imageURL: "https://upload.wikimedia.org/wikipedia/commons/e/e0/Completo_italiano.jpg",
//        recipeDescription: """
//           A completo is a Chilean-style hot dog (yes, there is a hot dog under there) in a fresh, soft bun that’s topped with diced onions, chopped tomatoes, ketchup, mustard, and mashed avocado. In Chile, they add lots of mayo to the mix but their mayonnaise is different than ours in the US, so we decided not to use that here.
//           """,
//        cookTime: 30,
//        servings: 1,
//        instructions: """
//           Cook – The first thing you’ll want to do is boil or grill your hot dogs.
//           
//           Slice & Dice – While the hot dogs are cooking, you want to chop your onions and tomatoes, as well as mash-up your avocado.
//           
//           Layer –  When you’re building your completo it’s all about layering in the proper order.
//           
//           First, you’ll put the diced tomatoes and onions on first
//           
//           Next, spread the avocado over the top. This will “seal” them against the hot dog so they’ll stay put while you’re eating it.
//           
//           Then top everything off with ketchup and mustard and you’re all done and ready to enjoy them!
//           
//           """,
//        categories: categories,
//        ingredients: ingredients
//    ), dataHandler: )
//    )
//}
//
