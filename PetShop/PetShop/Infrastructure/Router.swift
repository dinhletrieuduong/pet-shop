//
//  Router.swift
//  PetShop
//
//  Created by Dinh Le Trieu Duong on 10/02/2024.
//

import SwiftUI

final class Router: ObservableObject {
    
    @Published var navPath = NavigationPath()
    
    func navigate(to destination: Route) {
        navPath.append(destination)
    }
    
    func navigateBack() {
        navPath.removeLast()
    }
    
    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}


enum Route: Hashable, Equatable, CaseIterable {
    
    case home
    case detail
    case profile
    case cart
    
    
    case empty
    
    
    var title: String {
        switch self {
            case .home:
                "Home"
            case .detail:
                "Detail"
            case .profile:
                "Profile"
            case .cart:
                "Cart"
            case .empty:
                ""
        }
    }
    
    // TODO: Edit these
    @ViewBuilder
    func destination() -> some View {
        switch self {
            case .home:
                EmptyView()
            case .detail:
                EmptyView()
            case .profile:
                EmptyView()
            case .cart:
                EmptyView()
            case .empty:
                EmptyView()
        }
    }
}


