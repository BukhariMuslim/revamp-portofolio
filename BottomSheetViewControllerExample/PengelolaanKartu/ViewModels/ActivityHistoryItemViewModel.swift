//
//  ActivityHistoryItemViewModel.swift
//  BottomSheetViewControllerExample
//
//  Created by Bukhari Muslim on 17/07/25.
//

struct ActivityHistoryItemViewModel {
    let id: String?
    let iconName: String
    let iconPath: String
    let title: String
    let subTitle: String
    let referenceNumber: String
    let date: String
    let amount: String
    let status: String
    
    init(
        id: String? = nil,
        iconName: String,
        iconPath: String,
        title: String,
        subTitle: String,
        referenceNumber: String,
        date: String,
        amount: String,
        status: String
    ) {
        self.id = id
        self.iconName = iconName
        self.iconPath = iconPath
        self.title = title
        self.subTitle = subTitle
        self.referenceNumber = referenceNumber
        self.date = date
        self.amount = amount
        self.status = status
    }
}
