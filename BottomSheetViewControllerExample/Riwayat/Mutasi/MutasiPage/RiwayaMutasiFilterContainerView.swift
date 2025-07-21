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
    
    // TODO: Santos - Implement month collection view when API is ready
    /*
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
     cv.register(RiwayatFilterMonthCell.self, forCellWithReuseIdentifier: RiwayatFilterMonthCell.reuseID)
     return cv
     }()
     */
    
    
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
        button.isHidden = true
        return button
    }()
    
    private let filterBadgeView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.Brimo.Primary.x100
        v.layer.cornerRadius = 16
        v.clipsToBounds = true
        return v
    }()
    
    private let filterBadgeLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.Brimo.Body.mediumRegular
        lbl.textColor = UIColor.Brimo.Primary.main
        lbl.text = "Semua"
        lbl.textAlignment = .center
        return lbl
    }()
    
    private var selectedIndex: Int? = nil
    private var hasAppliedFilter = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        // TODO: Santos - Add collectionView when API is ready
        // addSubview(collectionView)
        
        addSubview(filterBadgeView)
        filterBadgeView.addSubview(filterBadgeLabel)
        addSubview(buttonStackView)
        setupConstraints()
        
        clearButton.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        filterButton.addTarget(self, action: #selector(filterTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func filterTapped() {
        onFilterTap?()
    }
    
    @objc private func clearTapped() {
        selectedIndex = nil
        // TODO: Santos - Reload collection view when implemented
        // collectionView.reloadData()
        didSelectMonth?(nil)
        onClearTap?()
        setFilterApplied(true, DateFilterType.all.displayTitle)
    }
    
    private func setupConstraints() {
        // TODO: Santos - Update constraints when collection view is implemented
        /*
         collectionView.snp.makeConstraints { make in
         make.leading.equalToSuperview().offset(20)
         make.centerY.equalToSuperview()
         make.height.equalTo(32)
         make.trailing.equalTo(buttonStackView.snp.leading).offset(-10)
         }
         */
        
        filterBadgeView.setContentHuggingPriority(.required, for: .horizontal)
        filterBadgeView.setContentCompressionResistancePriority(.required, for: .horizontal)
        filterBadgeView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(buttonStackView.snp.leading).offset(-8)
            make.leading.greaterThanOrEqualToSuperview().offset(20)
            make.height.equalTo(32)
        }
        
        filterBadgeLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 4, left: 12, bottom: 4, right: 12))
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
            make.height.equalTo(32)
        }
        
        filterButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 32, height: 32))
        }
        
        clearButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 32, height: 32))
        }
    }
    
    func setFilterApplied(_ applied: Bool, _ filterText: String) {
        hasAppliedFilter = applied
        
        UIView.animate(withDuration: 0.2) {
            self.filterBadgeLabel.text = filterText
            self.clearButton.isHidden = !applied
            
            if applied {
                self.buttonStackView.snp.updateConstraints { make in
                    make.height.equalTo(32)
                }
            }
            
            self.layoutIfNeeded()
        }
    }
}

// TODO: Santos - Implement UICollectionView DataSource & Delegate when API is ready
/*
 extension RiwayaMutasiFilterContainerView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
 func collectionView(_ cv: UICollectionView, numberOfItemsInSection section: Int) -> Int {
 return months.count
 }
 
 func collectionView(_ cv: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
 guard let cell = cv.dequeueReusableCell(withReuseIdentifier: RiwayatFilterMonthCell.reuseID, for: indexPath) as? RiwayatFilterMonthCell else {
 return UICollectionViewCell()
 }
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
 */

private final class RiwayatFilterMonthCell: UICollectionViewCell {
    static let reuseID = "RiwayatFilterMonthCell"
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
            contentView.backgroundColor = ConstantsColor.black100
            label.textColor = UIColor.Brimo.Black.x700
        }
    }
}
