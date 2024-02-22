//
//  LoginView.swift
//  PetShop
//
//  Created by Dylan on 22/02/2024.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authManager: AuthManager
    
    
    var body: some View {
        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Hello, world!@*/Text("Hello, world!")/*@END_MENU_TOKEN@*/
    }
    
    func signAnonymously() {
        Task {
            do {
                let result = try await authManager.signInAnonymously()
            }
            catch {
                print("SignInAnonymouslyError: \(error)")
            }
        }
    }
}
