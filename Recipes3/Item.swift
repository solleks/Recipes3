//
//  Item.swift
//  Recipes3
//
//  Created by Charles Garrett on 2/7/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date

    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
