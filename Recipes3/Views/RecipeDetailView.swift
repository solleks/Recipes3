//
//  RecipeDetailView.swift
//  Recipes2
//
//  Created by Charles Garrett on 1/26/24.
//

import SwiftUI

struct RecipeDetailView: View {
    @Binding var selection: String?

    private var recipe: Recipe? {
        if let s = selection {
            for r in allRecipes {
                if r.title == s {
                    return r
                }
            }
        }
        return nil
    }
    
    var body: some View {
        ZStack {
            if let r = recipe {
                RecipeDetails(recipe: r)
                    .navigationTitle(r.title)
            } else {
                RecipeNotSelectedView()
            }
        }
    }
}

struct RecipeDetails: View {
    let recipe: Recipe
    
    var body: some View {
        HStack(alignment: .top, spacing: 20, content: {
            RecipeIngredientsView(recipe: recipe)
            RecipeDirectionsView(recipe: recipe)
        })
        .padding()
    }
}

struct RecipeIngredientsView: View {
    let recipe: Recipe

    var body: some View {
        VStack(content: {
            Text("INGREDIENTS")
                .underline()
                .padding(.bottom)
            List(content: {
                ForEach(recipe.ingredients, content: {
                    ingredient in
                    HStack(content: {
                        Text(ingredient.ingredient.description)
                            .frame(maxWidth: 250, alignment: .leading)
                        Text(ingredient.amount.description)
                            .frame(maxWidth: 50, alignment: .trailing)
                    })
                })
            })
        })
        .padding()
        .background(Color.secondary.colorInvert())
    }
}

struct RecipeDirectionsView: View {
    let recipe: Recipe
    
    var body: some View {
        VStack(content: {
            Text("Directions")
                .font(.title3)
                .padding(.bottom)
            List(content: {
                ForEach(Array(recipe.steps.enumerated()), id: \.offset, content: { index, step in
                    Text("\(index + 1).  \(step)")
                })
            })
        })
    }
}


struct RecipeNotSelectedView: View {
    var body: some View {
        Text("Select a recipe.")
    }
}

