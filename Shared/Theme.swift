//
//  Theme.swift
//  SwiftUIUIChallenges
//
//  Created by Wouter Straver on 28/10/2022.
//

import Foundation
import SwiftUI

class Theme {
    static let poppins = "Poppins-Regular"
    static let poppinsBold = "Poppins-Bold"
    static let poppinSemiBold = "Poppins-SemiBold"
}

extension Color {
    struct Theme {
        static let orange = Color(hex: "#F9A708")
        static let green = Color(hex: "#84CB83")
        static let lightGray = Color(hex: "#9b9b9b")
        static let gray = Color(hex: "#5b5b5b")
    }
}

extension View {
    /// Font size of 57
    func displayLarge(_ weight: Font.Weight = .regular) -> some View {
        return self.modifier(ScaledFont(size: 57, weight: weight))
    }
    /// Font size of 45
    func displayMedium(_ weight: Font.Weight = .regular) -> some View {
        return self.modifier(ScaledFont(size: 45, weight: weight))
    }
    /// Font size of 36
    func displaySmall(_ weight: Font.Weight = .regular) -> some View {
        return self.modifier(ScaledFont(size: 36, weight: weight))
    }
    /// Font size of 32
    func headlineLarge(_ weight: Font.Weight = .regular) -> some View {
        return self.modifier(ScaledFont(size: 32, weight: weight))
    }
    /// Font size of 28
    func headlineMedium(_ weight: Font.Weight = .regular) -> some View {
        return self.modifier(ScaledFont(size: 28, weight: weight))
    }
    /// Font size of 24
    func headlineSmall(_ weight: Font.Weight = .regular) -> some View {
        return self.modifier(ScaledFont(size: 24, weight: weight))
    }
    /// Font size of 22
    func titleLarge(_ weight: Font.Weight = .regular) -> some View {
        return self.modifier(ScaledFont(size: 22, weight: weight))
    }
    /// Font size of 16
    func titleMedium(_ weight: Font.Weight = .regular) -> some View {
        return self.modifier(ScaledFont(size: 16, weight: weight))
    }
    /// Font size of 14
    func titleSmall(_ weight: Font.Weight = .regular) -> some View {
        return self.modifier(ScaledFont(size: 14, weight: weight))
    }
    /// Font size of 14
    func labelLarge(_ weight: Font.Weight = .regular) -> some View {
        return self.modifier(ScaledFont(size: 14, weight: weight))
    }
    /// Font size of 12
    func labelMedium(_ weight: Font.Weight = .regular) -> some View {
        return self.modifier(ScaledFont(size: 12, weight: weight))
    }
    /// Font size of 11
    func labelSmall(_ weight: Font.Weight = .regular) -> some View {
        return self.modifier(ScaledFont(size: 11, weight: weight))
    }
    /// Font size of 16
    func bodyLarge(_ weight: Font.Weight = .regular) -> some View {
        return self.modifier(ScaledFont(size: 16, weight: weight))
    }
    /// Font size of 14
    func bodyMedium(_ weight: Font.Weight = .regular) -> some View {
        return self.modifier(ScaledFont(size: 14, weight: weight))
    }
    /// Font size of 12
    func bodySmall(_ weight: Font.Weight = .regular) -> some View {
        return self.modifier(ScaledFont(size: 12, weight: weight))
    }
}

/// Does not work in preview
struct ScaledFont: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
    var name: String? = "Poppins"
    var size: Double
    var weight: Font.Weight = .regular
    
    func body(content: Content) -> some View {
        #if os(iOS)
        let scaledSize = UIFontMetrics.default.scaledValue(for: size)
        #else
        let scaledSize = size
        #endif
        
        if let name {
            switch weight {
            case .semibold:
                return content.font(.custom("\(name)-SemiBold", size: scaledSize))
            case .bold:
                return content.font(.custom("\(name)-Bold", size: scaledSize))                
            default:
                return content.font(.custom("\(name)-Regular", size: scaledSize))
            }
        }
        return content.font(.system(size: scaledSize))
            
    }
}
