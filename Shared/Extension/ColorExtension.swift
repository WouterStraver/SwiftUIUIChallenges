//
//  ColorExtension.swift
//  SwiftUIUIChallenges (iOS)
//
//  Created by Wouter Straver on 04/10/2022.
//

import SwiftUI
extension Color {
    init(hex:String) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            self.init(.gray)
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        self.init(
            red: Double((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: Double((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: Double(rgbValue & 0x0000FF) / 255.0,
            opacity: 1.0)        
    }
    #if os(iOS)
    static let systemBackground = Color(uiColor: UIColor.systemBackground)
    #else
    static let systemBackground = Color(nsColor: NSColor.windowBackgroundColor)
    #endif
}
