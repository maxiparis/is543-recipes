//
//  recipesApp.swift
//  recipes
//
//  Created by Maximiliano París Gaete on 11/29/24.
//

import SwiftUI
import SwiftData

@main
struct recipesApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Item.self])
    }
}
