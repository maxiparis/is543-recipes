//
//  AddNewCategoryView.swift
//  recipes
//
//  Created by Maximiliano París Gaete on 12/11/24.
//

import SwiftUI

struct AddNewCategoryView: View {
    var viewModel: RecipeCategoriesManager
    
    @State var titleText: String = ""
    @State var emojiText: String = ""
    
    var body: some View {
        Section(header: Text("Add New Category").font(.title3)) {
            HStack {
                Text("Category Title:")
                Spacer()
                TextField("Tap to enter", text: $titleText)
                    .frame(width: 150)
                    .multilineTextAlignment(.trailing)
            }
            
            HStack {
                Text("Category Emoji:")
                Spacer()
                TextField("Tap to enter", text: $emojiText)
                    .frame(width: 150)
                    .multilineTextAlignment(.trailing)
            }
        }
        
        Button {
            viewModel.handleCreateNewCategory(title: titleText, emoji: emojiText)
            viewModel.presentAddNewCategory = false
        } label: {
            Text("Create new category")
        }
        .disabled(titleText == "" || emojiText == "")
    }
}
