//
//  RiwayaMutasiFilterContainerView.swift
//  BottomSheetViewControllerExample
//
//  Created by sia santos on 18/07/25.
//

import UIKit
import SnapKit

final class RiwayaMutasiFilterContainerView: UIView {
    
    var onFilterTap: (() -> Void)?
    var onClearTap: (() -> Void)?
    var didSelectMonth: ((Int?) -> Void)?
    
    private let months = ["Jan", "Feb", "Mar", "Apr", "Mei", "Jun",
                          "Jul", "Agu", "Sep", "Okt", "Nov", "Des"]
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12
        layout.sectionInset = .zero
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.showsHorizontalScrollIndicator = false
        cv.delegate = self
        cv.dataSource = self
        cv.register(MonthCell.self, forCellWithReuseIdentifier: MonthCell.reuseID)
        return cv
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [clearButton, filterButton])
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        return stack
    }()
    
    private let filterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "utilities/riwayat_mutasi_filter_icon"), for: .normal)
        button.tintColor = UIColor.Brimo.Black.main
        button.backgroundColor = ConstantsColor.black100
        button.layer.cornerRadius = 16
        return button
    }()
    
    private let clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "utilities/riwayat_mutasi_close_icon"), for: .normal)
        button.tintColor = UIColor.Brimo.Black.main
        button.backgroundColor = ConstantsColor.black100
        button.layer.cornerRadius = 16
        return button
    }()
    
    private var selectedIndex: Int? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(collectionView)
        addSubview(buttonStackView)
        setupConstraints()
        
        clearButton.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        filterButton.addTarget(self, action: #selector(filterTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc private func filterTapped() {
        onFilterTap?()
    }
    
    @objc private func clearTapped() {
        selectedIndex = nil
        collectionView.reloadData()
        didSelectMonth?(nil)
        onClearTap?()
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.height.equalTo(32)
            make.trailing.equalTo(buttonStackView.snp.leading).offset(-10)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 72, height: 32))
        }
        
        filterButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 32, height: 32))
        }
        
        clearButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 32, height: 32))
        }
    }
}

// MARK: – UICollectionView DataSource & Delegate

extension RiwayaMutasiFilterContainerView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ cv: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return months.count
    }
    
    func collectionView(_ cv: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cv.dequeueReusableCell(withReuseIdentifier: MonthCell.reuseID, for: indexPath) as! MonthCell
        let month = months[indexPath.item]
        let isSelected = (indexPath.item == selectedIndex)
        cell.configure(text: month, selected: isSelected)
        return cell
    }
    
    func collectionView(_ cv: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = (selectedIndex == indexPath.item ? nil : indexPath.item)
        cv.reloadData()
        didSelectMonth?(selectedIndex)
    }
    
    func collectionView(_ cv: UICollectionView, layout cvLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 54, height: 32)
    }
}

private final class MonthCell: UICollectionViewCell {
    static let reuseID = "MonthCell"
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
        label.font = .Brimo.Body.mediumRegular
        label.textAlignment = .center
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        layer.cornerRadius = 16
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    func configure(text: String, selected: Bool) {
        label.text = text
        if selected {
            contentView.backgroundColor = UIColor.Brimo.Primary.x100
            label.textColor = UIColor.Brimo.Primary.main
        } else {
            contentView.backgroundColor = ConstantsColor.black100     // neutral bg :contentReference[oaicite:2]{index=2}
            label.textColor = UIColor.Brimo.Black.x700               // neutral text
        }
    }
}
