//
//  Ingredient.swift
//  recipes
//
//  Created by Maximiliano París Gaete on 11/29/24.
//
import SwiftUI
import SwiftData
import Foundation

@Model
class Ingredient {
    @Attribute(.unique) var id = UUID()
    var name: String
    var amount: String
    var scale: String
    var recipe: Recipe?
    
    init(name: String, amount: String, scale: String, recipe: Recipe? = nil) {
        self.name = name
        self.amount = amount
        self.scale = scale
        self.recipe = recipe
    }
}
