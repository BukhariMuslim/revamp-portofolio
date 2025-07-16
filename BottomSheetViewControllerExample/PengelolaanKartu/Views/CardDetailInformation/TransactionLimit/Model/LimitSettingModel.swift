//
//  LimitSettingModel.swift
//  BottomSheetViewControllerExample
//
//  Created by sia santos on 15/07/25.
//

import Foundation

struct LimitSettingModel: Codable {
    
    let topLeftIcon: String
    let topSubtitleLabel: String
    let bottomSubtitleLabel: String
    let isPremiumBadge: Bool
    let minimimumLimit: Double
    let maximumLimit: Double
    
    enum CodingKeys: String, CodingKey {
        case topLeftIcon = "topLeftIcon"
        case topSubtitleLabel = "topSubtitleLabel"
        case bottomSubtitleLabel = "bottomSubtitleLabel"
        case isPremiumBadge = "badgeType"
        case minimimumLimit = "minimimumLimit"
        case maximumLimit = "maximumLimit"
    }
}
