//
//  CategoryView.swift
//  Recipes2
//
//  Created by Charles Garrett on 1/26/24.
//

import SwiftUI

enum RecipeCategory: Hashable, Codable, CaseIterable, Identifiable {
    case all, appetizers, salads,
         entrees, slowcooker, breads,
         desserts

    var title: String {
        switch self {
        case .all:
            return "All Recipes"
        case .appetizers:
            return "Appetizers"
        case .salads:
            return "Salads"
        case .entrees:
            return "Entrees"
        case .slowcooker:
            return "Slow Cooker"
        case .breads:
            return "Breads"
        case .desserts:
            return "Desserts"
        }
    }
    
    var id: Self { self }
}

struct CategoryView: View {
    @Binding var selection: RecipeCategory?
    
    var body: some View {
        List(selection: $selection,
                    // content: is a ViewBuilder, which is a type of ResultBuilder that
                    // takes a block of code that evaluates some expressions and converts
                    // it into code that builds a nested data structure of those elements.
                    // ViewBuilder does not seem to implement the buildArray method, so
                    // it can't handle iteration, only straight-line sequences and if-then-else
                    // control flow.
                    // We can defeat the ViewBuilder by giving it a single expression, which is
                    // just the list of Views that ViewBuilder would produce the expensive way.
                    content: {
            ForEach(RecipeCategory.allCases, content: {
                c in
                NavigationLink(value: c, label: {
                    Text(c.title)
                })
            })
        })
    }
}
