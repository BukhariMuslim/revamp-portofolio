//
//  NotifyTransactionView.swift
//  BottomSheetViewControllerExample
//
//  Created by Phincon on 10/07/25.
//

import Foundation
import UIKit

final class NotifyTransactionView: UIView {
    
    // Public
    let toggleSwitch = UISwitch()
    let changeAmountButton = UIButton()
    
    // Toggle untuk menampilkan detail
    var isDetailVisible: Bool = false {
        didSet {
            detailView.isHidden = !isDetailVisible
        }
    }
    
    // MARK: - Private Views
    private let mainStack = UIStackView()
    private let topView = UIView()
    private let detailView = UIView()
    
    // Top components
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    
    // Detail components
    private let separatorView = UIView()
    private let nominalTitleLabel = UILabel()
    private let nominalValueLabel = UILabel()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        detailView.isHidden = true
//        isDetailVisible = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Views

    private func setupViews() {
        backgroundColor = .clear
        
        mainStack.axis = .vertical
        mainStack.spacing = 0
        mainStack.layer.cornerRadius = 12
        mainStack.clipsToBounds = true
        mainStack.backgroundColor = UIColor(red: 0.96, green: 0.98, blue: 1.0, alpha: 1)
        
        addSubview(mainStack)
        mainStack.addArrangedSubview(topView)
        mainStack.addArrangedSubview(detailView)
        
        // ========== TOP VIEW ==========
        iconImageView.image = UIImage(named: "whatsapp")
        iconImageView.contentMode = .scaleAspectFit
        
        titleLabel.text = "Whatsapp"
        titleLabel.font = .boldSystemFont(ofSize: 14)
        titleLabel.textColor = .black
        
        topView.addSubview(iconImageView)
        topView.addSubview(titleLabel)
        topView.addSubview(toggleSwitch)
        
        // ========== DETAIL VIEW ==========
        detailView.backgroundColor = .clear
        
        separatorView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        detailView.addSubview(separatorView)
        
        nominalTitleLabel.text = "Nominal Minimum"
        nominalTitleLabel.textColor = .gray
        nominalTitleLabel.font = .systemFont(ofSize: 14)
        
        nominalValueLabel.text = "Rp100.000"
        nominalValueLabel.textColor = .black
        nominalValueLabel.font = .systemFont(ofSize: 14)
        
        changeAmountButton.setTitle("Ubah Nominal", for: .normal)
        changeAmountButton.setTitleColor(.systemBlue, for: .normal)
        changeAmountButton.titleLabel?.font = .systemFont(ofSize: 14)
        
        detailView.addSubview(nominalTitleLabel)
        detailView.addSubview(nominalValueLabel)
        detailView.addSubview(changeAmountButton)
    }

    // MARK: - Setup Constraints

    private func setupConstraints() {
        mainStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        // --- Top View Layout ---
        topView.snp.makeConstraints { make in
            make.height.equalTo(48)
        }

        iconImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(24)
        }

        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(iconImageView.snp.right).offset(12)
            make.centerY.equalToSuperview()
        }

        toggleSwitch.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }

        // --- Detail View Layout ---
        separatorView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(1)
        }

        nominalTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(16)
        }

        nominalValueLabel.snp.makeConstraints { make in
            make.centerY.equalTo(nominalTitleLabel)
            make.right.equalToSuperview().inset(16)
        }

        changeAmountButton.snp.makeConstraints { make in
            make.top.equalTo(nominalValueLabel.snp.bottom).offset(4)
            make.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(12)
        }
    }
}
