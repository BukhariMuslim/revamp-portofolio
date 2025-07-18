//
//  MutasiViewController.swift
//  BottomSheetViewControllerExample
//
//  Created by sia santos on 17/07/25.
//

import UIKit

class MutasiViewController: UIViewController {
    
    var onTapFilter: (() -> Void)?
    
    private lazy var emptyStateView: EmptyStateCellView = {
        let emptyView = EmptyStateCellView()
        emptyView.isHidden = true
        return emptyView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        cv.showsVerticalScrollIndicator = false
        
        cv.register(RiwayatMutasiDateHeaderView.self, forCellWithReuseIdentifier: "RiwayatMutasiDateHeaderView")
        cv.register(RiwayatMutasiCellView.self, forCellWithReuseIdentifier: "RiwayatMutasiCellView")
        
        return cv
    }()
    
    private let filterView: RiwayaMutasiFilterContainerView = RiwayaMutasiFilterContainerView()
    private var mutasiData: [RiwayatMutasiModel] = []
    private var allMutasiData: [RiwayatMutasiModel] = []
    private var selectedMonthIndex: Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        configureEmptyState()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(filterView)
        view.addSubview(collectionView)
        view.addSubview(emptyStateView)
        
        filterView.onFilterTap = { [weak self] in
            self?.onTapFilter?()
        }
        
        filterView.didSelectMonth = { [weak self] index in
            self?.selectedMonthIndex = index
            self?.filterDataByMonth()
        }
        
        filterView.onClearTap = { [weak self] in
            self?.filterDataByMonth()
        }
    }
    
    @objc func didtapFilter() {
        onTapFilter?()
    }
    
    private func configureEmptyState() {
        emptyStateView.configure(data: EmptyStateDataItem(
            imageIcon: "illustrations/empty",
            titleText: "Belum Ada Riwayat Mutasi",
            descriptionText: "Kamu belum pernah melakukan transaksi melalui BRImo. Yuk, mulai transaksimu sekarang!")
        )
    }
    
    private func setupConstraints() {
        
        filterView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(60)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(filterView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        emptyStateView.snp.makeConstraints { make in
            make.top.equalTo(filterView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    @objc private func monthButtonTapped(_ sender: UIButton) {
        let tappedIndex = sender.tag
        selectedMonthIndex = selectedMonthIndex == tappedIndex ? nil : tappedIndex
        filterDataByMonth()
    }
    
    func filterDataByMonth(selectedMonth: Int = 0) {
        if let selectedIndex = selectedMonthIndex {
            let selectedMonth = selectedIndex + 1
            
            mutasiData = allMutasiData.filter { model in
                let calendar = Calendar.current
                let month = calendar.component(.month, from: model.tanggalMutasi)
                return month == selectedMonth
            }
        } else if selectedMonth > 0  {
            mutasiData = allMutasiData.filter { model in
                let calendar = Calendar.current
                let month = calendar.component(.month, from: model.tanggalMutasi + Double(selectedMonth))
                return month == selectedMonth
            }
        } else {
            mutasiData = allMutasiData
        }
        
        let isEmpty = mutasiData.isEmpty
        emptyStateView.isHidden = !isEmpty
        collectionView.isHidden = isEmpty
        
        collectionView.reloadData()
    }
    
    func filterDataBy(startDate: Date, endDate: Date, transactionType: TransactionType = .all) {
        
        let filteredByMonthsData = filterByMonthYear(data: allMutasiData, start: startDate, end: endDate)
        mutasiData = filteredByMonthsData
        
        let isEmpty = mutasiData.isEmpty
        emptyStateView.isHidden = !isEmpty
        collectionView.isHidden = isEmpty
        
        collectionView.reloadData()
    }
    
    func filterByMonthYear(
        data: [RiwayatMutasiModel],
        start: Date,
        end: Date,
        calendar: Calendar = .current
    ) -> [RiwayatMutasiModel] {
        
        // 1) Extract year & month from your bounds
        let startComp = calendar.dateComponents([.year, .month], from: start)
        let endComp = calendar.dateComponents([.year, .month], from: end)
        guard
            let startYear = startComp.year,
            let startMonth = startComp.month,
            let endYear = endComp.year,
            let endMonth = endComp.month
        else {
            return []
        }
        
        // Convert to a comparable “month index”
        let startIndex = startYear * 12 + (startMonth - 1)
        let endIndex = endYear * 12 + (endMonth - 1)
        
        return data.filter { model in
            let comp = calendar.dateComponents([.year, .month], from: model.tanggalMutasi)
            guard
                let y = comp.year,
                let m = comp.month
            else {
                return false
            }
            let modelIndex = y * 12 + (m - 1)
            return modelIndex >= startIndex && modelIndex <= endIndex
        }
    }
    
    func configureData(data: [RiwayatMutasiModel]) {
        allMutasiData = data
        filterDataByMonth()
    }
}

extension MutasiViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return mutasiData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mutasiData[section].riwayatMutasiItemModel.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let mutasi = mutasiData[indexPath.section]
        
        if indexPath.item == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RiwayatMutasiDateHeaderView", for: indexPath) as? RiwayatMutasiDateHeaderView else {
                return UICollectionViewCell()
            }
            
            cell.configure(with: mutasi.tanggalMutasi)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RiwayatMutasiCellView", for: indexPath) as? RiwayatMutasiCellView else {
                return UICollectionViewCell()
            }
            
            let transaction = mutasi.riwayatMutasiItemModel[indexPath.item - 1]
            let isLastItem = indexPath.item == mutasi.riwayatMutasiItemModel.count
            cell.configure(with: transaction, isLastIndex: isLastItem)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        
        if indexPath.item == 0 {
            return CGSize(width: width, height: 60)
        } else {
            return CGSize(width: width, height: 80)
        }
    }
}
