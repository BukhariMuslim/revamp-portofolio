//
//  RiwayatMutasiViewModel.swift
//  BottomSheetViewControllerExample
//
//  Created by sia santos on 18/07/25.
//

import UIKit

class RiwayatMutasiViewModel {
    
    var onSaveFilter: (() -> Void)?
    var onTapMonthFilter: (() -> Void)?
    
    var mutasiData: [RiwayatMutasiModel] = []
    var allMutasiData: [RiwayatMutasiModel] = []
    var selectedMonthIndex: Int? = nil
    
    func filterDataByMonth(selectedMonth: Int = 0) {
        if let selectedIndex = selectedMonthIndex {
            let selectedMonth = selectedIndex + 1
            
            mutasiData = allMutasiData.filter { model in
                let calendar = Calendar.current
                let month = calendar.component(.month, from: model.tanggalMutasi)
                return month == selectedMonth
            }
        } else if selectedMonth > 0  {
            mutasiData = allMutasiData.filter { model in
                let calendar = Calendar.current
                let month = calendar.component(.month, from: model.tanggalMutasi + Double(selectedMonth))
                return month == selectedMonth
            }
        } else {
            mutasiData = allMutasiData
        }
        
        self.onTapMonthFilter?()
    }
    
    func filterDataBy(
        startDate: Date,
        endDate: Date,
        transactionType: TransactionType,
        rekeningNumber: String)
    {
        let filteredByMonthsData = filterMutasi(
            models: allMutasiData,
            startDate: startDate,
            endDate: endDate,
            selectedType: transactionType,
            selectedRekeningId: rekeningNumber
        )
        
        mutasiData = filteredByMonthsData
        self.onSaveFilter?()
    }
    
    private func filterMutasi(
        models: [RiwayatMutasiModel],
        startDate: Date,
        endDate: Date,
        selectedType: TransactionType,
        selectedRekeningId: String,
        calendar: Calendar = .current
    ) -> [RiwayatMutasiModel] {
        
        let startOfDay = calendar.startOfDay(for: startDate)
        guard let dayAfterEnd = calendar.date(
            byAdding: .day,
            value: 1,
            to: calendar.startOfDay(for: endDate)
        ) else {
            return []
        }
        
        let shouldFilterByRekeningCard = selectedRekeningId.isEmpty
        
        return models.compactMap { model in
            let modelDay = calendar.startOfDay(for: model.tanggalMutasi)
            
            guard modelDay >= startOfDay, modelDay < dayAfterEnd else {
                return nil
            }
            
            let filteredItems = model.riwayatMutasiItemModel.filter { item in
                let itemType = TransactionType.from(title: item.transactionType)
                let typeMatch = (selectedType == .all) || (itemType == selectedType)
                
                let rekeningMatch = shouldFilterByRekeningCard || item.cardID == selectedRekeningId
                
                return typeMatch && rekeningMatch
            }
            
            guard !filteredItems.isEmpty else {
                return nil
            }
            
            return RiwayatMutasiModel(
                tanggalMutasi: model.tanggalMutasi,
                riwayatMutasiItemModel: filteredItems
            )
        }
    }
}
