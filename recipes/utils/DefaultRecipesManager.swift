//
//  DefaultRecipesManager.swift
//  recipes
//
//  Created by Maximiliano París Gaete on 12/5/24.
//

import Foundation
import SwiftData

enum CategoryNames: String {
    case All, Favorites, Argentinian, Chilean, Paraguayan, Peruvian, American
}

/// This struct's responsability is to create, and save to the `ModelContext` the initial list of `recipes` ,`categories` and `ingredients`.
struct DefaultRecipesManager {
    
    //MARK: - Properties
    
    var modelContext: ModelContext
    var categories: [Category] = []
    
    
    //MARK: - Init
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        generateInitialCategories()
    }
    
    
    //MARK: - Create Default Data

    func createDefaultData() {
        //Completo
        recipeGenerator(
            ingredients: [Ingredient(name: "🥖 Hot Buns", amount: "2", scale: "units"),
                          Ingredient(name: "🌭 Hot dogs", amount: "2", scale: "units"),
                          Ingredient(name: "🍅 Diced Tomatoes", amount: "500", scale: "Gr"),
                          Ingredient(name: "🥑 Avocado", amount: "2", scale: "units")],
            recipe: Recipe(
                name: "Completo",
                imageURL: "https://upload.wikimedia.org/wikipedia/commons/e/e0/Completo_italiano.jpg",
                recipeDescription: """
                   A completo is a Chilean-style hot dog (yes, there is a hot dog under there) in a fresh, soft bun that’s topped with diced onions, chopped tomatoes, ketchup, mustard, and mashed avocado. In Chile, they add lots of mayo to the mix but their mayonnaise is different than ours in the US, so we decided not to use that here.
                   """,
                cookTime: 30,
                servings: 1,
                instructions: """
                   Cook – The first thing you’ll want to do is boil or grill your hot dogs.
                   
                   Slice & Dice – While the hot dogs are cooking, you want to chop your onions and tomatoes, as well as mash-up your avocado.
                   
                   Layer –  When you’re building your completo it’s all about layering in the proper order.
                   
                   First, you’ll put the diced tomatoes and onions on first
                   
                   Next, spread the avocado over the top. This will “seal” them against the hot dog so they’ll stay put while you’re eating it.
                   
                   Then top everything off with ketchup and mustard and you’re all done and ready to enjoy them!
                   
                   """,
                   categories: [],
                   ingredients: []
              ),
            categories: getCategories(titles: [.Favorites, .Chilean])
        )
        
        
        //Pan con palta
        recipeGenerator(
            ingredients: [
                Ingredient(name: "Avocado", amount: "1", scale: "unit"),
                Ingredient(name: "Allulla", amount: "1", scale: "unit")
            ],
            recipe: Recipe(
                name: "Pan con Palta",
                imageURL: "https://cloudfront-us-east-1.images.arcpublishing.com/copesa/XTTMO6KU3FBHJOXSFBBT2E7JGE.jpg",
                recipeDescription: "A chilean classic",
                cookTime: 10,
                servings: 1,
                instructions: "Some instructions",
                categories: [],
                ingredients: []),
            categories: getCategories(titles: [.Chilean])
        )
        
        
        //Argentinian Empanadas
        recipeGenerator(
            ingredients: [
                Ingredient(name: "Medium Potatoes", amount: "2", scale: "units"),
                Ingredient(name: "Onions", amount: "2", scale: "units"),
                Ingredient(name: "Ground Beef", amount: "1", scale: "pound"),
                Ingredient(name: "Empanada pastry rounds", amount: "24", scale: "units"),
                Ingredient(name: "Egg", amount: "1", scale: "unit")
            ],
            recipe: Recipe(
                name: "Argentinian Beef Empanadas",
                imageURL: "https://cdn.apartmenttherapy.info/image/upload/f_jpg,q_auto:eco,c_fill,g_auto,w_1500,ar_4:3/k%2FPhoto%2FRecipes%2F2024-02-empanadas%2Fempanadas-515_1",
                recipeDescription: "This authentic empanada recipe is for Argentinian beef empanadas filled with a savory and delicious mixture of ground beef, hard-cooked eggs, green olives, and potatoes. These classic empanadas are ubiquitous all over Argentina.",
                cookTime: 90,
                servings: 12,
                instructions: """
                Place potatoes in a large pot and cover with water; bring to a boil. Reduce heat to medium-low and simmer until barely tender, about 8 minutes. Drain. Once cool enough to handle, peel and cut into cubes. Set aside.

                Meanwhile, melt butter in a large skillet and cook onion and green onions until softened, about 5 minutes. Add bell pepper and cook for 3 minutes. Add ground beef; cook and stir until beef is browned, about 5 minutes. Season with paprika, cayenne pepper, and salt.

                Remove beef mixture from heat; add potatoes and olives. Stir in chopped hard-cooked eggs; set filling aside to cool, about 20 minutes.

                Preheat the oven to 425 degrees F (220 degrees C). Line 2 baking sheets with aluminum foil and lightly grease with olive oil.

                Place an empanada pastry round on a flat surface and lightly wet the edges with warm water. Put a large tablespoon of cooled filling in the center and fold dough over. Seal edges by pressing with a fork. Repeat with remaining rounds and filling. Transfer empanadas to the prepared baking sheets and brush with beaten egg.

                Bake in the preheated oven until golden brown, 15 to 20 minutes.
                """,
                categories: [],
                ingredients: []
            ),
            categories: getCategories(titles: [.Favorites, .Argentinian]))
        
        try? modelContext.save()
    }
    
    mutating func generateInitialCategories() {
        self.categories = [
            Category(title: CategoryNames.All.rawValue, emoji: "🍽️"),
            Category(title: CategoryNames.Favorites.rawValue, emoji: "⭐️"),
            Category(title: CategoryNames.Chilean.rawValue, emoji: "🇨🇱"),
            Category(title: CategoryNames.Argentinian.rawValue, emoji: "🇦🇷"),
            Category(title: CategoryNames.Paraguayan.rawValue, emoji: "🇵🇾"),
            Category(title: CategoryNames.Peruvian.rawValue, emoji: "🇵🇪"),
            Category(title: CategoryNames.American.rawValue, emoji: "🇺🇸")
        ]
    }

    
    //MARK: - Helper Functions
    
    func recipeGenerator(ingredients: [Ingredient], recipe: Recipe, categories: [Category]) {
        let allCategory = self.categories.first(where: { $0.title == CategoryNames.All.rawValue })
        
        recipe.ingredients = ingredients
        recipe.categories = categories
        recipe.categories.append(allCategory!)
        modelContext.insert(recipe)

        
        //each ingredient's recipe will be the recipe
//        for ingredient in ingredients {
//            print("\(ingredient.name)\'s recipe is \(recipe.name) ")
//            ingredient.recipe = recipe
//            modelContext.insert(ingredient)
//        }
        
        //recipe's ingredients will be the ingredients
//        recipe.ingredients = ingredients
//        print("\(recipe.name)'s ingredients are: \(recipe.ingredients)")
//        modelContext.insert(recipe)
        
        //recipe's categories will be the categories
//        recipe.categories = categories
        
        //categories' recipes will be added to the recipe
//        for category in categories {
//            category.recipes.append(recipe)
//            modelContext.insert(category)
//        }
    }
    
    func getCategories(titles: [CategoryNames]) -> [Category] {
        var titlesAsString: [String] = []
        
        for title in titles {
            titlesAsString.append(title.rawValue)
        }
        
        return self.categories.filter { titlesAsString.contains($0.title) }
    }
}
