//
//  RiwayatMutasiFilterSectionCellView.swift
//  BottomSheetViewControllerExample
//
//  Created by sia santos on 17/07/25.
//

import UIKit
import SnapKit

struct RiwayatMutasiFilterSectionCellData {
    let title: String?
    let value: String
    let icon: UIImage?
    let iconTintColor: UIColor?
    
    init(title: String?, value: String, systemIconName: String, iconTintColor: UIColor? = nil) {
        self.title = title ?? "Sumber Rekening"
        self.value = value
        self.icon = UIImage(systemName: systemIconName)
        self.iconTintColor = iconTintColor ?? UIColor.Brimo.Black.x600
    }
}

class RiwayatMutasiFilterSectionCellView: UIView {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.Brimo.Black.x200
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Brimo.Title.smallRegular
        label.textColor = UIColor.Brimo.Black.main
        return label
    }()
    
    let valueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Brimo.Title.smallSemiBold
        label.textColor = UIColor.Brimo.Black.main
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var onTapped: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupConstraints()
        setupActions()
    }
    
    private func setupView() {
        addSubview(containerView)
        containerView.addSubviews(titleLabel, valueLabel, iconImageView)
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(80)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        
        valueLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(16)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
    }
    
    private func setupActions() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(containerTapped))
        containerView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func containerTapped() {
        onTapped?()
    }
    
    func configure(with data: RiwayatMutasiFilterSectionCellData) {
        titleLabel.text = data.title
        valueLabel.text = data.value
        iconImageView.image = data.icon
        iconImageView.tintColor = data.iconTintColor
        
        updateLayoutForValue(data.value)
    }
    
    func updateValue(_ value: String) {
        valueLabel.text = value
        updateLayoutForValue(value)
    }
    
    private func updateLayoutForValue(_ value: String) {
        let isEmpty = value.isEmpty
        valueLabel.isHidden = isEmpty
        
        titleLabel.snp.remakeConstraints { make in
            if isEmpty {
                make.centerY.equalToSuperview()
            } else {
                make.top.equalToSuperview().offset(16)
            }
            make.leading.equalToSuperview().offset(16)
        }
    }
}
