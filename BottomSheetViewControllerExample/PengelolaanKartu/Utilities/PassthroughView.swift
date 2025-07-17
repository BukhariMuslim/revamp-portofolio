//
//  PassthroughView.swift
//  BottomSheetViewControllerExample
//
//  Created by Bukhari Muslim on 17/07/25.
//

import UIKit

final class PassthroughView: UIView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard self.isUserInteractionEnabled, !self.isHidden, self.alpha >= 0.01 else {
            return nil
        }

        for subview in subviews.reversed() {
            let pointInSubview = subview.convert(point, from: self)
            if let hit = subview.hitTest(pointInSubview, with: event) {
                if shouldAllowHit(for: hit) {
                    return hit
                }
            }
        }

        return nil
    }

    private func shouldAllowHit(for view: UIView) -> Bool {
        if view is UIControl { return true }
        if view.gestureRecognizers?.isEmpty == false { return true }

        return false
    }
}
