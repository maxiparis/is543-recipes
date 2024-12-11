//
//  Instruction.swift
//  recipes
//
//  Created by Maximiliano París Gaete on 12/9/24.
//

import Foundation
import SwiftData

@Model
class Instruction: Identifiable {
    
    @Attribute(.unique) var id = UUID()
    var order: Int
    var title: String
    var descriptions: String
    var recipe: Recipe?
    
    init(order: Int, title: String, descriptions: String, recipe: Recipe? = nil) {
        self.order = order
        self.title = title
        self.descriptions = descriptions
        self.recipe = recipe
    }
}
