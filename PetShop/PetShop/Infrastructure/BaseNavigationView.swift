//
//  BaseNavigationView.swift
//  PetShop
//
//  Created by Dinh Le Trieu Duong on 10/02/2024.
//

import SwiftUI

struct BaseNavigationView: View {
    
    @ObservedObject var router = Router()
    
    let columns: [GridItem] = [
        .init(),
        .init(),
    ]
    
    var body: some View {
        NavigationStack(path: $router.navPath) {
            List {
                //                LazyVGrid(columns: columns, spacing: 0, content: {
                ForEach(Route.allCases, id: \.title) { route in
                    if route != .empty {
                        NavigationLink(route.title, value: route)
                            .padding(.vertical)
                    }
                    
                }
                //                })
            }
            .listStyle(.insetGrouped)
            .navigationDestination(for: Route.self) { destination in
                destination.destination()
            }
            .navigationTitle("Portfolios")
        }
        .environmentObject(router)
        .ignoresSafeArea()
    }
}

#Preview {
    BaseNavigationView(router: Router())
}
