//
//  RiwayatMutasiMockData.swift
//  BottomSheetViewControllerExample
//
//  Created by sia santos on 17/07/25.
//

import UIKit

class RiwayatMutasiMockData {
    
    func loadSampleData() -> [RiwayatMutasiModel] {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm:ss"
        
        let june14Data = RiwayatMutasiModel(
            tanggalMutasi: formatter.date(from: "2025-06-14 00:00:00")!,
            riwayatMutasiItemModel: [
                RiwayatMutasiItemModel(
                    transactionID: "BRIVA30135218384728938NBM",
                    description: "BN*** A*** W**",
                    price: "-Rp31.000,00",
                    time: timeFormatter.date(from: "12:30:21")!
                ),
                RiwayatMutasiItemModel(
                    transactionID: "QRISTRF7411084763726#17472627362762736",
                    description: "2627362762736",
                    price: "-Rp20.000,00",
                    time: timeFormatter.date(from: "12:30:21")!
                ),
                RiwayatMutasiItemModel(
                    transactionID: "Pembayaran Tokopedia",
                    description: "0857****896 via Qitta",
                    price: "-Rp101.000,00",
                    time: timeFormatter.date(from: "12:30:21")!
                )
            ]
        )
        
        let june13Data = RiwayatMutasiModel(
            tanggalMutasi: formatter.date(from: "2025-06-13 00:00:00")!,
            riwayatMutasiItemModel: [
                RiwayatMutasiItemModel(
                    transactionID: "QRISTRF7411084763726#17472627362762736",
                    description: "2627362762736",
                    price: "+Rp280.000,00",
                    time: timeFormatter.date(from: "12:30:21")!
                ),
                RiwayatMutasiItemModel(
                    transactionID: "Admin Fee",
                    description: nil,
                    price: "-Rp5.500,00",
                    time: timeFormatter.date(from: "12:30:21")!
                )
            ]
        )
        
        let mayData = RiwayatMutasiModel(
            tanggalMutasi: formatter.date(from: "2025-05-15 00:00:00")!,
            riwayatMutasiItemModel: [
                RiwayatMutasiItemModel(
                    transactionID: "Transfer Bank",
                    description: "To: John Doe",
                    price: "-Rp50.000,00",
                    time: timeFormatter.date(from: "10:15:30")!
                )
            ]
        )
        
        let aprilData = RiwayatMutasiModel(
            tanggalMutasi: formatter.date(from: "2025-04-20 00:00:00")!,
            riwayatMutasiItemModel: [
                RiwayatMutasiItemModel(
                    transactionID: "Salary",
                    description: "Monthly Salary",
                    price: "+Rp5.000.000,00",
                    time: timeFormatter.date(from: "09:00:00")!
                )
            ]
        )
        
        return [june14Data, june13Data, mayData, aprilData]
    }
}
