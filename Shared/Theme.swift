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
        static let orange = Color(UIColor().hexStringToUIColor(hex: "#F9A708"))
        static let lightGray = Color(UIColor().hexStringToUIColor(hex: "#9b9b9b"))
        static let gray = Color(UIColor().hexStringToUIColor(hex: "#5b5b5b"))
    }
}
