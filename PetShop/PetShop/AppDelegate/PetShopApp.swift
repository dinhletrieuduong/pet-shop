//
//  PetShopApp.swift
//  PetShop
//
//  Created by Dinh Le Trieu Duong on 10/02/2024.
//

import SwiftUI
import SwiftData

@main
struct PetShopApp: App {
    
    @StateObject private var networkMonitor = NetworkMonitor()
    
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
