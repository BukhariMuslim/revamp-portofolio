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
        let mockData1 = mockDataProvider.loadMockCarDetail(id: "6013 3455 0999 120", name: "@marselasatya")
        let mockData2 = mockDataProvider.loadMockCarDetail(id: "6013 3455 0999 121", name: "@marselasatya2")
        let mockData3 = mockDataProvider.loadMockCarDetail(id: "6013 3455 0999 122", name: "@marselasatya3")
        
        self.data = [mockData1, mockData2, mockData3]
    }
    
    func getAllData() -> [RiwayatMutasiCardDetailModel] {
        return data
    }
    
    func getDataCount() -> Int {
        return data.count
    }
}
