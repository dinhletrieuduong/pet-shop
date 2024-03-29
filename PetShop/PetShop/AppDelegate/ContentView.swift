//
//  ContentView.swift
//  PetShop
//
//  Created by Dinh Le Trieu Duong on 10/02/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @EnvironmentObject var authManager: AuthManager
    
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    @State private var isSplashScreenPresented: Bool = false
    
    
    var body: some View {
        
//        BaseNavigationView()
//        if authManager.authState != .signedOut {
//            HomeView()
//        } else {
//            LoginView()
//        }
        
        if !isSplashScreenPresented {
            SplashScreen(isSplashScreenPresented: $isSplashScreenPresented)
        } else {
            
            NavigationSplitView {
                List {
                    ForEach(items) { item in
                        NavigationLink {
                            Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                        } label: {
                            Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    ToolbarItem {
                        Button(action: addItem) {
                            Label("Add Item", systemImage: "plus")
                        }
                    }
                }
            } detail: {
                Text("Select an item")
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
