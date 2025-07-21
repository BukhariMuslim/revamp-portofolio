//
//  MainHelper.swift
//  BottomSheetViewControllerExample
//
//  Created by Bukhari Muslim on 08/07/25.
//

import Foundation
import UIKit

typealias EventHandler = () -> Void

extension String {
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return ceil(boundingBox.width)
    }
}

