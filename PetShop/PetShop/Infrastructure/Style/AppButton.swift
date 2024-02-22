//
//  AppButton.swift
//  PetShop
//
//  Created by Dylan on 22/02/2024.
//

import SwiftUI

enum ButtonState {
    case primary
    case secondary
}

//struct AppButton<Content: View>: View {
//    @ViewBuilder private var content: Content
//    
//    private let activityIndicator = UIActivityIndicatorView(style: .medium)
//    @State private var defaultStyle: ButtonState = .primary
//    
//    @State var isLoading: Bool = false {
//        didSet {
//            updateView()
//        }
//    }
//    
//    init() {
//        
//            self.titleLabel?.font = AppFont.shared.custom(16, .bold)
//            self.layer.cornerRadius = 2.0
//            self.setStyleState(self.defaultStyle)
//            
//            // Indicator
//            addSubview(activityIndicator)
//            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
//            NSLayoutConstraint.activate([
//                activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//                activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
//            ])
//    }
//    
//    
//    var body: some View {
//        content
//    }
//    
//    private func updateView() {
//        if isLoading {
//            activityIndicator.startAnimating()
//            self.titleLabel?.alpha = 0
//            self.titleLabel?.layer.opacity = 0
//            self.imageView?.alpha = 0
//            self.titleLabel?.isHidden = true
//            self.titleLabel?.textColor = UIColor.clear
//            isEnabled = false
//        } else {
//            activityIndicator.stopAnimating()
//            self.titleLabel?.alpha = 1
//            self.titleLabel?.layer.opacity = 1
//            self.imageView?.alpha = 1
//            self.titleLabel?.textColor = UIColor.white
//            self.titleLabel?.isHidden = false
//            isEnabled = true
//        }
//    }
//    
//    @ViewBuilder
//    func setStyleState(_ state: ButtonState) -> some View {
//        self.defaultStyle = state
//        if state == .primary {
//            self
//                .foregroundStyle(.white)
//                .background(.black)
//                .border(.black, width: 1.5)
//        } else {
//            self
//                .foregroundStyle(.black)
//                .background(.white)
//                .border(.black, width: 1.5)
//        }
//    }
//}
