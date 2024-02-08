//
//  RecipeListView.swift
//  Recipes2
//
//  Created by Charles Garrett on 1/26/24.
//

import SwiftUI

struct RecipeListView: View {
    @Binding var selection: String?
    let selectedCategory: RecipeCategory
    
    var body: some View {
        List(recipes, selection: $selection, rowContent: {
            recipe in
            NavigationLink(value: recipe.title, label: {
                Text(recipe.title)
            })
        })
    }
    
    private var recipes: [Recipe] {
        if selectedCategory == .all {
            return allRecipes
        } else {
            return allRecipes.filter({$0.categories.contains(selectedCategory)})
        }
    }
}
