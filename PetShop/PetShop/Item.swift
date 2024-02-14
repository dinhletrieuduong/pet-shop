//
//  Item.swift
//  PetShop
//
//  Created by Dinh Le Trieu Duong on 10/02/2024.
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
