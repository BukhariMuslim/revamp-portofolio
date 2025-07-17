//
//  Helper.swift
//  BottomSheetViewControllerExample
//
//  Created by Phincon on 07/07/25.
//

import Foundation
import UIKit

extension UIView {
    func addSubviews(_ views: UIView...){
        views.forEach { addSubview($0)}
    }
}


extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func borderAndCorner(cornerRadious: CGFloat, borderWidth: CGFloat, borderColor: UIColor?) {
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadious
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor?.cgColor
    }
}

extension UIView {
    func addTapGesture(target: Any?, action: Selector?) {
        let tap = UITapGestureRecognizer(target: target, action: action)
        addGestureRecognizer(tap)
    }
    
    func addDottedBorder(color: UIColor, lineWidth: CGFloat, lineDashPattern: [NSNumber]) {
        DispatchQueue.main.async {
            let borderLayer = CAShapeLayer()
            borderLayer.strokeColor = color.cgColor
            borderLayer.lineDashPattern = lineDashPattern
            borderLayer.lineWidth = lineWidth
            borderLayer.fillColor = nil
            
            let path = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius)
            borderLayer.path = path.cgPath
            
            self.layer.addSublayer(borderLayer)
        }
    }
    
    func cornerRadius(_ size: CGFloat) {
        self.layer.cornerRadius = size
    }
}
