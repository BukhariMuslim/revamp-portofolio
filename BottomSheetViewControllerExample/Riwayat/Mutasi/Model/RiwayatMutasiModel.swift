//
//  RiwayatMutasiModel.swift
//  BottomSheetViewControllerExample
//
//  Created by sia santos on 17/07/25.
//

import UIKit

struct RiwayatMutasiModel: Codable {
    let tanggalMutasi: Date
    let riwayatMutasiItemModel: [RiwayatMutasiItemModel]
    
    enum CodingKeys: String, CodingKey {
        case tanggalMutasi = "tanggalMutasi"
        case riwayatMutasiItemModel = "RiwayatMutasiItemModel"
    }
}

struct RiwayatMutasiItemModel: Codable {
    let transactionID: String
    let description: String?
    let price: String
    let time: Date
    
    enum CodingKeys: String, CodingKey {
        case transactionID = "transactionID"
        case description = "description"
        case price = "price"
        case time = "time"
    }
}
