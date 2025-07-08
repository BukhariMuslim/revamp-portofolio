//
//  KonfirmasiSetoranPembukaanRekeningViewController.swift
//  BottomSheetViewControllerExample
//
//  Created by PT Diksha Teknologi Indonesia on 28/06/25.
//


import UIKit
import SnapKit

class AccountOpeningDepositConfirmationVC: UIViewController {

    // MARK: - UI Components
    private let backgroundContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()

    private let scrollContentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let initialDepositView = InitialDepositDetailView()
    private let fundingSourceSectionView = FundingSourceSectionView()
    private let branchOpeningView = BranchOpeningView()
    
    private let openRekeningBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Buka Tabungan", for: .normal)
        btn.backgroundColor = UIColor.blue
        btn.layer.cornerRadius = 28
        return btn
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
        view.backgroundColor = .blue
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let screenHeight = UIScreen.main.bounds.height
        let offsetTop: CGFloat = 100 // sama seperti offset backgroundContainerView
        let openRekeningBtnHeight: CGFloat = 56 + view.safeAreaInsets.bottom // + bottom safe area

        let availableHeight = screenHeight - offsetTop - openRekeningBtnHeight

        let contentHeight = scrollContentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height

        scrollView.isScrollEnabled = contentHeight > availableHeight
    }

    // MARK: - Setup Methods

    private func setupView() {
        title = "Konfirmasi Setoran"
        view.backgroundColor = .white

        view.addSubview(backgroundContainerView)
        view.addSubview(openRekeningBtn)
        backgroundContainerView.addSubview(scrollView)
        scrollView.addSubview(scrollContentView)
        scrollContentView.addSubview(initialDepositView)
        scrollContentView.addSubview(fundingSourceSectionView)
        scrollContentView.addSubview(branchOpeningView)
        
        let data: [(String, String)] = [
            ("Jenis Transaksi", "Pembukaan Tabungan BRitAma"),
            ("Setoran Awal", "Rp 1,000,000"),
            ("Biaya Adming", "Rp 0")
        ]

        initialDepositView.configure(with: data)
        
        fundingSourceSectionView.configure(
            image: UIImage(named: "sampleImage"),
            title: "Platinum Account",
            subtitle: "Active until Dec 2025"
        )
        
        branchOpeningView.configure(title: "Tabunganmu terdaftar di", subtitle: "KCP Bendungan Hilir Jakarta")
    }

    private func setupLayout() {
        backgroundContainerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(100)
            $0.bottom.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview()
        }

        scrollView.snp.makeConstraints {
            $0.top.trailing.leading.equalToSuperview()
            $0.bottom.equalTo(openRekeningBtn.snp.top).inset(10)
        }

        scrollContentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView.snp.width)
        }
        
        initialDepositView.snp.remakeConstraints {
            $0.top.equalTo(scrollContentView.safeAreaLayoutGuide).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        fundingSourceSectionView.snp.remakeConstraints {
            $0.top.equalTo(initialDepositView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        branchOpeningView.snp.remakeConstraints {
            $0.top.equalTo(fundingSourceSectionView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(scrollContentView.snp.bottom).inset(10)
        }
        
        openRekeningBtn.snp.remakeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(56)
        }
        
        
    }
}



