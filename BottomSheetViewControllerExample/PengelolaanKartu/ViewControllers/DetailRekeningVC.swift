//
//  DetailRekeningVC.swift
//  BottomSheetViewControllerExample
//
//  Created by Bukhari Muslim on 17/07/25.
//

import UIKit
import SnapKit

struct DetailRekeningViewModel {
    let amount: String
    let date: String
    let remark: String
    let reference: String
    let transactionType: String
    let destinationAccount: String
    let destinationAccountNumber: String
    let additionalAmount: String
}

final class DetailRekeningVC: UIViewController {
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

    // TODO: - Later should support from api
    var viewModel: DetailRekeningViewModel?

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
    
    init(viewModel: DetailRekeningViewModel? = nil) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        configureDetailViewData()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ConstantsColor.black100
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false

        setupLayout()
        
        navigationController?.navigationBar.isHidden = true
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
        
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(backgroundDoneBtnView.snp.top)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView.snp.width)
        }
        
        backgroundImgView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(812)
        }
        
        headerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(safeAreaTopHeight())
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
            title: "Lihat Detail",
            isToggleable: true,
            compactVisibleRows: 3,
            addBRIDescription: true,
            descHeading: "Informasi Hubungi Call Center 789",
            descContent: "Biaya Termasuk PPN (Apabila Dikenakan/Apabila Ada)\nPT. Bank Rakyat Indonesia (Persero) Tbk. Kantor Pusat\nBRI - Jakarta Pusat\nNPWP : 01.001.608.7-093.000"
        )
        
        depositDetailView.backgroundColor = ConstantsColor.white900
    }
}
