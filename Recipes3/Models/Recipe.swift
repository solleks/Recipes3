//
//  Recipe.swift
//  Recipes2
//
//  Created by Charles Garrett on 1/28/24.
//

import Foundation
import SwiftData

enum IngredientPhase: Codable {
    case dry
    case liquid
}

enum Unit: Codable {
    case number
    case teaspoon
    case tablespoon
    case cup
    case pint
    case quart
    case gallon
    case ounce
    case pound
    case gram
    case kilogram
    
    public var description: String {
        switch (self) {
        case .number:
            return ""
        case .teaspoon:
            return "tsp"
        case .tablespoon:
            return "Tbsp"
        case .cup:
            return "cup"
        case .pint:
            return "pint"
        case .quart:
            return "quart"
        case .gallon:
            return "gallon"
        case .ounce:
            return "oz"
        case .pound:
            return "lb"
        case .gram:
            return "g"
        case .kilogram:
            return "kg"
        }
    }
}

// One ingredient that may appear in a recipe.
@Model
final class Ingredient {
    var name: String
    var phase: IngredientPhase?
    
    init(name: String, phase: IngredientPhase? = nil) {
        self.name = name
        self.phase = phase
    }
    
    public var description: String {
        return "\(name)"
    }
}

@Model
final class Amount {
    var quantity: Float32
    var unit: Unit
    
    init(quantity: Float32, unit: Unit) {
        self.quantity = quantity
        self.unit = unit
    }
    
    public var description: String {
        let qty = prettyQuantity
        return "\(qty) \(unit.description)"
    }
    
    private var prettyQuantity: String {
        var result = "\(quantity)"
        // Remove trailing zeroes and decimal point.
        while result.hasSuffix("0") {
            result.removeLast(1)
        }
        if result.hasSuffix(".") {
            result.removeLast(1)
        }
        return result
    }
}

@Model
final class IngredientAmount: Identifiable {
    var ingredient: Ingredient
    var amount: Amount
    
    init(ingredient: Ingredient, amount: Amount) {
        self.ingredient = ingredient
        self.amount = amount
    }
    
    public var description: String {
        return "\(ingredient.description), \(amount.description)"
    }
}

@Model
final class Recipe: Identifiable {
    var title: String
    var categories: [RecipeCategory]
    var ingredients: [IngredientAmount]
    var steps: [String]
    var servings: Int
    var comments: String?
    var links: [URL]?
    
    init(title: String, categories: [RecipeCategory], ingredients: [IngredientAmount],
         steps: [String], servings: Int, comments: String? = nil, links: [URL]? = nil) {
        self.title = title
        self.categories = categories
        self.ingredients = ingredients
        self.steps = steps
        self.servings = servings
        self.comments = comments
        self.links = links
    }
}

let sausageAndEggCasseroleRecipe =
Recipe(title: "Sausage and Egg Casserole",
       categories: [RecipeCategory.entrees],
       ingredients: [IngredientAmount(ingredient: Ingredient(name: "Sliced white bread", phase: .dry),
                                      amount: Amount(quantity: 6, unit: Unit.number)),
                     IngredientAmount(ingredient: Ingredient(name: "Sausage", phase: .dry),
                                      amount: Amount(quantity: 1, unit: Unit.pound)),
                     IngredientAmount(ingredient: Ingredient(name: "Sharp cheese", phase: .dry),
                                      amount: Amount(quantity: 8, unit: Unit.ounce)),
                     IngredientAmount(ingredient: Ingredient(name: "Eggs", phase: .liquid),
                                      amount: Amount(quantity: 6, unit: Unit.number)),
                     IngredientAmount(ingredient: Ingredient(name: "Milk", phase: .liquid),
                                      amount: Amount(quantity: 2, unit: Unit.cup)),
                     IngredientAmount(ingredient: Ingredient(name: "Mustard", phase: .liquid),
                                      amount: Amount(quantity: 0.5, unit: Unit.teaspoon)),
                     IngredientAmount(ingredient: Ingredient(name: "Salt", phase: .dry),
                                      amount: Amount(quantity: 0.5, unit: Unit.teaspoon)),
                     IngredientAmount(ingredient: Ingredient(name: "Pepper", phase: .dry),
                                      amount: Amount(quantity: 0.5, unit: Unit.teaspoon)),
                    ],
       steps: ["Cube the bread",
              "Fry and drain the sausage",
              "Grate the cheese",
              "Grease a large casserole dish",
              "Cover the bottom of the dish with bread cubes",
              "Sprinkle sausage, then cheese, over bread",
              "Beat other ingredients together and pour on top of the other ingredients",
              "Refrigerate overnight, if desired",
              "Bake covered at 350° for 30 minutes",
              "Remove cover and bake for another 15 minutes",
              "Remove from oven and let sit for 10 minutes before serving"
              ],
       servings: 8)

let easyBrunswickStewRecipe =
Recipe(title: "Easy Brunswick Stew",
       categories: [RecipeCategory.entrees, RecipeCategory.slowcooker],
       ingredients: [IngredientAmount(ingredient: Ingredient(name: "Boneless pork shoulder", phase: .dry),
                                      amount: Amount(quantity: 3, unit: Unit.pound)),
                     IngredientAmount(ingredient: Ingredient(name: "Medium-size new potatoes", phase: .dry),
                                      amount: Amount(quantity: 3, unit: Unit.number)),
                     IngredientAmount(ingredient: Ingredient(name: "Large onion", phase: .dry),
                                      amount: Amount(quantity: 1, unit: Unit.number)),
                     IngredientAmount(ingredient: Ingredient(name: "Crushed tomatoes", phase: .liquid),
                                      amount: Amount(quantity: 28, unit: Unit.ounce)),
                     IngredientAmount(ingredient: Ingredient(name: "Barbecue sauce", phase: .liquid),
                                      amount: Amount(quantity: 18, unit: Unit.ounce)),
                     IngredientAmount(ingredient: Ingredient(name: "Baby lima beans", phase: .dry),
                                      amount: Amount(quantity: 9, unit: Unit.ounce)),
                     IngredientAmount(ingredient: Ingredient(name: "Corn kernels", phase: .dry),
                                      amount: Amount(quantity: 9, unit: Unit.ounce)),
                     IngredientAmount(ingredient: Ingredient(name: "Brown sugar", phase: .dry),
                                      amount: Amount(quantity: 6, unit: Unit.tablespoon)),
                     IngredientAmount(ingredient: Ingredient(name: "Salt", phase: .dry),
                                      amount: Amount(quantity: 1, unit: Unit.teaspoon))],
       steps: ["Peel and chop potatoes",
              "Chop onion",
              "Trim pork shoulder and cut into 2-inch pieces",
              "Stir together all ingredients in slow cooker",
              "Cover and cook on LOW for 10 to 12 hours or until potatoes are fork tender",
              "Remove pork with a slotted spoon and shred",
              "Return shredded pork to slow cooker and stir well"],
       servings: 10)

let allRecipes: [Recipe] = [
    sausageAndEggCasseroleRecipe,
    easyBrunswickStewRecipe
]
