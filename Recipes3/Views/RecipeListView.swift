//
//  RecipeListView.swift
//  Recipes2
//
//  Created by Charles Garrett on 1/26/24.
//

import SwiftUI

struct RecipeListView: View {
    @Binding var selection: String?
    let recipes: [Recipe]
    let selectedCategory: RecipeCategory
    
    var body: some View {
        List(selectedRecipes, selection: $selection, rowContent: {
            recipe in
            NavigationLink(value: recipe.title, label: {
                Text(recipe.title)
            })
        })
    }
    
    private var selectedRecipes: [Recipe] {
        if selectedCategory == .all {
            return recipes
        } else {
            return recipes.filter({$0.categories.contains(selectedCategory)})
        }
    }
}
