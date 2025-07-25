//
//  EStatementEmptyCell.swift
//  BottomSheetViewControllerExample
//
//  Created by User01 on 18/07/25.
//

import UIKit

class EStatementEmptyCell: UITableViewCell {

    static let identifier = "EStatementEmptyCell"

    private let containerView: UIView = {
        let view = UIView()
        return view
    }()

    private let boxImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "illustrations/empty")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Riwayat E-Statement Tidak Tersedia"
        label.font = .Brimo.Title.smallSemiBold
        label.textColor = .Brimo.Black.main
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Kamu belum memiliki riwayat e-statement di BRImo. Yuk, mulai transaksimu sekarang!"
        label.font = .Brimo.Body.largeRegular
        label.textColor = .Brimo.Black.x600
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    public let actionButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Buat e-Statement", for: .normal)
        button.setTitleColor(.Brimo.Primary.main, for: .normal)
        button.titleLabel?.font = .Brimo.Body.mediumSemiBold
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor(hex: "#0054F3").cgColor
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        backgroundColor = .clear
        selectionStyle = .none
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        contentView.addSubview(containerView)
        containerView.addSubview(boxImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(subtitleLabel)
        containerView.addSubview(actionButton)

        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }

        boxImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.height.equalTo(120)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(boxImageView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(8)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(8)
        }

        actionButton.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(24)
            make.height.equalTo(32)
        }

        actionButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

    }
}

extension EStatementEmptyCell {
    public func configure(icon: UIImage, header: String, desc: String) {
        boxImageView.image = icon
        titleLabel.text = header
        subtitleLabel.text = desc
    }
}
