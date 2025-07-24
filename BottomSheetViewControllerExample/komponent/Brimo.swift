//
//  Brimo.swift
//  BottomSheetViewControllerExample
//
//  Created by PT Diksha Teknologi Indonesia on 06/07/25.
//


import SwiftUI

extension Color {
    static func swiftUIColor(_ uiColor: UIColor) -> Color {
        return Color(uiColor)
    }

    static func generateFrom(hex: String) -> Color {
        if let uiColor = UIColor(hexString: hex) {
            if #available(iOS 15.0, *) {
                return Color(uiColor: uiColor)
            } else {
                // Fallback: use Color with RGB components manually
                var red: CGFloat = 0
                var green: CGFloat = 0
                var blue: CGFloat = 0
                var alpha: CGFloat = 0
                uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
                return Color(red: red, green: green, blue: blue, opacity: alpha)
            }
        } else {
            return Color.clear
        }
    }
}


extension UIColor {
    enum Brimo {}
}

extension UIColor.Brimo {
    enum Primary {}
    enum Secondary {}
    enum Black {}
    enum White {}
    enum Red {}
    enum Yellow {}
    enum Green {}
    enum Bluesky {}
    enum Briva {}
    enum Brizzi {}
}

extension UIColor.Brimo.Primary {
    /// Hex: #0054F3, RGBA (0, 84, 243, 1)
    static let main = #colorLiteral(red: 0, green: 0.3294117647, blue: 0.9529411765, alpha: 1)
    /// Hex: #E6EEFF, RGBA (230, 238, 255, 1)
    static let x100 = #colorLiteral(red: 0.901, green: 0.933, blue: 1.0, alpha: 1.0)
    /// Hex: #ADC8FF, RGBA (173, 200, 255, 1)
    static let x300 = #colorLiteral(red: 0.678, green: 0.784, blue: 1.0, alpha: 1.0)
    /// Hex: #0047CC, RGBA (0, 71, 204, 1)
    static let x700 = #colorLiteral(red: 0.0, green: 0.278, blue: 0.8, alpha: 1.0)
    /// Hex: #1C274C, RGBA (28, 39, 76, 1)
    static let x800 = #colorLiteral(red: 0.110, green: 0.153, blue: 0.298, alpha: 1.0)
    /// Hex: #0C0725, RGBA (12, 7, 37, 1)
    static let x900 = #colorLiteral(red: 0.047, green: 0.027, blue: 0.145, alpha: 1.0)
}

extension UIColor.Brimo.Secondary {
    /// Hex: #EC843C, RGBA (236, 132, 60, 1)
    static let main = #colorLiteral(red: 0.925, green: 0.518, blue: 0.235, alpha: 1.0)
    /// Hex: #FEF6F1, RGBA (254, 246, 241, 1)
    static let x100 = #colorLiteral(red: 0.996, green: 0.965, blue: 0.945, alpha: 1.0)
    /// Hex: #F8D0B5, RGBA (248, 208, 181, 1)
    static let x300 = #colorLiteral(red: 0.973, green: 0.816, blue: 0.71, alpha: 1.0)
    /// Hex: #9E4A0F, RGBA (158, 74, 15, 1)
    static let x700 = #colorLiteral(red: 0.62, green: 0.29, blue: 0.059, alpha: 1.0)
    /// Hex: #331805, RGBA (51, 24, 5, 1)
    static let x900 = #colorLiteral(red: 0.2, green: 0.094, blue: 0.02, alpha: 1.0)
}

extension UIColor.Brimo.Black {
    /// Hex: #181C21, RGBA (24, 28, 33, 1)
    static let main = #colorLiteral(red: 0.094, green: 0.110, blue: 0.129, alpha: 1.0)
    /// Hex: #181C21 with 10% opacity
    static let opacity10 = #colorLiteral(red: 0.094, green: 0.110, blue: 0.129, alpha: 0.1)
    /// Hex: #181C21 with 30% opacity
    static let opacity30 = #colorLiteral(red: 0.094, green: 0.110, blue: 0.129, alpha: 0.3)
    /// Hex: #181C21 with 50% opacity
    static let opacity50 = #colorLiteral(red: 0.094, green: 0.11, blue: 0.129, alpha: 0.5)
    /// Hex: #F5F7FB, RGBA (245, 247, 251, 1)
    static let x100 = #colorLiteral(red: 0.961, green: 0.969, blue: 0.984, alpha: 1.0)
    /// Hex: #E8ECF1, RGBA (232, 236, 241, 1)
    static let x200 = #colorLiteral(red: 0.91, green: 0.925, blue: 0.945, alpha: 1.0)
    /// Hex: #E9EEF6, RGBA (233, 238, 246, 1)
    static let x300 = #colorLiteral(red: 0.914, green: 0.933, blue: 0.965, alpha: 1.0)
    /// Hex: #C2CBD6, RGBA (194, 203, 214, 1)
    static let x400 = #colorLiteral(red: 0.761, green: 0.796, blue: 0.839, alpha: 1.0)
    /// Hex: #A3B1C1, RGBA (163, 177, 193, 1)
    static let x500 = #colorLiteral(red: 0.639, green: 0.694, blue: 0.757, alpha: 1.0)
    /// Hex: #7B90A6, RGBA (123, 144, 166, 1)
    static let x600 = #colorLiteral(red: 0.482, green: 0.565, blue: 0.651, alpha: 1.0)
    /// Hex: #465668, RGBA (70, 86, 104, 1)
    static let x700 = #colorLiteral(red: 0.275, green: 0.337, blue: 0.408, alpha: 1.0)
    /// Hex: #C2CBD6 (same as x400)
    static let x800 = #colorLiteral(red: 0.761, green: 0.796, blue: 0.839, alpha: 1.0)
    /// Hex: #F5F6F8, RGBA (245, 246, 248, 1)
    static let x900 = #colorLiteral(red: 0.9598987699, green: 0.9648706317, blue: 0.9733908772, alpha: 1)
    /// Hex: #E0E5EB, RGBA (224, 229, 235, 1)
    static let x1000 = #colorLiteral(red: 0.8787719607, green: 0.8986920118, blue: 0.9198384881, alpha: 1)
    /// Hex: #D0D5DC, RGBA (208, 213, 220, 1)
    static let x1100 = #colorLiteral(red: 0.8160230517, green: 0.8359464407, blue: 0.8613815904, alpha: 1)
}

extension UIColor.Brimo.White {
    /// Hex: #FFFFFF with 0% opacity (fully transparent white)
    static let transparent = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.0)
    /// Hex: #FFFFFF with 10% opacity
    static let opacity10 = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.1)
    /// Hex: #FFFFFF with 30% opacity
    static let opacity30 = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.3)
    /// Hex: #FFFFFF with 50% opacity
    static let opacity50 = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
    /// Hex: #FFFFFF, RGBA (255, 255, 255, 1)
    static let main = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    /// Hex: #EAEBEB, RGBA (234, 235, 235, 1)
    static let light20 = #colorLiteral(red: 0.9176470588, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
}

extension UIColor.Brimo.Red {
    /// Hex: #FDEDED, RGBA (253, 237, 237, 1)
    static let x100 = #colorLiteral(red: 0.992, green: 0.929, blue: 0.929, alpha: 1.0)
    /// Hex: #F8C4C4, RGBA (248, 196, 196, 1)
    static let x300 = #colorLiteral(red: 0.973, green: 0.769, blue: 0.769, alpha: 1.0)
    /// Hex: #EB404D, RGBA (235, 64, 77, 1)
    static let main = #colorLiteral(red: 0.922, green: 0.251, blue: 0.302, alpha: 1.0)
    /// Hex: #DA1A1A, RGBA (218, 26, 26, 1)
    static let x600 = #colorLiteral(red: 0.855, green: 0.102, blue: 0.102, alpha: 1.0)
    /// Hex: #981313, RGBA (152, 19, 19, 1)
    static let x700 = #colorLiteral(red: 0.596, green: 0.075, blue: 0.075, alpha: 1.0)
    /// Hex: #E84040, RGBA (232, 64, 64, 1)
    static let x800 = #colorLiteral(red: 0.9096300006, green: 0.2505269945, blue: 0.2527492344, alpha: 1)
    /// Hex: #320606, RGBA (50, 6, 6, 1)
    static let x900 = #colorLiteral(red: 0.196, green: 0.024, blue: 0.024, alpha: 1.0)
    /// Hex: #E84040, RGBA (232, 64, 64, 1)
    static let error = #colorLiteral(red: 0.9098039216, green: 0.2509803922, blue: 0.2509803922, alpha: 1)
}

extension UIColor.Brimo.Yellow {
    /// Hex: #FFF9EB, RGBA (255, 249, 235, 1)
    static let x100 = #colorLiteral(red: 1.0, green: 0.976, blue: 0.922, alpha: 1.0)
    /// Hex: #FFEBBD, RGBA (255, 235, 189, 1)
    static let x300 = #colorLiteral(red: 1.0, green: 0.922, blue: 0.741, alpha: 1.0)
    /// Hex: #FFBE26, RGBA (255, 190, 38, 1)
    static let main = #colorLiteral(red: 1.0, green: 0.745, blue: 0.149, alpha: 1.0)
    /// Hex: #AD7900, RGBA (173, 121, 0, 1)
    static let x700 = #colorLiteral(red: 0.678, green: 0.475, blue: 0.0, alpha: 1.0)
    /// Hex: #382B00, RGBA (56, 43, 0, 1)
    static let x900 = #colorLiteral(red: 0.22, green: 0.169, blue: 0.0, alpha: 1.0)
}

extension UIColor.Brimo.Green {
    /// Hex: #EEFFF4, RGBA (238, 255, 244, 1)
    static let x100 = #colorLiteral(red: 0.933, green: 1.0, blue: 0.957, alpha: 1.0)
    /// Hex: #C9F3D8, RGBA (201, 243, 216, 1)
    static let x300 = #colorLiteral(red: 0.788, green: 0.953, blue: 0.847, alpha: 1.0)
    /// Hex: #27AE60, RGBA (114, 174, 96, 1)
    static let main = #colorLiteral(red: 0.1592395604, green: 0.7238716483, blue: 0.451767683, alpha: 1)
    /// Hex: #1E6A37, RGBA (30, 106, 55, 1)
    static let x700 = #colorLiteral(red: 0.118, green: 0.416, blue: 0.216, alpha: 1.0)
    /// Hex: #0A2E19, RGBA (10, 46, 25, 1)
    static let x900 = #colorLiteral(red: 0.039, green: 0.18, blue: 0.098, alpha: 1.0)
}

extension UIColor.Brimo.Bluesky {
    /// Hex: #E6FBFF, RGBA (230, 251, 255, 1)
    static let x100 = #colorLiteral(red: 0.902, green: 0.984, blue: 1, alpha: 1)
    /// Hex: #ADEEFF, RGBA (173, 238, 255, 1)
    static let x300 = #colorLiteral(red: 0.678, green: 0.933, blue: 1.0, alpha: 1.0)
    /// Hex: #51A9F4, RGBA (81, 169, 244, 1)
    static let main = #colorLiteral(red: 0.318, green: 0.663, blue: 0.957, alpha: 1.0)
    /// Hex: #0971A6, RGBA (9, 113, 166, 1)
    static let x700 = #colorLiteral(red: 0.035, green: 0.443, blue: 0.651, alpha: 1.0)
    /// Hex: #032436, RGBA (3, 36, 54, 1)
    static let x900 = #colorLiteral(red: 0.012, green: 0.141, blue: 0.212, alpha: 1.0)
}

extension UIColor.Brimo.Briva {
    /// Hex: #E4FAFA, RGBA (228, 250, 250, 1)
    static let x100 = #colorLiteral(red: 0.894, green: 0.980, blue: 0.980, alpha: 1.0)
    /// Hex: #CCF0F9, RGBA (204, 240, 249, 1)
    static let x300 = #colorLiteral(red: 0.8, green: 0.941, blue: 0.976, alpha: 1.0)
    /// Hex: #58CFCF, RGBA (88, 207, 207, 1)
    static let main = #colorLiteral(red: 0.345, green: 0.812, blue: 0.812, alpha: 1.0)
    /// Hex: #278787, RGBA (39, 135, 135, 1)
    static let x700 = #colorLiteral(red: 0.153, green: 0.529, blue: 0.529, alpha: 1.0)
    /// Hex: #0D2C2C, RGBA (13, 44, 44, 1)
    static let x900 = #colorLiteral(red: 0.051, green: 0.173, blue: 0.173, alpha: 1.0)
}

extension UIColor.Brimo.Brizzi {
    /// Hex: #E8FFFB, RGBA (232, 255, 251, 1)
    static let x100 = #colorLiteral(red: 0.91, green: 1.0, blue: 0.984, alpha: 1.0)
    /// Hex: #BDF0E8, RGBA (189, 240, 232, 1)
    static let x300 = #colorLiteral(red: 0.741, green: 0.941, blue: 0.91, alpha: 1.0)
    /// Hex: #05D79F, RGBA (5, 215, 159, 1)
    static let main = #colorLiteral(red: 0.02, green: 0.843, blue: 0.624, alpha: 1.0)
    /// Hex: #0A9471, RGBA (10, 148, 113, 1)
    static let x700 = #colorLiteral(red: 0.039, green: 0.58, blue: 0.443, alpha: 1.0)
    /// Hex: #013724, RGBA (1, 55, 36, 1)
    static let x900 = #colorLiteral(red: 0.004, green: 0.216, blue: 0.141, alpha: 1.0)
}

import SwiftUI
import UIKit

extension UIColor {
    /// Init UIColor from a hex string like "#RRGGBB" or "RRGGBB" or "#RRGGBBAA"
    convenience init?(hexString: String) {
        var hex = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        // Remove '#' if it exists
        if hex.hasPrefix("#") {
            hex.removeFirst()
        }

        // Check valid hex string length
        guard hex.count == 6 || hex.count == 8 else {
            return nil
        }

        var rgbValue: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&rgbValue)

        if hex.count == 6 {
            let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
            let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
            let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
            self.init(red: red, green: green, blue: blue, alpha: 1.0)
        } else {
            let red = CGFloat((rgbValue & 0xFF000000) >> 24) / 255.0
            let green = CGFloat((rgbValue & 0x00FF0000) >> 16) / 255.0
            let blue = CGFloat((rgbValue & 0x0000FF00) >> 8) / 255.0
            let alpha = CGFloat(rgbValue & 0x000000FF) / 255.0
            self.init(red: red, green: green, blue: blue, alpha: alpha)
        }
    }
}
