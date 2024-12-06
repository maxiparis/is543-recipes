//
//  Recipe.swift
//  recipes
//
//  Created by Maximiliano París Gaete on 11/29/24.
//
import SwiftUI
import SwiftData
import Foundation

@Model
class Recipe {
    @Attribute(.unique) var id: UUID = UUID()
    var name: String
    var recipeDescription: String
    var imageURL: String
    var cookTime: Int //in minutes
    var servings: Int //for people, eg: 2 servings are for 2 people
    var instructions: String
    var categories: [Category]
    @Relationship(deleteRule: .cascade, inverse: \Ingredient.recipe) var ingredients: [Ingredient] = []
    
    var isFavorite: Bool {
        return categories.contains(where: { $0.title == "Favorites" })
    }
            
    init(name: String, imageURL: String, recipeDescription: String, cookTime: Int, servings: Int, instructions: String, categories: [Category], ingredients: [Ingredient]) {
        self.name = name
        self.imageURL = imageURL
        self.recipeDescription = recipeDescription
        self.cookTime = cookTime
        self.servings = servings
        self.instructions = instructions
        self.categories = categories
        self.ingredients = ingredients
    }
}
