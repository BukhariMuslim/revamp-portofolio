//
//  ProxyAccountCardView.swift
//  BottomSheetViewControllerExample
//
//  Created by Phincon on 08/07/25.
//


import UIKit
import SnapKit

final class ProxyAccountCardView: UIView {

    // MARK: - Public Actions
    let blockButton = UIButton(type: .system)
    let deleteButton = UIButton(type: .system)

    // MARK: - Private UI Components
    
    private let topContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        view.clipsToBounds = true
        return view
    }()

    private let phoneIcon: UIImageView = {
        let iv = UIImageView(image: UIImage(systemName: "phone.fill"))
        iv.tintColor = .black
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "0896 6215 1339"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        return label
    }()

    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Aktif"
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = UIColor.systemGreen
        return label
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Marsela Nababan"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        return label
    }()

    private let accountLabel: UILabel = {
        let label = UILabel()
        label.text = "BRI - 05994 0101 5080 007"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        return label
    }()

    private let separator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray4
        return view
    }()
    
    private let verticalSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupView() {
        backgroundColor = UIColor(red: 0.97, green: 0.98, blue: 1.0, alpha: 1.0)
        layer.cornerRadius = 16
        clipsToBounds = true

        blockButton.setTitle("Blokir", for: .normal)
        blockButton.setTitleColor(.systemBlue, for: .normal)
        blockButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        blockButton.titleLabel?.textAlignment = .center
        blockButton.backgroundColor = .orange

        deleteButton.setTitle("Hapus", for: .normal)
        deleteButton.setTitleColor(.systemBlue, for: .normal)
        deleteButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        deleteButton.titleLabel?.textAlignment = .center
        deleteButton.backgroundColor = .red

        addSubviews(topContainerView,
                    nameLabel, accountLabel,
                    separator, blockButton, deleteButton, verticalSeparator)
        topContainerView.addSubviews(phoneIcon, phoneLabel, statusLabel)
    }

    private func setupConstraints() {
        topContainerView.snp.remakeConstraints {
            $0.height.equalTo(48)
            $0.leading.trailing.top.equalToSuperview()
        }
        
        phoneIcon.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(12)
            make.size.equalTo(20)
        }

        phoneLabel.snp.makeConstraints { make in
            make.leading.equalTo(phoneIcon.snp.trailing).offset(8)
            make.centerY.equalTo(phoneIcon)
        }

        statusLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalTo(phoneIcon)
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(topContainerView.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        accountLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        separator.snp.makeConstraints { make in
            make.top.equalTo(accountLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(1)
        }

        blockButton.snp.makeConstraints { make in
            make.top.equalTo(separator.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().inset(12)
            make.width.equalToSuperview().multipliedBy(0.5)
        }

        deleteButton.snp.makeConstraints { make in
            make.top.equalTo(separator.snp.bottom).offset(8)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(12)
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        
        verticalSeparator.snp.remakeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(20)
            $0.width.equalTo(2)
            $0.bottom.equalToSuperview().inset(12)
        }
    }
}
