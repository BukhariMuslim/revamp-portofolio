//
//  RiwayatMutasiFilterDateCellView.swift
//  BottomSheetViewControllerExample
//
//  Created by sia santos on 21/07/25.
//

import UIKit
import SnapKit

final class RiwayatMutasiFilterDateCellView: UICollectionViewCell {
    
    static let reuseIdentifier = "RiwayatMutasiFilterDateCellView"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Brimo.Body.largeSemiBold
        label.textColor = UIColor.Brimo.Black.main
        return label
    }()
    
    private let radioButton: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.Brimo.Black.x400.cgColor
        view.backgroundColor = UIColor.Brimo.White.main
        return view
    }()
    
    private let radioButtonInner: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 6
        view.backgroundColor = UIColor.Brimo.Primary.main
        view.isHidden = true
        return view
    }()
    
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
        contentView.addSubview(titleLabel)
        contentView.addSubview(radioButton)
        radioButton.addSubview(radioButtonInner)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.trailing.lessThanOrEqualTo(radioButton.snp.leading).offset(-16)
        }
        
        radioButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        radioButtonInner.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(12)
        }
    }
    
    func configure(with filterType: DateFilterType, isSelected: Bool) {
        titleLabel.text = filterType.displayTitle
        
        if isSelected {
            radioButton.layer.borderColor = UIColor.Brimo.Primary.main.cgColor
            radioButtonInner.isHidden = false
        } else {
            radioButton.layer.borderColor = UIColor.Brimo.Black.x400.cgColor
            radioButtonInner.isHidden = true
        }
    }
}
