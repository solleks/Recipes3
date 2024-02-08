//
//  Recipes3App.swift
//  Recipes3
//
//  Created by Charles Garrett on 2/7/24.
//

import SwiftUI
import SwiftData
import UniformTypeIdentifiers

@main
struct Recipes3App: App {
    var body: some Scene {
        DocumentGroup(editing: .itemDocument, migrationPlan: Recipes3MigrationPlan.self) {
            ContentView()
        }
    }
}

extension UTType {
    static var itemDocument: UTType {
        UTType(importedAs: "com.example.item-document")
    }
}

struct Recipes3MigrationPlan: SchemaMigrationPlan {
    static var schemas: [VersionedSchema.Type] = [
        Recipes3VersionedSchema.self,
    ]

    static var stages: [MigrationStage] = [
        // Stages of migration between VersionedSchema, if required.
    ]
}

struct Recipes3VersionedSchema: VersionedSchema {
    static var versionIdentifier = Schema.Version(1, 0, 0)

    static var models: [any PersistentModel.Type] = [
/*        Ingredient.self,
        Amount.self,
        IngredientAmount.self,
        Recipe.self */
    ]
}
