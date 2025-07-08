//
//  BrimoTypographyType.swift
//  BottomSheetViewControllerExample
//
//  Created by PT Diksha Teknologi Indonesia on 06/07/25.
//

import SwiftUI

extension Font {
    static func swiftUIFont(_ uiFont: UIFont) -> Font {
        return Font(uiFont)
    }
}

enum BrimoTypographyType: String, CaseIterable {
    case regular
    case medium
    case semiBold
    case bold
}

class BrimoTypography {
    private static var installed = false

    fileprivate static func configureFont(_ font: BrimoTypographyType) -> UIFont {
        switch font {
        case .regular:
            return UIFont(name: font.rawValue, size: 1) ?? UIFont.systemFont(ofSize: 1)
        case .medium:
            return UIFont(name: font.rawValue, size: 1) ?? UIFont.systemFont(ofSize: 1)
        case .semiBold:
            return UIFont(name: font.rawValue, size: 1) ?? UIFont.boldSystemFont(ofSize: 1)
        case .bold:
            return UIFont(name: font.rawValue, size: 1) ?? UIFont.boldSystemFont(ofSize: 1)
        }
    }
}

extension UIFont {
    enum Brimo {}
}

extension UIFont.Brimo {
    enum Headline {}
    enum Title {}
    enum Body {}
}

extension UIFont.Brimo.Headline {
    static let largeSemiBold: UIFont = BrimoTypography.configureFont(.semiBold).withSize(40)
    static let mediumSemiBold: UIFont = BrimoTypography.configureFont(.semiBold).withSize(36)
    static let smallSemiBold: UIFont = BrimoTypography.configureFont(.semiBold).withSize(32)
}

extension UIFont.Brimo.Title {
    static let extraLargeRegular: UIFont = BrimoTypography.configureFont(.regular).withSize(28)
    static let extraLargeSemiBold: UIFont = BrimoTypography.configureFont(.semiBold).withSize(28)
    static let largeRegular: UIFont = BrimoTypography.configureFont(.regular).withSize(24)
    static let largeSemiBold: UIFont = BrimoTypography.configureFont(.semiBold).withSize(24)
    static let mediumRegular: UIFont = BrimoTypography.configureFont(.regular).withSize(20)
    static let mediumSemiBold: UIFont = BrimoTypography.configureFont(.semiBold).withSize(20)
    static let smallRegular: UIFont = BrimoTypography.configureFont(.regular).withSize(16)
    static let smallSemiBold: UIFont = BrimoTypography.configureFont(.semiBold).withSize(16)
}

extension UIFont.Brimo.Body {
    static let largeRegular: UIFont = BrimoTypography.configureFont(.regular).withSize(14)
    static let largeSemiBold: UIFont = BrimoTypography.configureFont(.semiBold).withSize(14)
    static let mediumRegular: UIFont = BrimoTypography.configureFont(.regular).withSize(12)
    static let mediumSemiBold: UIFont = BrimoTypography.configureFont(.semiBold).withSize(12)
    static let smallRegular: UIFont = BrimoTypography.configureFont(.regular).withSize(10)
    static let smallSemiBold: UIFont = BrimoTypography.configureFont(.semiBold).withSize(10)
}
