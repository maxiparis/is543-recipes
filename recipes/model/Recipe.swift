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
    var cookTime: Int //in minutes
    var servings: Int //for people, eg: 2 servings are for 2 people
    var favorite: Bool
    var instructions: String
    var categories: [Category]
    @Relationship(deleteRule: .cascade, inverse: \Ingredient.recipe) var ingredients: [Ingredient] = []
            
    init(name: String, recipeDescription: String, cookTime: Int, servings: Int, favorite: Bool, instructions: String, categories: [Category], ingredients: [Ingredient]) {
        self.name = name
        self.recipeDescription = recipeDescription
        self.cookTime = cookTime
        self.servings = servings
        self.favorite = favorite
        self.instructions = instructions
        self.categories = categories
        self.ingredients = ingredients
    }
}
