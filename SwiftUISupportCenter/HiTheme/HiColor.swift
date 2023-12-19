//
//  HiColor.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 13/12/2023.
//

import Foundation
import SwiftUI

extension Color{
    static let hiTheme = HiColorTheme()
}

struct HiColorTheme {
    let primaryColor = Color(hex: "#4564ED")
    let background = Color(hex: "#F5F5F5")
    let secondaryText = Color(hex: "#888888")
    let secondaryBlue = Color(hex: "#F0F3FE")
    let green = Color(hex: "#17BA58")
    let secondaryGreen = Color(hex: "#F1FDF6")
}
