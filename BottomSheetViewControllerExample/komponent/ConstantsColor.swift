//
//  ConstantsColor.swift
//  BottomSheetViewControllerExample
//
//  Created by PT Diksha Teknologi Indonesia on 06/07/25.
//

import UIKit
import SwiftUI


extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        Foundation.Scanner(string: hexSanitized).scanHexInt64(&rgb)
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255
        let blue = CGFloat(rgb & 0x0000FF) / 255
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

// TODO: Don't use this code, Will be removed later
struct ConstantsColor {
    // UIColor as base
    static let black100 = UIColor(hex: "#F5F7FB")
    static let black300 = UIColor(hex: "#C2CBD6")
    static let black700 = UIColor(hex: "#465668")
    static let black900 = UIColor(hex: "#181C21")
    static let primary500 = UIColor(hex: "#0059FF")
    static let white900 = UIColor(hex: "#FFFFFF")
    static let primary100 = UIColor(hex: "#E6EEFF")
    static let blue500 = UIColor(hex: "#0059FF")
    static let black500 = UIColor(hex: "#7B90A6")

    // SwiftUI Color conversion
    static let black100Color = Color(black100)
    static let black300Color = Color(black300)
    static let black700Color = Color(black700)
    static let black900Color = Color(black900)
    static let primary500Color = Color(primary500)
    static let white900Color = Color(white900)
    static let primary100Color = Color(primary100)
    static let blue500Color = Color(blue500)
    static let black500Color = Color(black500)

    static let neutralLight10 = UIColor(hex: "F8F9F9")
}
