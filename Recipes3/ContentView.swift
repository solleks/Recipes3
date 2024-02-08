//
//  ContentView.swift
//  Recipes3
//
//  Created by Charles Garrett on 2/7/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query private var recipes: [Recipe]
    @Environment(\.modelContext) private var modelContext

    @State private var selectedCategory: RecipeCategory? = RecipeCategory.all
    @State private var selectedRecipeTitle: String?

    var body: some View {
        NavigationSplitView {
            CategoryView(selection: $selectedCategory)
                .navigationSplitViewColumnWidth(min: 180, ideal: 200)
        } content: {
            RecipeListView(selection: $selectedRecipeTitle, recipes: recipes,
                           selectedCategory: selectedCategory ?? RecipeCategory.all)
                .navigationSplitViewColumnWidth(min: 180, ideal: 200)
        } detail: {
            RecipeDetailView(selection: $selectedRecipeTitle, recipes: recipes)
        }
    }
}
