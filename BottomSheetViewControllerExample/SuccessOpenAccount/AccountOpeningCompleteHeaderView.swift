//
//  AccountOpeningCompleteHeaderView.swift
//  BottomSheetViewControllerExample
//
//  Created by PT Diksha Teknologi Indonesia on 29/06/25.
//


import UIKit
import SnapKit

final class AccountOpeningCompleteHeaderView: UIView {

    // MARK: - UI Components

    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = UIImage(systemName: "checkmark.seal.fill")
        iv.tintColor = .systemGreen
        iv.layer.cornerRadius = 60
        return iv
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Pembukaan Rekening Berhasil"
        label.font = .boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = .label
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "29 Juni 2025"
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        return label
    }()

    private let cardImgView: UIImageView = {
        let img = UIImageView()
        img.layer.cornerRadius = 16
        img.clipsToBounds = true
        img.image = UIImage(named: "sampleImage") // Replace with your image
        img.contentMode = .scaleAspectFill
        return img
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Marsela Satya"
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()

    private let accountNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "2334 4668 8779 860"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()

    private let copyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Salin", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        return button
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupConstraints()
    }

    // MARK: - Setup

    private func setupViews() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(dateLabel)
        addSubview(cardImgView)
        cardImgView.addSubview(nameLabel)
        cardImgView.addSubview(accountNumberLabel)
        cardImgView.addSubview(copyButton)
    }

    private func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.size.equalTo(CGSize(width: 120, height: 120))
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        dateLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        cardImgView.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(213)
            $0.bottom.equalToSuperview()
        }

        nameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalTo(accountNumberLabel.snp.top).offset(-8)
        }

        accountNumberLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16)
        }

        copyButton.snp.makeConstraints {
            $0.leading.equalTo(accountNumberLabel.snp.trailing).offset(8)
            $0.centerY.equalTo(accountNumberLabel)
        }
    }

    // MARK: - Public Configuration

    func configure(title: String, date: String, image: UIImage?, name: String, accountNumber: String) {
        titleLabel.text = title
        dateLabel.text = date
        imageView.image = image
        nameLabel.text = name
        accountNumberLabel.text = accountNumber
    }
}
