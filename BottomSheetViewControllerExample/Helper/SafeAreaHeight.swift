//
//  SafeAreaHeight.swift
//  BottomSheetViewControllerExample
//
//  Created by Bukhari Muslim on 17/07/25.
//

import UIKit

public func safeAreaTopHeight() -> CGFloat {
    if #available(iOS 13.0, *) {
        let window = UIApplication.shared.windows.first
        return window?.safeAreaInsets.top ?? 0
    } else {
        let window = UIApplication.shared.keyWindow
        return window?.safeAreaInsets.top ?? 0
    }
}

public func safeAreaBottomHeight() -> CGFloat {
    if #available(iOS 13.0, *) {
        let window = UIApplication.shared.windows.first
        return window?.safeAreaInsets.bottom ?? 0
    } else {
        let window = UIApplication.shared.keyWindow
        return window?.safeAreaInsets.bottom ?? 0
    }
}
