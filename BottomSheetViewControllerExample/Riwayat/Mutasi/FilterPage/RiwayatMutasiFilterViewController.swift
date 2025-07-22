//
//  RiwayatMutasiFilterViewController.swift
//  BottomSheetViewControllerExample
//
//  Created by sia santos on 17/07/25.
//

import UIKit
import SnapKit

struct FilterPageDataModel {
    let startDate: Date
    let endDate: Date
    let rekeningId: String
    let rekeningName: String
    let transactionType: TransactionType
    let dateFilterType: DateFilterType
}

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
    
    private let dateFilterSection = RiwayatMutasiFilterDateCollectionView()
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
    
    private var selectedStartDate = Date()
    private var selectedEndDate = Date()
    private var selectedMonth = Date()
    private var selectedAccount = "Semua Rekening"
    private var selectedAccountName = ""
    private var selectedTransactionType: TransactionType = .all
    private var selectedDateFilter: DateFilterType = .today
    private var previousSelectedMonth: Int?
    private var previousSelectedYear: Int?
    
    var onFilterApplied: ((FilterPageDataModel) -> Void)?
    
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
        let resetButton = UIBarButtonItem(
            title: "Reset",
            style: .plain,
            target: self,
            action: #selector(resetButtonTapped)
        )
        resetButton.tintColor = UIColor.Brimo.White.main
        navigationItem.rightBarButtonItem = resetButton
        navigationController?.navigationBar.tintColor = UIColor.Brimo.White.main
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        view.addSubviews(backgroundContainerView, roundBackgroundView)
        roundBackgroundView.addSubviews(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubviews(
            dateFilterSection,
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
        
        dateFilterSection.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(300)
        }
        
        accountSection.snp.makeConstraints { make in
            make.top.equalTo(dateFilterSection.snp.bottom).offset(32)
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
        dateFilterSection.onDateFilterSelected = { [weak self] filterType in
            self?.handleDateFilterSelection(filterType)
        }
        
        accountSection.onTapped = { [weak self] in
            self?.showSumberRekening()
        }
        
        transactionTypeSection.onSelectionChanged = { [weak self] type in
            self?.selectedTransactionType = type
        }
        
        applyButton.addTarget(self, action: #selector(applyButtonTapped), for: .touchUpInside)
    }
    
    private func setupInitialData() {
        selectedEndDate = Date()
        selectedStartDate = Calendar.current.date(byAdding: .day, value: -1, to: selectedEndDate) ?? Date()
        
        let accountData = RiwayatMutasiFilterSectionCellData(
            title: "Sumber Rekening",
            value: selectedAccount,
            systemIconName: "chevron.down",
            bankImage: ""
        )
        accountSection.configure(with: accountData, false)
        
        transactionTypeSection.setSelectedType(selectedTransactionType)
        shouldDisableApplyButton(isEnable: false)
    }
    
    private func handleDateFilterSelection(_ filterType: DateFilterType) {
        selectedDateFilter = filterType
        
        let calendar = Calendar.current
        let today = Date()
        
        switch filterType {
        case .today:
            selectedStartDate = calendar.startOfDay(for: today)
            selectedEndDate = today
            shouldDisableApplyButton(isEnable: true)
            
        case .last7Days:
            selectedEndDate = today
            guard let startDate = calendar.date(byAdding: .day, value: -7, to: today) else {
                return
            }
            selectedStartDate = startDate
            shouldDisableApplyButton(isEnable: true)
            
        case .selectMonth:
            showMonthPicker()
            
        case .selectDate:
            showDateRangePickerUpdated()
        case .all:
            break
        }
    }
    
    private func shouldDisableApplyButton(isEnable: Bool) {
        let titleColor = isEnable ? .white : ConstantsColor.black500
        let backgroundColor = isEnable ? UIColor.Brimo.Primary.main : ConstantsColor.black300

        applyButton.backgroundColor = backgroundColor
        applyButton.setTitleColor(titleColor, for: .normal)
        applyButton.isEnabled = isEnable
    }
    
    private func formatDateRange(start: Date, end: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM"
        formatter.locale = Locale(identifier: "id_ID")
        
        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "yyyy"
        
        let startDateString = formatter.string(from: start)
        let yearStartDate = yearFormatter.string(from: start)
        
        let endDateString = formatter.string(from: end)
        let yearEndDate = yearFormatter.string(from: end)
        
        return "\(startDateString) \(yearStartDate) - \(endDateString) \(yearEndDate)"
    }
    
    @objc private func resetButtonTapped() {
        selectedAccount = ""
        selectedTransactionType = .all
        selectedDateFilter = .today
        previousSelectedMonth = nil
        previousSelectedYear = nil
        dateFilterSection.setSelectedFilter(nil)
        setupInitialData()
    }
    
    @objc private func applyButtonTapped() {
        let filterData = FilterPageDataModel(
            startDate: selectedStartDate,
            endDate: selectedEndDate,
            rekeningId: selectedAccount,
            rekeningName: selectedAccountName,
            transactionType: selectedTransactionType,
            dateFilterType: selectedDateFilter
        )
        
        onFilterApplied?(filterData)
        navigationController?.popViewController(animated: true)
    }
}

extension RiwayatMutasiFilterViewController {
    static func create(
        onFilterApplied: @escaping (FilterPageDataModel) -> Void
    ) -> RiwayatMutasiFilterViewController {
        let controller = RiwayatMutasiFilterViewController()
        controller.onFilterApplied = onFilterApplied
        return controller
    }
}

extension RiwayatMutasiFilterViewController {
    
    func showMonthPicker() {
        let monthPickerView = CostumeMonthPickerView()
        
        if let previousMonth = previousSelectedMonth,
           let previousYear = previousSelectedYear {
            monthPickerView.setPreviousSelection(month: previousMonth, year: previousYear)
        }
        
        monthPickerView.onMonthYearSelected = { [weak self] selectedDate in
            guard let self = self else {
                return
            }
            
            let calendar = Calendar.current
            
            guard let startOfMonth = calendar.dateInterval(of: .month, for: selectedDate)?.start else {
                return
            }
            
            guard let endOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth) else {
                return
            }
            
            self.selectedStartDate = startOfMonth
            self.selectedEndDate = endOfMonth
            self.selectedMonth = startOfMonth
            self.shouldDisableApplyButton(isEnable: true)
        }
        
        let monthPicker = ReusableBottomSheetViewController.create(
            title: "Pilih Bulan",
            buttonTitle: "Simpan",
            contentView: monthPickerView,
            onActionTapped: { [weak self] in
                
                guard let self = self else {
                    return
                }
                self.shouldDisableApplyButton(isEnable: true)

                let selection = monthPickerView.getCurrentSelection()
                self.previousSelectedMonth = selection.month
                self.previousSelectedYear = selection.year
                
                self.dismiss(animated: false)
            }
        )
        
        self.presentBrimonsBottomSheet(viewController: monthPicker)
    }
    
    func showDateRangePickerUpdated() {
        let calendarView = CostumCalendarDatePickerView()
        calendarView.setDateRange(startDate: selectedStartDate, endDate: selectedEndDate)
        
        calendarView.onDateRangeSelected = { [weak self] startDate, endDate in
            guard let self = self else {
                return
            }
            
            self.selectedStartDate = startDate
            self.selectedEndDate = endDate
            self.shouldDisableApplyButton(isEnable: true)
        }
        
        let dateRangePicker = ReusableBottomSheetViewController.create(
            title: "Pilih Tanggal",
            buttonTitle: "Simpan",
            contentView: calendarView,
            onActionTapped: { [weak self] in
                guard let self = self else {
                    return
                }
                self.dismiss(animated: false)
            }
        )
        
        self.presentBrimonsBottomSheet(viewController: dateRangePicker)
    }
    
    private func showSumberRekening() {
        let sumberRekeningViewModel = SumberRekeningViewModel()
        sumberRekeningViewModel.getCardDetailData()
        let sumberRekeningBottomSheetContent: SumberRekeningCollectionView = SumberRekeningCollectionView(viewModel: sumberRekeningViewModel)
        
        sumberRekeningBottomSheetContent.setData(sumberRekeningViewModel.getAllData())
        
        sumberRekeningBottomSheetContent.onTapCard = {[weak self] model in
            guard let self = self else {
                return
            }
            
            self.selectedAccount = model.cardId
            self.selectedAccountName = model.name
            self.accountSection.updateValue(model.cardId, model.name, false)
            
            self.dismiss(animated: false)
        }
        
        sumberRekeningBottomSheetContent.onTapSelectAllCard = {[weak self] in
            guard let self = self else {
                return
            }
            
            self.selectedAccount = ""
            self.selectedAccountName = ""
            self.accountSection.updateValue("", "", false)
            self.dismiss(animated: false)
        }
        
        let showSumberRekening: ReusableBottomSheetViewController = ReusableBottomSheetViewController.create(
            title: "Sumber Rekening",
            contentView: sumberRekeningBottomSheetContent,
            showActionButton: false
        )
        
        self.presentBrimonsBottomSheet(viewController: showSumberRekening)
    }
}
