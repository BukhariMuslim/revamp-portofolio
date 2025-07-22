//
//  RiwayatMutasiViewModel.swift
//  BottomSheetViewControllerExample
//
//  Created by sia santos on 18/07/25.
//

import UIKit

class RiwayatMutasiViewModel {
    
    var onSaveFilter: ((String, String) -> Void)?
    var onTapMonthFilter: (() -> Void)?
    
    var mutasiData: [RiwayatMutasiModel] = []
    var allMutasiData: [RiwayatMutasiModel] = []
    var selectedAccount = "Semua Rekening"
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
        rekeningNumber: String,
        rekeningName: String
    ) {
        let filteredData = filterMutasi(
            models: allMutasiData,
            startDate: startDate,
            endDate: endDate,
            selectedType: transactionType,
            selectedRekeningId: rekeningNumber
        )
        
        mutasiData = filteredData
        self.onSaveFilter?(rekeningNumber, rekeningName)
    }
    
    func isDefaultDateRange(start: Date, end: Date) -> Bool {
        let calendar = Calendar.current
        let defaultEnd = Date()
        guard let defaultStart = calendar.date(byAdding: .day, value: -30, to: defaultEnd) else {
            return false
        }
        
        return calendar.isDate(start, inSameDayAs: defaultStart) && calendar.isDate(end, inSameDayAs: defaultEnd)
    }
    
    func getFilterText(
        filterType: DateFilterType = .all,
        startDate: Date? = nil,
        endDate: Date? = nil,
        selectedMonth: Date? = nil
    ) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "id_ID")
        
        switch filterType {
        case .today:
            return "Hari Ini"
            
        case .last7Days:
            return "7 Hari Terakhir"
            
        case .selectMonth:
            dateFormatter.dateFormat = "MMMM"
            if let startDate = startDate {
                let monthString = dateFormatter.string(from: startDate)
                return "\(monthString)"
            }
            
            else {
                return "Semua"
            }
            
        case .selectDate:
            if let startDate = startDate, let endDate = endDate {
                dateFormatter.dateFormat = "d MMMM yyyy"
                let startString = dateFormatter.string(from: startDate)
                let endString = dateFormatter.string(from: endDate)
                return "\(startString) - \(endString)"
            } else {
                return "Semua"
            }
            
        case .all:
            return "Semua"
        }
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
        self.selectedAccount = selectedRekeningId.isEmpty ? "Semua Rekening" : selectedRekeningId
        
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
