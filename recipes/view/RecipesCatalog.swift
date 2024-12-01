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

    var body: some View {
        NavigationSplitView {
            VStack {
                List(viewModel.categories, selection: $selectedCategory) { category in
                    Text(category.title)
                }
                
                Button("Reset Data") {
                    viewModel.createDefaultData()
                    viewModel.fetchData()
                }
                
                Button("Erase all data") {
                    viewModel.eraseAllData()
                }
            }
            .navigationTitle("Categories")
        } content: {
            List {
            //List with all the recipes from that category
                
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
//                    } label: {
//                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
//                    }
//                }
//                .onDelete(perform: deleteItems)
            }
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
            Text("Select an item")
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
