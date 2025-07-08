//
//  FundingSourceTableViewCell.swift
//  BottomSheetViewControllerExample
//
//  Created by PT Diksha Teknologi Indonesia on 06/07/25.
//


import UIKit
import SnapKit

struct AccountModel {
    let logoName: String
    let username: String?
    let cardNumbers: [String]
    let balance: String
    let isUtama: Bool
}

final class AccountListTableViewCell: UITableViewCell {

    // MARK: - UI Elements

    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.clear.cgColor
        view.backgroundColor = ConstantsColor.black100
        return view
    }()

    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var accountNameLabel: UILabel = {
        let label = UILabel()
        label.font = .Brimo.Body.mediumRegular
        label.textColor = ConstantsColor.black900
        label.numberOfLines = 1
        return label
    }()

    private lazy var cardNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .Brimo.Body.mediumRegular
        label.textColor = ConstantsColor.black900
        label.numberOfLines = 2
        return label
    }()

    private lazy var balanceLabel: UILabel = {
        let label = UILabel()
        label.font = .Brimo.Body.largeSemiBold
        label.textColor = ConstantsColor.black900
        return label
    }()

    private lazy var badgeContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
        view.clipsToBounds = true
        return view
    }()

    private lazy var primaryBadgeLabel: UILabel = {
        let label = UILabel()
        label.font = .Brimo.Body.smallSemiBold
        label.textColor = .Brimo.Primary.main
        label.text = "UTAMA"
        label.textAlignment = .center
        return label
    }()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Setup

    private func setupViews() {
        contentView.addSubview(containerView)

        containerView.addSubview(logoImageView)
        containerView.addSubview(badgeContainerView)
        badgeContainerView.addSubview(primaryBadgeLabel)

        containerView.addSubview(accountNameLabel)
        containerView.addSubview(cardNumberLabel)
        containerView.addSubview(balanceLabel)
        
        DispatchQueue.main.async {
            [weak self] in
            guard let self else { return }
            self.badgeContainerView.layer.cornerRadius = self.badgeContainerView.frame.height / 2
        }
        
    }

    // MARK: - Constraints

    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        logoImageView.snp.makeConstraints { make in
            make.width.equalTo(58)
            make.height.equalTo(36)
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalTo(containerView.snp.centerY)
        }

        badgeContainerView.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(16)
        }

        primaryBadgeLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 2, left: 8, bottom: 2, right: 8))
        }

        accountNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(logoImageView.snp.trailing).offset(16)
            make.trailing.lessThanOrEqualTo(badgeContainerView.snp.leading).offset(-8)
            make.top.equalToSuperview().offset(16)
        }

        cardNumberLabel.snp.makeConstraints { make in
            make.leading.equalTo(accountNameLabel)
            make.top.equalTo(accountNameLabel.snp.bottom).offset(4)
            make.trailing.equalToSuperview().inset(12)
        }

        balanceLabel.snp.makeConstraints { make in
            make.leading.equalTo(accountNameLabel)
            make.top.equalTo(cardNumberLabel.snp.bottom).offset(8)
            make.bottom.equalToSuperview().inset(16)
        }
    }

    // MARK: - Configure

    func configure(with model: AccountModel, isSelected: Bool) {
        logoImageView.image = UIImage(named: model.logoName)
        accountNameLabel.text = model.username
        accountNameLabel.isHidden = model.username?.isEmpty ?? true

        cardNumberLabel.text = model.cardNumbers.joined(separator: "\n")
        balanceLabel.text = model.balance

        badgeContainerView.isHidden = !model.isUtama
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = isSelected ? UIColor.Brimo.Primary.main.cgColor : UIColor.clear.cgColor
    }
}
