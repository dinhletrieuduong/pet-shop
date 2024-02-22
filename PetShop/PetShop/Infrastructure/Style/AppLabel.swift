//
//  AppLabel.swift
//  PetShop
//
//  Created by Dylan on 22/02/2024.
//

import SwiftUI

struct AppLabel<Content: View> : View {
    @ViewBuilder var content: Content
    
    var body: some View {
        content
            .font( AppFont.shared.bodyMedium)
    }
    
    @ViewBuilder
    func setSize(of size:CGFloat, of weight: Font.Weight) -> some View {
        self
            .font(AppFont.shared.custom(size, weight))
    }
}
