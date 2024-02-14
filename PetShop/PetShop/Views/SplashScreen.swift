//
//  SplashScreen.swift
//  PetShop
//
//  Created by Dinh Le Trieu Duong on 11/02/2024.
//

import SwiftUI

struct SplashScreen: View {
    @Binding var isSplashScreenPresented: Bool
    
    
    @State private var scale: CGSize = .init(width: 0.8, height: 0.8)
    @State private var systemImageOpacity: CGFloat = 0.0
    @State private var imageOpacity: CGFloat = 1.0
    @State private var opacity: CGFloat = 1.0
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            ZStack {
                Image(systemName: "applelogo")
                    .font(.system(size: 105))
                    .foregroundStyle(.white)
                    .opacity(systemImageOpacity)
                
                Image("app_logo")
                    .resizable()
                    .scaledToFit()
                    .opacity(imageOpacity)
                    .frame(width: 100, height: 100)
                    .offset(x: 1)
            }
            .scaleEffect(scale)
            
        }
        .opacity(opacity)
        .onAppear(perform: {
            withAnimation(.easeInOut(duration: 1.5)) {
                scale = .init(width: 1.2, height: 1.2)
                systemImageOpacity = 1
                
            }
            
            for i in 0..<7 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5 + Double(i) * 0.1) {
                    if imageOpacity == 0 {
                        imageOpacity = 1
                    } else {
                        imageOpacity = 0
                    }
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation(.easeIn(duration: 0.35)) {
                    scale = .init(width: 50, height: 50)
                    opacity = 0
                }
                
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.9) {
                withAnimation(.easeIn(duration: 0.2)) {
                    isSplashScreenPresented.toggle()
                }
                
            }
        })
    }
}

#Preview {
    ContentView()
}
