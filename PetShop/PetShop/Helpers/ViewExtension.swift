//
//  ViewExtension.swift
//  PetShop
//
//  Created by Dinh Le Trieu Duong on 10/02/2024.
//

import SwiftUI

extension View {

    @ViewBuilder
    func `if`<Content: View>(_ condition: @autoclosure () -> Bool, transform: (Self) -> Content) -> some View {
        if condition() {
            transform(self)
        } else {
            self
        }
    }
    
    @ViewBuilder
    func replace<Content: View>(if condition: Bool, @ViewBuilder content: @escaping () -> Content) -> some View {
        if condition {
            content()
        } else {
            self
        }
    }
    
    @ViewBuilder
    func isHidden(_ shouldHide: Bool) -> some View {
        if shouldHide {
            self.hidden()
        } else {
            self
        }
    }
    
    // MARK: Vertical Center
    func vCenter() -> some View {
        self.frame(maxHeight: .infinity, alignment: .center)
    }
    
    // MARK: Vertical Top
    func vTop() -> some View {
        self.frame(maxHeight: .infinity, alignment: .top)
    }
    
    // MARK: Vertical Bottom
    func vBottom() -> some View {
        self.frame(maxHeight: .infinity, alignment: .bottom)
    }
    
    // MARK: Horizontal Center
    func hCenter() -> some View {
        self.frame(maxWidth: .infinity, alignment: .center)
    }
    // MARK: Horizontal Leading
    func hLeading() -> some View {
        self.frame(maxWidth: .infinity, alignment: .leading)
    }
    // MARK: Horizontal Trailing
    func hTrailing() -> some View {
        self.frame(maxWidth: .infinity, alignment: .trailing)
    }

    /// Disable with opacity extension
    @ViewBuilder
    func disableWithOpacity(_ status: Bool) -> some View {
        self.disabled(status)
            .opacity(status ? 0.6 : 1)
    }
}
