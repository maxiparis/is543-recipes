//
//  Category.swift
//  recipes
//
//  Created by Maximiliano París Gaete on 11/30/24.
//

import SwiftUI
import SwiftData
import Foundation

@Model
class Category: Identifiable, Hashable {
    @Attribute(.unique) var id: UUID = UUID()
    var title: String
    @Relationship(deleteRule: .nullify, inverse: \Recipe.categories) var recipes: [Recipe] = []
    
    init(title: String, recipes: [Recipe]) {
        self.title = title
        self.recipes = recipes
    }
}
