//
//  CollapsibleTextViewController.swift
//  BottomSheetViewControllerExample
//
//  Created by PT Diksha Teknologi Indonesia on 28/06/25.
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

    private var isExpanded = false

    private let doneBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Selesai", for: .normal)
        btn.backgroundColor = UIColor.blue
        btn.layer.cornerRadius = 28
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()

    private let backgroundDoneBtnView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        configureDetailViewData()
        setupLayout()
    }

    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubview(headerView)
        contentView.addSubview(depositDetailView)
        contentView.addSubview(infoView)
        contentView.addSubview(recommendedProductsView)

        view.addSubview(backgroundDoneBtnView)
        backgroundDoneBtnView.addSubview(doneBtn)

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
}
