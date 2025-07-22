//
//  MutasiViewController.swift
//  BottomSheetViewControllerExample
//
//  Created by sia santos on 17/07/25.
//

import UIKit
import SnapKit

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
    
    private let accountSection = RiwayatMutasiFilterSectionCellView()
    
    let filterView: RiwayaMutasiFilterContainerView = RiwayaMutasiFilterContainerView()
    var viewModel: RiwayatMutasiViewModel = RiwayatMutasiViewModel()
    
    init(viewModel: RiwayatMutasiViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
        setupView()
        setupConstraints()
        configureEmptyState()
        configureFilterView()
        setupAccountView()
    }
    
    private func configureViewModel() {
        
        viewModel.onSaveFilter = {[weak self] (rekeningId, rekeningName) in
            guard let self = self else {
                return
            }

            let isEmpty = self.viewModel.mutasiData.isEmpty
            accountSection.updateValue(rekeningName, rekeningId, true)
            emptyStateView.isHidden = !isEmpty
            collectionView.isHidden = isEmpty
            
            collectionView.reloadData()
        }
        
        viewModel.onTapMonthFilter = {[weak self] in
            guard let self = self else {
                return
            }
            
            let isEmpty = self.viewModel.mutasiData.isEmpty
            emptyStateView.isHidden = !isEmpty
            collectionView.isHidden = isEmpty
            
            collectionView.reloadData()
        }
    }
    
    private func setupAccountView() {
        
        //TODO: Santos - Remove Mock Data
        let mockData = SumberRekeningViewModel()
        mockData.getCardDetailData()
        let defaultData = mockData.getAllData().first
        
        let accountData = RiwayatMutasiFilterSectionCellData(
            title: defaultData?.name,
            value: defaultData?.cardId ?? "",
            systemIconName: "chevron.down",
            bankImage: defaultData?.cardImage ?? ""
        )
        
        accountSection.configure(with: accountData, true)
    }
    
    private func configureFilterView() {
        filterView.onFilterTap = { [weak self] in
            guard let self = self else {
                return
            }
            
            self.onTapFilter?()
        }
        
        filterView.didSelectMonth = { [weak self] index in
            guard let self = self else {
                return
            }
            
            self.viewModel.selectedMonthIndex = index
            self.viewModel.filterDataByMonth()
        }
        
        filterView.onClearTap = { [weak self] in
            guard let self = self else {
                return
            }
            
            self.viewModel.filterDataByMonth()
        }
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubviews(accountSection, filterView, collectionView, emptyStateView)
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
        
        accountSection.snp.remakeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(24)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(68)
            make.bottom.equalTo(filterView.snp.top).offset(-12)
        }
        
        filterView.snp.remakeConstraints { make in
            make.top.equalTo(accountSection.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(60)
        }
        
        collectionView.snp.remakeConstraints { make in
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
        self.viewModel.selectedMonthIndex = self.viewModel.selectedMonthIndex == tappedIndex ? nil : tappedIndex
        self.viewModel.filterDataByMonth()
    }
    
    func configureData(data: [RiwayatMutasiModel]) {
        self.viewModel.allMutasiData = data
        self.viewModel.filterDataByMonth()
    }
}

extension MutasiViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        let mutasiData = self.viewModel.mutasiData
        return mutasiData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let mutasiData = self.viewModel.mutasiData
        return mutasiData[section].riwayatMutasiItemModel.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let mutasiData = self.viewModel.mutasiData
        
        guard indexPath.section < mutasiData.count else {
            return UICollectionViewCell()
        }
        
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
