//
//  DetailRekeningViewModel.swift
//  BottomSheetViewControllerExample
//
//  Created by Bukhari Muslim on 18/07/25.
//


struct DetailRekeningViewModel {
    let amountDataView: [ReceiptDataViewViewModel]
    let billingDetail: SourceDetailViewModel
    let closeButtonString: String
    let dataViewTransaction: [ReceiptDataViewViewModel]
    let dateTransaction: String
    let footer: String
    let footerHtml: String
    let headerDataView: [ReceiptDataViewViewModel]
    let helpFlag: Bool
    let immediatelyFlag: Bool
    let onProcess: Bool
    let referenceNumber: String
    let rowDataShow: Int
    let share: Bool
    let shareButtonString: String
    let sourceAccountDataView: SourceDetailViewModel
    let title: String
    let titleImage: String
    let totalDataView: [ReceiptDataViewViewModel]
    let voucherDataView: [ReceiptDataViewViewModel]
}
