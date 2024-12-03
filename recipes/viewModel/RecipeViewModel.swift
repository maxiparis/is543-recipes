//
//  RecipeViewModel.swift
//  recipes
//
//  Created by Maximiliano París Gaete on 11/30/24.
//
import SwiftUI
import SwiftData

@Observable
class RecipeViewModel {
    
    //MARK: - Class properties

    private var modelContext: ModelContext
    
    var recipes: [Recipe] = []
    var categories: [Category] = []
    
    
    //MARK: - Init

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchData()
        
        if recipes.isEmpty || categories.isEmpty {
            createDefaultData()
            fetchData()
        }
    }
    
    
    //MARK: - Functions

    func fetchData() {
        print("FetchData")
        try? modelContext.save()
        do {
            let recipesDescriptor = FetchDescriptor<Recipe>(sortBy: [SortDescriptor(\.name)])
            recipes = try modelContext.fetch(recipesDescriptor)
            
            let categoriesDescriptor = FetchDescriptor<Category>()
            categories = try modelContext.fetch(categoriesDescriptor)
            
            print("Recipe Ingredients: \(recipes.map { $0.ingredients.map { $0.name } })")
        } catch {
            print("Failed to fetch data.")
        }
    }
    
    func createDefaultData() {
        print("createDefaultData")
        
        //Ingredients
        let completoIngredient1 = Ingredient(name: "Hot Dogs Buns", amount: "2", scale: "units")
        let completoIngredient2 = Ingredient(name: "Hot dogs", amount: "2", scale: "units")
        let completoIngredient3 = Ingredient(name: "Diced Tomatoes", amount: "500", scale: "Gr")
        let completoIngredient4 = Ingredient(name: "Avocado", amount: "2", scale: "units")
        
        let completoIngredients = [completoIngredient1, completoIngredient2, completoIngredient3, completoIngredient4]
        
        //Recipes
        let completo = Recipe(name: "Completo",
                              recipeDescription: """
                                A completo is a Chilean-style hot dog (yes, there is a hot dog under there) in a fresh, soft bun that’s topped with diced onions, chopped tomatoes, ketchup, mustard, and mashed avocado. In Chile, they add lots of mayo to the mix but their mayonnaise is different than ours in the US, so we decided not to use that here.
                                """,
                              cookTime: 30,
                              servings: 1,
                              favorite: true,
                              instructions: """
                                Cook – The first thing you’ll want to do is boil or grill your hot dogs.

                                Slice & Dice – While the hot dogs are cooking, you want to chop your onions and tomatoes, as well as mash-up your avocado.

                                Layer –  When you’re building your completo it’s all about layering in the proper order.

                                First, you’ll put the diced tomatoes and onions on first

                                Next, spread the avocado over the top. This will “seal” them against the hot dog so they’ll stay put while you’re eating it.

                                Then top everything off with ketchup and mustard and you’re all done and ready to enjoy them!

                                """,
                              categories: [], ingredients: completoIngredients
        )
        
        completoIngredients.forEach { $0.recipe = completo }
        
        
        //Categories
        let chilean = Category(title: "Chilean", recipes: [completo])
        
        
        let pastaIngredient = Ingredient(name: "Pasta", amount: "2", scale: "Kg")
        let pasta = Recipe(
            name: "Lasagna",
            recipeDescription: "Description",
            cookTime: 2,
            servings: 2,
            favorite: false,
            instructions: "Instructions",
            categories: [],
            ingredients: [pastaIngredient]
        )
        let italian = Category(title: "Italian", recipes: [pasta])
        
        modelContext.insert(completoIngredient1)
        modelContext.insert(completoIngredient2)
        modelContext.insert(completoIngredient3)
        modelContext.insert(completoIngredient4)
        modelContext.insert(pastaIngredient)
    
        
        modelContext.insert(completo)
        modelContext.insert(pasta)
        
        modelContext.insert(chilean)
        modelContext.insert(italian)
        
        try? modelContext.save()
    }
    
    func eraseAllData() {
        let fetchRequest = FetchDescriptor<Recipe>()
        if let recipes = try? modelContext.fetch(fetchRequest) {
            for recipe in recipes {
                modelContext.delete(recipe)
            }
        }
        
        let fetchRequest2 = FetchDescriptor<Category>()
        if let categories = try? modelContext.fetch(fetchRequest2) {
            for category in categories {
                modelContext.delete(category)
            }
        }
        
        let fetchRequest3 = FetchDescriptor<Ingredient>()
        if let ingredients = try? modelContext.fetch(fetchRequest3) {
            for ingredient in ingredients {
                modelContext.delete(ingredient)
            }
        }
        
        try? modelContext.save()
        
        fetchData()
    }
}
