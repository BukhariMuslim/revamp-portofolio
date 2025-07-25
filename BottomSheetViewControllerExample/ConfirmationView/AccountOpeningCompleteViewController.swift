//
//  AccountOpeningCompleteViewController.swift
//  brimo-native
//
//  Created by PT Diksha Teknologi Indonesia on 05/07/25.
//  Copyright © 2025 BRImo. All rights reserved.
//


import UIKit
import Foundation
import SnapKit

final class AccountOpeningCompleteViewController: UIViewController {

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    

    private let headerView = AccountOpeningCompleteHeaderView()
    private var depositDetailView: KeyValueComponentView!
    private let infoView = AccountSuccessOpenInfoView()
    private let recommendedProductsView = RecommendedProductsView()
    
    private lazy var backgroundImgView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "recipe_success_ic")
        return image
    }()

    // later should support from api
    // api still on progress
//    var receiptData: OpenAccountReceiptResponseData?{
//        didSet {
//            if let receiptData {
////                headerView.configure(title: "Berhasil! Tabungan Baru Kamu Siap Digunakan", date: receiptData.referenceDataView?.first?.value ?? "", image: UIImage(named: "coin_success"), name: <#T##String#>, accountNumber: <#T##String#>)
////                OpenAccountReceiptResponseData
//            }
//        }
//    }

    private let doneBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Selesai", for: .normal)
        btn.setTitleColor(ConstantsColor.white900, for: .normal)
        btn.titleLabel?.font = UIFont.Brimo.Body.largeSemiBold
        btn.backgroundColor = ConstantsColor.blue500
        btn.layer.cornerRadius = 28
        return btn
    }()

    private let backgroundDoneBtnView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ConstantsColor.black100
        scrollView.backgroundColor = .clear

        configureDetailViewData()
        setupLayout()
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubview(backgroundImgView)
        contentView.addSubview(headerView)
        contentView.addSubview(depositDetailView)
        contentView.addSubview(infoView)
        contentView.addSubview(recommendedProductsView)

        view.addSubview(backgroundDoneBtnView)
        backgroundDoneBtnView.addSubview(doneBtn)
        
        backgroundImgView.snp.remakeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.height.equalTo(812)
        }

        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(backgroundDoneBtnView.snp.top)
        }

        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView.snp.width)
        }

        headerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }

        depositDetailView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        infoView.snp.makeConstraints {
            $0.top.equalTo(depositDetailView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
        }

        recommendedProductsView.snp.makeConstraints {
            $0.top.equalTo(infoView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(220)
            $0.bottom.equalToSuperview().inset(16)
        }

        backgroundDoneBtnView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(96)
        }

        doneBtn.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(56)
        }
        
        doneBtn.addTarget(self, action: #selector(back), for: .touchUpInside)
    }

    private func configureDetailViewData() {
        let items: [DepositoKeyValueItemSet] = [
            .init(key: "No. Referensi", value: "79102630924040", keyValueStyle: .none, showSeparator: false),
            .init(key: "Jangka Waktu", value: "1 bulan", keyValueStyle: .none, showSeparator: false),
            .init(key: "Jatuh Tempo", value: "10 Jan 2025", keyValueStyle: .none, showSeparator: false),
            .init(key: "Suku Bunga", value: "2,25% p.a", keyValueStyle: .keyOnlyAsTitle, showSeparator: false),
            .init(key: "Jenis Perpanjangan", value: "Perpanjangan Pokok Saja", keyValueStyle: .none, showSeparator: true),
            .init(key: "Rekening Pencairan", value: "", keyValueStyle: .keyOnlyAsTitle, showSeparator: false),
            .init(key: "No Rekening", value: "4423 2321 8821 129", keyValueStyle: .none, showSeparator: false),
            .init(key: "Nama Pemilik", value: "Antonious Julio", keyValueStyle: .none, showSeparator: true)
        ]

        depositDetailView = KeyValueComponentView(
            items: items,
            title: "Detail Transaksi",
            isToggleable: true,
            compactVisibleRows: 3,
            addBRIDescription: true,
            descHeading: "Informasi Hubungi Call Center 789",
            descContent: "Biaya Termasuk PPN (Apabila Dikenakan/Apabila Ada)\nPT. Bank Rakyat Indonesia (Persero) Tbk. Kantor Pusat\nBRI - Jakarta Pusat\nNPWP : 01.001.608.7-093.000"
        )
    }
    
    @objc
    private func back() {
        navigationController?.popViewController(animated: true)
    }
}
