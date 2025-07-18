//
//  SumberRekeningViewModel.swift
//  BottomSheetViewControllerExample
//
//  Created by sia santos on 18/07/25.
//

import Foundation

class SumberRekeningViewModel {
    
    var data: [RiwayatMutasiCardDetailModel] = []
    
    private let mockDataProvider = RiwayatMutasiMockData()
    
    func getCardDetailData() {
        //TODO: Santos to remove mock and use actual data fromApi
        let mockData1 = mockDataProvider.loadMockCarDetail(id: "12989328", name: "Personal")
        let mockData2 = mockDataProvider.loadMockCarDetail(id: "21291288", name: "Business")
        let mockData3 = mockDataProvider.loadMockCarDetail(id: "31298219", name: "Savings")
        let mockData4 = mockDataProvider.loadMockCarDetail(id: "41298219", name: "Investment")
        
        self.data = [mockData1, mockData2, mockData3, mockData4]
    }
    
    func getAllData() -> [RiwayatMutasiCardDetailModel] {
        return data
    }
    
    func getDataCount() -> Int {
        return data.count
    }
}
