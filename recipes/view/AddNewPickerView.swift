//
//  AddNewPickerView.swift
//  recipes
//
//  Created by Maximiliano París Gaete on 12/11/24.
//

import SwiftUI

struct AddNewPickerView: View {
    var categoriesManager: RecipeCategoriesManager

    @State var selectedTab: Int = 0
    
    var body: some View {
        Form {
            Picker("Select Category", selection: $selectedTab) {
                Text("New Category")
                    .tag(0)
                
                Text("New Recipe")
                    .tag(1)
            }
            .pickerStyle(.segmented)
            .listRowBackground(Color.clear)
            
            if selectedTab == 0 {
                AddNewCategoryView(viewModel: categoriesManager)
            } else {
                AddNewRecipeView(newRecipeManager: NewRecipeManager())
            }
        }
    }
    
}

//#Preview {
//    AddNewPickerView()
//}
