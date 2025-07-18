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
    let transactionType: String
    let cardID: String
    
    enum CodingKeys: String, CodingKey {
        case transactionID = "transactionID"
        case description = "description"
        case price = "price"
        case time = "time"
        case transactionType = "transactionType"
        case cardID = "cardID"
    }
}

struct RiwayatMutasiCardDetailModel: Codable {
    let cardId: String
    let name: String
    let cardImage: String
    
    enum CodingKeys: String, CodingKey {
        case cardId = "cardId"
        case name = "name"
        case cardImage = "cardImage"
    }
}
