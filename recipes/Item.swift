//
//  Item.swift
//  recipes
//
//  Created by Maximiliano París Gaete on 11/29/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
