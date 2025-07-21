//
//  RiwayatMutasiFilterDateCollectionView.swift
//  BottomSheetViewControllerExample
//
//  Created by sia santos on 21/07/25.
//

import UIKit
import SnapKit

enum DateFilterType: String, CaseIterable {
    case today = "Hari Ini"
    case last7Days = "7 Hari Terakhir"
    case selectMonth = "Pilih Bulan"
    case selectDate = "Pilih Tanggal"
    
    var displayTitle: String {
        return rawValue
    }
}

final class RiwayatMutasiFilterDateCollectionView: UIView {
    
    var onDateFilterSelected: ((DateFilterType) -> Void)?
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        cv.isScrollEnabled = false
        cv.showsVerticalScrollIndicator = false
        cv.register(RiwayatMutasiFilterDateCellView.self, forCellWithReuseIdentifier: RiwayatMutasiFilterDateCellView.reuseIdentifier)
        return cv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Rentang Waktu"
        label.font = UIFont.Brimo.Title.mediumSemiBold
        label.textColor = UIColor.Brimo.Black.main
        return label
    }()
    
    private var selectedFilterType: DateFilterType?
    private let filterOptions: [DateFilterType] = [.today, .last7Days, .selectMonth, .selectDate]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .clear
        addSubview(titleLabel)
        addSubview(collectionView)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setSelectedFilter(_ filterType: DateFilterType?) {
        selectedFilterType = filterType
        collectionView.reloadData()
    }
}

extension RiwayatMutasiFilterDateCollectionView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterOptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RiwayatMutasiFilterDateCellView.reuseIdentifier,
            for: indexPath
        ) as? RiwayatMutasiFilterDateCellView else {
            return UICollectionViewCell()
        }
        
        let filterType = filterOptions[indexPath.item]
        let isSelected = selectedFilterType == filterType
        cell.configure(with: filterType, isSelected: isSelected)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let filterType = filterOptions[indexPath.item]
        selectedFilterType = filterType
        collectionView.reloadData()
        onDateFilterSelected?(filterType)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        return CGSize(width: width, height: 56)
    }
}
