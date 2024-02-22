//
//  AppFont.swift
//  PetShop
//
//  Created by Dylan on 22/02/2024.
//

import SwiftUI

extension Font {
    
    private enum CustomFont: String {
        case book = "Montserrat-Regular"
        case italic = "Montserrat-Italic"
        case thin = "Montserrat-Thin"
        case medium = "Montserrat-Medium"
        case bold = "Montserrat-Bold"
    }
    
    static func appFontRD(ofSize size: CGFloat, weight: Font.Weight = .regular) -> Font {
        var font = Font.custom(CustomFont.book.rawValue, size: size)
        switch weight {
        case .ultraLight:
            font = Font.custom(CustomFont.thin.rawValue, size: size)
        case .thin:
            font = Font.custom(CustomFont.thin.rawValue, size: size)
        case .light:
            font = Font.custom(CustomFont.thin.rawValue, size: size)
        case .regular:
            font = Font.custom(CustomFont.book.rawValue, size: size)
        case .medium:
            font = Font.custom(CustomFont.medium.rawValue, size: size)
        case .semibold:
            font = Font.custom(CustomFont.medium.rawValue, size: size)
        case .bold:
            font = Font.custom(CustomFont.bold.rawValue, size: size)
        case .heavy:
            font = Font.custom(CustomFont.bold.rawValue, size: size)
        case .black:
            font = Font.custom(CustomFont.bold.rawValue, size: size)
        default:
            font = Font.custom(CustomFont.book.rawValue, size: size)
        }
//        guard let retValue = font else {
//            return .system(size: size, weight: weight)
//        }
        return font
    }
    
    static func boldAppFontRD(ofSize size: CGFloat) -> Font {
        return self.appFontRD(ofSize: size, weight: .bold)
    }
    
    static func italicAppFontRD(ofSize size: CGFloat) -> Font {
        return Font.custom(CustomFont.italic.rawValue, size: size)
    }
}

class AppFont {
    
    static let shared = AppFont()
    
    public var headingSemibold: Font {
        return Font.appFontRD(ofSize: 32, weight: .semibold)
    }
    
    public var headingRegular: Font {
        return Font.appFontRD(ofSize: 32, weight: .regular)
    }
    
    public var headlineSemibold: Font {
        return Font.appFontRD(ofSize: 24, weight: .semibold)
    }
    
    public var headlineRegular: Font {
        return Font.appFontRD(ofSize: 24, weight: .regular)
    }
    
    public var titleSemibold: Font {
        return Font.appFontRD(ofSize: 20, weight: .semibold)
    }
    
    public var titleRegular: Font {
        return Font.appFontRD(ofSize: 20, weight: .regular)
    }
    
    public var subHeadingSemibold: Font {
        return Font.appFontRD(ofSize: 16, weight: .semibold)
    }
    
    public var subHeadingRegular: Font {
        return Font.appFontRD(ofSize: 16, weight: .regular)
    }
    
    public var subHeadingMedium: Font {
        return Font.appFontRD(ofSize: 16, weight: .medium)
    }
    
    public var bodySemibold: Font {
        return Font.appFontRD(ofSize: 14, weight: .semibold)
    }
    
    public var bodyRegular: Font {
        return Font.appFontRD(ofSize: 14, weight: .regular)
    }
    
    public var captionSemibold: Font {
        return Font.appFontRD(ofSize: 12, weight: .semibold)
    }
    
    public var captionRegular: Font {
        return Font.appFontRD(ofSize: 12, weight: .regular)
    }
    
    public var bodyMedium: Font {
        return Font.appFontRD(ofSize: 14, weight: .medium)
    }
    
    public var headlineMedium: Font {
        return Font.appFontRD(ofSize: 32, weight: .medium)
    }
    
    public var subHeadlineMedium: Font {
        return Font.appFontRD(ofSize: 24, weight: .medium)
    }
    
    public var bodyBook: Font {
        return Font.appFontRD(ofSize: 16)
    }
    
    public var headlineBook: Font {
        return Font.appFontRD(ofSize: 24)
    }
    
    public var subHeadlineBook: Font {
        return Font.appFontRD(ofSize: 24)
    }
    
    public func custom(_ size:CGFloat ,_ weight: Font.Weight) -> Font {
        return Font.appFontRD(ofSize: size, weight: weight)
    }
}
