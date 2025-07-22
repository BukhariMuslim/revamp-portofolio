//
//  RiwayatMutasiMockData.swift
//  BottomSheetViewControllerExample
//
//  Created by sia santos on 17/07/25.
//

import UIKit

class RiwayatMutasiMockData {
    
    func loadMockCarDetail(id: String, name: String) -> RiwayatMutasiCardDetailModel {
        let mock1 = RiwayatMutasiCardDetailModel(
            cardId: "\(id)",
            name: "mock \(name)",
            cardImage: "kartu_debit_bg"
        )
        
        return mock1
    }
    
    func loadSampleData() -> [RiwayatMutasiModel] {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.locale = Locale(identifier: "id_ID")

        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm:ss"
        formatter.locale = Locale(identifier: "id_ID")

        let june14Data = RiwayatMutasiModel(
            tanggalMutasi: formatter.date(from: "2025-06-14 00:00:00")!,
            riwayatMutasiItemModel: [
                RiwayatMutasiItemModel(
                    transactionID: "BRIVA30135218384728938NBM",
                    description: "BN*** A*** W**",
                    price: "-Rp31.000,00",
                    time: timeFormatter.date(from: "12:30:21")!,
                    transactionType: "Uang Keluar",
                    cardID: "6013 3455 0999 120"
                ),
                RiwayatMutasiItemModel(
                    transactionID: "QRISTRF7411084763726#17472627362762736",
                    description: "2627362762736",
                    price: "-Rp20.000,00",
                    time: timeFormatter.date(from: "12:30:21")!,
                    transactionType: "Uang Keluar",
                    cardID: "6013 3455 0999 120"
                ),
                RiwayatMutasiItemModel(
                    transactionID: "Pembayaran Tokopedia",
                    description: "0857****896 via Qitta",
                    price: "-Rp101.000,00",
                    time: timeFormatter.date(from: "12:30:21")!,
                    transactionType: "Uang Keluar",
                    cardID: "6013 3455 0999 120"
                ),
            ]
        )
        
        let june13Data = RiwayatMutasiModel(
            tanggalMutasi: formatter.date(from: "2025-06-13 00:00:00")!,
            riwayatMutasiItemModel: [
                RiwayatMutasiItemModel(
                    transactionID: "QRISTRF7411084763726#17472627362762736",
                    description: "2627362762736",
                    price: "+Rp280.000,00",
                    time: timeFormatter.date(from: "12:30:21")!,
                    transactionType: "Uang Masuk",
                    cardID: "6013 3455 0999 120"
                ),
                RiwayatMutasiItemModel(
                    transactionID: "Admin Fee",
                    description: nil,
                    price: "-Rp5.500,00",
                    time: timeFormatter.date(from: "12:30:21")!,
                    transactionType: "Uang Keluar",
                    cardID: "6013 3455 0999 120"
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
                    time: timeFormatter.date(from: "10:15:30")!,
                    transactionType: "Uang Keluar",
                    cardID: "6013 3455 0999 121"
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
                    time: timeFormatter.date(from: "09:00:00")!,
                    transactionType: "Uang Masuk",
                    cardID: "6013 3455 0999 121"
                ),
                RiwayatMutasiItemModel(
                    transactionID: "Admin Fee",
                    description: nil,
                    price: "-Rp5.500,00",
                    time: timeFormatter.date(from: "12:30:21")!,
                    transactionType: "Uang Keluar",
                    cardID: "6013 3455 0999 122"
                ),
                RiwayatMutasiItemModel(
                    transactionID: "Admin Fee",
                    description: nil,
                    price: "-Rp5.500,00",
                    time: timeFormatter.date(from: "12:30:21")!,
                    transactionType: "Uang keluar",
                    cardID: "6013 3455 0999 122"
                )
            ]
        )
        
        let january = RiwayatMutasiModel(
            tanggalMutasi: formatter.date(from: "2025-01-20 00:00:00")!,
            riwayatMutasiItemModel: [
                RiwayatMutasiItemModel(
                    transactionID: "Salary",
                    description: "Monthly Salary",
                    price: "+Rp5.000.000,00",
                    time: timeFormatter.date(from: "09:00:00")!,
                    transactionType: "Uang Masuk",
                    cardID: "6013 3455 0999 122"
                )
            ]
        )
        
        let january2 = RiwayatMutasiModel(
            tanggalMutasi: formatter.date(from: "2025-01-02 00:00:00")!,
            riwayatMutasiItemModel: [
                RiwayatMutasiItemModel(
                    transactionID: "Salary",
                    description: "Monthly Salary",
                    price: "+Rp5.000.000,00",
                    time: timeFormatter.date(from: "09:00:00")!,
                    transactionType: "Uang Masuk",
                    cardID: "6013 3455 0999 122"

                ),
                RiwayatMutasiItemModel(
                    transactionID: "Salary",
                    description: "Monthly Salary",
                    price: "+Rp5.000.000,00",
                    time: timeFormatter.date(from: "10:00:00")!,
                    transactionType: "Uang Masuk",
                    cardID: "6013 3455 0999 122"
                )
            ]
        )
        
        let febuari = RiwayatMutasiModel(
            tanggalMutasi: formatter.date(from: "2025-02-20 00:00:00")!,
            riwayatMutasiItemModel: [
                RiwayatMutasiItemModel(
                    transactionID: "Salary",
                    description: "Monthly Salary",
                    price: "+Rp5.000.000,00",
                    time: timeFormatter.date(from: "09:00:00")!,
                    transactionType: "Uang Masuk",
                    cardID: "6013 3455 0999 121"
                )
            ]
        )
        
        let hariIni = RiwayatMutasiModel(
            tanggalMutasi: Date(),
            riwayatMutasiItemModel: [
                RiwayatMutasiItemModel(
                    transactionID: "Salary",
                    description: "Monthly Salary",
                    price: "+Rp5.000.000,00",
                    time: timeFormatter.date(from: "09:00:00")!,
                    transactionType: "Uang Masuk",
                    cardID: "6013 3455 0999 121"
                )
            ]
        )
        
        let hari7 = RiwayatMutasiModel(
            tanggalMutasi: formatter.date(from: "2025-07-15 00:00:00")!,
            riwayatMutasiItemModel: [
                RiwayatMutasiItemModel(
                    transactionID: "Salary",
                    description: "Monthly Salary",
                    price: "+Rp5.000.000,00",
                    time: timeFormatter.date(from: "09:00:00")!,
                    transactionType: "Uang Masuk",
                    cardID: "6013 3455 0999 121"
                )
            ]
        )
        
        return [june14Data, june13Data, mayData, aprilData, january, january2, febuari, hari7, hariIni]
    }
}
