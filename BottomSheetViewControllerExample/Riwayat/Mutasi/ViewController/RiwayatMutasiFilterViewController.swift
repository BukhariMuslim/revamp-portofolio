//
//  RiwayatMutasiFilterViewController.swift
//  BottomSheetViewControllerExample
//
//  Created by sia santos on 17/07/25.
//

import UIKit
import SnapKit

final class RiwayatMutasiFilterViewController: BrimonsBottomSheetVC {
    
    private let backgroundContainerView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "background_blue_secondary")
        return img
    }()
    
    private let roundBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.Brimo.White.main
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.Brimo.White.main
        return view
    }()
    
    private let dateRangeSection = RiwayatMutasiFilterSectionCellView()
    private let accountSection = RiwayatMutasiFilterSectionCellView()
    private let transactionTypeSection = TransactionTypeCollectionView()
    
    private let applyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Simpan", for: .normal)
        button.setTitleColor(UIColor.Brimo.White.main, for: .normal)
        button.backgroundColor = UIColor.Brimo.Primary.main
        button.layer.cornerRadius = 25
        button.titleLabel?.font = UIFont.Brimo.Title.mediumSemiBold
        return button
    }()
    
    // Filter data
    private var selectedStartDate = Date()
    private var selectedEndDate = Date()
    private var selectedAccount = "Semua Rekening"
    private var selectedTransactionType: TransactionType = .all
    
    var onFilterApplied: ((Date, Date, String, TransactionType) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupView()
        setupConstraints()
        setupActions()
        setupInitialData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Filter"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        roundBackgroundView.roundCorners(corners: [.topLeft, .topRight], radius: 24)
    }
    
    private func setupNavigationBar() {
        
        // Reset button
        let resetButton = UIBarButtonItem(
            title: "Reset",
            style: .plain,
            target: self,
            action: #selector(resetButtonTapped)
        )
        resetButton.tintColor = UIColor.Brimo.White.main
        navigationItem.rightBarButtonItem = resetButton
        
        // Back button color
        navigationController?.navigationBar.tintColor = UIColor.Brimo.White.main
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        view.addSubviews(backgroundContainerView, roundBackgroundView)
        roundBackgroundView.addSubviews(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubviews(
            dateRangeSection,
            accountSection,
            transactionTypeSection
        )
        
        view.addSubview(applyButton)
    }
    
    private func setupConstraints() {
        
        backgroundContainerView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
        
        roundBackgroundView.snp.remakeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(applyButton.snp.top).offset(-20)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        dateRangeSection.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        accountSection.snp.makeConstraints { make in
            make.top.equalTo(dateRangeSection.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        transactionTypeSection.snp.makeConstraints { make in
            make.top.equalTo(accountSection.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        applyButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }
    
    private func setupActions() {
        
        dateRangeSection.onTapped = { [weak self] in
            self?.showDateRangePicker()
        }
        
        accountSection.onTapped = { [weak self] in
            self?.showAccountSelector()
        }
        
        transactionTypeSection.onSelectionChanged = { [weak self] type in
            self?.selectedTransactionType = type
        }
        
        applyButton.addTarget(self, action: #selector(applyButtonTapped), for: .touchUpInside)
    }
    
    private func setupInitialData() {
        selectedEndDate = Date()
        selectedStartDate = Calendar.current.date(byAdding: .day, value: -30, to: selectedEndDate) ?? Date()
        
        // Configure date range section
        let dateRangeData = RiwayatMutasiFilterSectionCellData(
            title: "Pilih Rentang Waktu",
            value: "",
            systemIconName: "calendar"
        )
        dateRangeSection.configure(with: dateRangeData)
        
        // Configure account section
        let accountData = RiwayatMutasiFilterSectionCellData(
            title: "Sumber Rekening",
            value: selectedAccount,
            systemIconName: "chevron.down"
        )
        accountSection.configure(with: accountData)
        
        // Configure transaction type section
        transactionTypeSection.setSelectedType(selectedTransactionType)
        applyButton.isEnabled = false
    }
    
    private func formatDateRange(start: Date, end: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM"
        formatter.locale = Locale(identifier: "id_ID")
        
        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "yyyy"
        
        let startDateString = formatter.string(from: start)
        let endDateString = formatter.string(from: end)
        let year = yearFormatter.string(from: end)
        
        return "\(startDateString) - \(endDateString) \(year)"
    }
    
    @objc private func resetButtonTapped() {
        selectedTransactionType = .all
        setupInitialData()
    }
    
    @objc private func applyButtonTapped() {
        onFilterApplied?(selectedStartDate, selectedEndDate, selectedAccount, selectedTransactionType)
        navigationController?.popViewController(animated: true)
    }
    
    private func showAccountSelector() {
        let dateRangePicker: ReusableBottomSheetViewController = ReusableBottomSheetViewController.create(
            title: "Sumber Rekening",
            contentView: UIView()
        )
        
        self.presentBrimonsBottomSheet(viewController: dateRangePicker)
    }
    
    private func showDateRangePicker() {
        let dateRangePicker: ReusableBottomSheetViewController = ReusableBottomSheetViewController.create(
            title: "Pilih Tanggal",
            contentView: UIView()
        )
        
        self.presentBrimonsBottomSheet(viewController: dateRangePicker)
    }
    
    private func dismissDateRangePicker() {
        guard let dateRangePicker = view.viewWithTag(999) else { return }
        
        UIView.animate(withDuration: 0.3, animations: {
            dateRangePicker.alpha = 0
        }) { _ in
            dateRangePicker.removeFromSuperview()
        }
    }
}

extension RiwayatMutasiFilterViewController {
    static func create(
        onFilterApplied: @escaping (Date, Date, String, TransactionType) -> Void
    ) -> RiwayatMutasiFilterViewController {
        let controller = RiwayatMutasiFilterViewController()
        controller.onFilterApplied = onFilterApplied
        return controller
    }
}
