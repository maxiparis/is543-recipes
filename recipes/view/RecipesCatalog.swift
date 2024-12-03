//
//  ContentView.swift
//  recipes
//
//  Created by Maximiliano París Gaete on 11/29/24.
//
 
import SwiftUI
import SwiftData

struct RecipesCatalog: View {
    @Environment(RecipeViewModel.self) private var viewModel
    @State private var selectedCategory: Category?
    @State private var selectedRecipe: Recipe?

    var body: some View {
        NavigationSplitView {
            ZStack(alignment: .bottom) {
                List(viewModel.categories, id: \.self, selection: $selectedCategory) { category in
                    Text(category.title)
                }
                VStack {
                    Button("Reset Data") {
                        viewModel.eraseAllData()
                        viewModel.createDefaultData()
                        viewModel.fetchData()
                    }
                    
                    Button("Erase all data") {
                        viewModel.eraseAllData()
                        viewModel.fetchData()
                    }
                }
            }
            .navigationTitle("Categories")
        } content: {
            if let selectedCategory {
                List(selectedCategory.recipes, id: \.self, selection: $selectedRecipe) { recipe in
                    Text(recipe.name)
                }
            } else {
                Text("Select a category")
            }
                
//                .onDelete(perform: deleteItems)
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
        } detail: {
            if let selectedRecipe {
                Text("You selected \(selectedRecipe.name)")
            } else {
                Text("Select an item")
            }
        }
    }
//
//    private func addItem() {
//        withAnimation {
//            let newItem = Item(timestamp: Date())
//            modelContext.insert(newItem)
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            for index in offsets {
//                modelContext.delete(items[index])
//            }
//        }
//    }
}

//#Preview {
//    RecipesCatalog()
//        .modelContainer(for: Item.self, inMemory: true)
//}
