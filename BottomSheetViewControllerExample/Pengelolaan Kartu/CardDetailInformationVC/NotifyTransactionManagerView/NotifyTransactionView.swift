//
//  NotifyTransactionView.swift
//  BottomSheetViewControllerExample
//
//  Created by Phincon on 10/07/25.
//

import Foundation
import UIKit
import SnapKit

struct NotifyTransactionContent {
    var image: String?
    var title: String?
}

final class NotifyTransactionView: UIView {
    
    // Public
    let toggleSwitch = UISwitch()
    let changeAmountButton = UIButton()
    
    // Toggle untuk menampilkan detail
    var isDetailVisible: Bool = false {
        didSet {
            detailView.isHidden = !isDetailVisible
            UIView.animate(withDuration: 0.25) {
                self.mainStack.layoutIfNeeded()
                self.layoutIfNeeded()
            }
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
        setupActions()
        detailView.isHidden = true
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
        mainStack.backgroundColor = ConstantsColor.black100
        
        addSubview(mainStack)
        mainStack.addArrangedSubview(topView)
        mainStack.addArrangedSubview(detailView)
        
        // ========== TOP VIEW ==========
        iconImageView.image = UIImage(named: "whatsApp_ic")
        iconImageView.contentMode = .scaleAspectFit
        
        titleLabel.text = "Whatsapp"
        titleLabel.font = .Brimo.Body.largeSemiBold
        titleLabel.textColor = ConstantsColor.black900
        
        topView.addSubview(iconImageView)
        topView.addSubview(titleLabel)
        topView.addSubview(toggleSwitch)
        
        // ========== DETAIL VIEW ==========
        detailView.backgroundColor = .clear
        detailView.setContentHuggingPriority(.required, for: .vertical)
        detailView.setContentCompressionResistancePriority(.required, for: .vertical)
        
        separatorView.backgroundColor = UIColor.Brimo.Black.x200
        detailView.addSubview(separatorView)
        
        nominalTitleLabel.text = "Nominal Minimum"
        nominalTitleLabel.font = .Brimo.Body.largeRegular
        nominalTitleLabel.textColor = ConstantsColor.black500
        
        nominalValueLabel.text = "Rp100.000"
        nominalValueLabel.font = .Brimo.Body.largeRegular
        nominalValueLabel.textColor = ConstantsColor.black900
        
        changeAmountButton.setTitle("Ubah Nominal", for: .normal)
        changeAmountButton.setTitleColor(.Brimo.Primary.main, for: .normal)
        changeAmountButton.titleLabel?.font = .Brimo.Body.mediumSemiBold
        
        detailView.addSubview(nominalTitleLabel)
        detailView.addSubview(nominalValueLabel)
        detailView.addSubview(changeAmountButton)
        
        toggleSwitch.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
    }

    private func setupActions() {
        toggleSwitch.addTarget(self, action: #selector(toggleSwitchChanged), for: .valueChanged)
    }

    @objc private func toggleSwitchChanged() {
        
    }

    // MARK: - Setup Constraints

    private func setupConstraints() {
        mainStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        // --- Top View Layout ---
        topView.snp.makeConstraints { make in
            make.height.equalTo(56)
        }

        iconImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(32)
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
    
    func setupContent(item: NotifyTransactionContent){
        iconImageView.image = UIImage(named: item.image ?? "")
        titleLabel.text = item.title
    }
}
