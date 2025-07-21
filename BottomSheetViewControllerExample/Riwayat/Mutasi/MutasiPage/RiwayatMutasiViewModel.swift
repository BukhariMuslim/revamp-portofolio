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
    
    func filterDataByMonth() {
        if let selectedIndex = selectedMonthIndex {
            let selectedMonth = selectedIndex + 1
            
            mutasiData = allMutasiData.filter { model in
                let calendar = Calendar.current
                let month = calendar.component(.month, from: model.tanggalMutasi)
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
        rekeningNumber: String
    ) {
        let filteredData = filterMutasi(
            models: allMutasiData,
            startDate: startDate,
            endDate: endDate,
            selectedType: transactionType,
            selectedRekeningId: rekeningNumber
        )
        
        mutasiData = filteredData
        self.onSaveFilter?()
    }
    
    private func filterMutasi(
        models: [RiwayatMutasiModel],
        startDate: Date,
        endDate: Date,
        selectedType: TransactionType,
        selectedRekeningId: String
    ) -> [RiwayatMutasiModel] {
        
        let calendar: Calendar = .current
        let startOfDay = calendar.startOfDay(for: startDate)
        let endOfDay = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: endDate) ?? endDate
        
        let shouldFilterByRekeningCard = !selectedRekeningId.isEmpty && selectedRekeningId != "Semua Rekening"
        
        return models.compactMap { model in
            let modelDate = model.tanggalMutasi
            
            guard modelDate >= startOfDay && modelDate <= endOfDay else {
                return nil
            }
            
            let filteredItems = model.riwayatMutasiItemModel.filter { item in
                let itemType = TransactionType.from(title: item.transactionType)
                let typeMatch = (selectedType == .all) || (itemType == selectedType)
                
                let rekeningMatch = !shouldFilterByRekeningCard || item.cardID == selectedRekeningId
                
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
