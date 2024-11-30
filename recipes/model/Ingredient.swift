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
    var amount: Double
    var scale: String
    var recipe: Recipe?
    
    init(id: UUID = UUID(), name: String, amount: Double, scale: String, recipe: Recipe) {
        self.id = id
        self.name = name
        self.amount = amount
        self.scale = scale
        self.recipe = recipe
    }
}
