//
//  RiwayatMutasiFilterTransactionTypeCell.swift
//  BottomSheetViewControllerExample
//
//  Created by sia santos on 17/07/25.
//

import UIKit
import SnapKit

enum TransactionType: String, CaseIterable {
    case all = "Semua"
    case incoming = "Uang Masuk"
    case outgoing = "Uang Keluar"
    
    var displayTitle: String {
        return rawValue
    }
    
    static func from(title: String) -> TransactionType {
        let normalizedTitle = title.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        switch normalizedTitle {
        case "uang masuk":
            return .incoming
        case "uang keluar":
            return .outgoing
        default:
            return .outgoing
        }
    }
}

class TransactionTypeCollectionView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Pilih Jenis Transaksi"
        label.font = UIFont.Brimo.Title.mediumSemiBold
        label.textColor = UIColor.Brimo.Black.main
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 12
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        cv.delegate = self
        cv.dataSource = self
        
        cv.register(RiwayatMutasiFilterTransactionTypeCell.self, forCellWithReuseIdentifier: RiwayatMutasiFilterTransactionTypeCell.reuseIdentifier)
        
        return cv
    }()
    
    private var selectedType: TransactionType = .all
    private let transactionTypes = TransactionType.allCases
    
    var onSelectionChanged: ((TransactionType) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        addSubview(titleLabel)
        addSubview(collectionView)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(40)
        }
    }
    
    func setSelectedType(_ type: TransactionType) {
        selectedType = type
        collectionView.reloadData()
    }
    
    func getSelectedType() -> TransactionType {
        return selectedType
    }
}

extension TransactionTypeCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return transactionTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RiwayatMutasiFilterTransactionTypeCell.reuseIdentifier, for: indexPath) as? RiwayatMutasiFilterTransactionTypeCell else {
            return UICollectionViewCell()
        }
        
        let type = transactionTypes[indexPath.item]
        let isSelected = (type == selectedType)
        
        cell.configure(with: type.displayTitle, isSelected: isSelected)
        
        return cell
    }
}

extension TransactionTypeCollectionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedType = transactionTypes[indexPath.item]
        collectionView.reloadData()
        onSelectionChanged?(selectedType)
    }
}

extension TransactionTypeCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let type = transactionTypes[indexPath.item]
        let width = type.displayTitle.width(withConstrainedHeight: 40, font: UIFont.Brimo.Title.smallRegular) + 32
        return CGSize(width: max(width, 80), height: 40)
    }
}

class RiwayatMutasiFilterTransactionTypeCell: UICollectionViewCell {
    
    static let reuseIdentifier = "RiwayatMutasiFilterTransactionTypeCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Brimo.Title.smallRegular
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }
    
    private func setupCell() {
        layer.cornerRadius = 20
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    func configure(with title: String, isSelected: Bool) {
        titleLabel.text = title
        
        if isSelected {
            backgroundColor = UIColor.Brimo.Primary.main
            titleLabel.textColor = UIColor.Brimo.White.main
        } else {
            backgroundColor = UIColor.Brimo.Black.x200
            titleLabel.textColor = UIColor.Brimo.Black.x600
        }
    }
}

extension String {
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return ceil(boundingBox.width)
    }
}
