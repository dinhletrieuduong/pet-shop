//
//  PetShopApp.swift
//  PetShop
//
//  Created by Dinh Le Trieu Duong on 10/02/2024.
//

import SwiftUI
import SwiftData
import FirebaseCore

/// Add the -ObjC flag if you are using Firebase Analytics in your project.. select project Target → Build Settings, search for Other Linker Flags and add -ObjC.
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//    FirebaseApp.configure()

    return true
  }
}

@main
struct PetShopApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject var authManager: AuthManager

    @StateObject private var networkMonitor = NetworkMonitor()
    
    init() {
        // Use Firebase library to configure APIs
        FirebaseApp.configure()
        
        // Initialize authManager.
        let authManager = AuthManager()
        _authManager = StateObject(wrappedValue: authManager)
    }
    
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
            .environmentObject(authManager)
        }
        .modelContainer(sharedModelContainer)
    }
}
