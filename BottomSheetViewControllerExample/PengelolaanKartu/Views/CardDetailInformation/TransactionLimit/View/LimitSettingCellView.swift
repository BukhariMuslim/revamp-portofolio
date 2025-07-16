//
//  LimitSettingCellView.swift
//  BottomSheetViewControllerExample
//
//  Created by sia santos on 15/07/25.
//

import UIKit
import SnapKit

final class LimitSettingCellView: UICollectionViewCell {

    static let reuseIdentifier = "LimitSettingCellView"

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = ConstantsColor.black100
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()

    private let topLeftIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let topTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .Brimo.Body.largeRegular
        label.textColor = ConstantsColor.black500
        return label
    }()

    private let topAmountLabel: UILabel = {
        let label = UILabel()
        label.font = .Brimo.Title.smallSemiBold
        label.textColor = ConstantsColor.black900
        return label
    }()

    private let badgeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var topTextStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [topTitleLabel, topAmountLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .leading
        stack.distribution = .fill
        return stack
    }()

    private lazy var topRowStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [topLeftIconView, topTextStack])
        stack.axis = .horizontal
        stack.spacing = 16
        stack.alignment = .top
        return stack
    }()

    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.9, alpha: 1)
        return view
    }()

    private let bottomTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .Brimo.Body.largeRegular
        label.textColor = ConstantsColor.black500
        return label
    }()

    private let bottomUsedLabel: UILabel = {
        let label = UILabel()
        label.font = .Brimo.Title.smallSemiBold
        label.textColor = ConstantsColor.black900
        label.numberOfLines = 2
        return label
    }()

    private lazy var bottomTextStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [bottomTitleLabel, bottomUsedLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .leading
        stack.distribution = .fill
        return stack
    }()

    private let chevronView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = ConstantsColor.black500
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        return imageView
    }()

    private lazy var bottomRowStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [bottomTextStack, chevronView])
        stack.axis = .horizontal
        stack.alignment = .top
        stack.spacing = 16
        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        contentView.backgroundColor = .clear
        contentView.addSubview(containerView)
        
        containerView.addSubview(topRowStack)
        containerView.addSubview(badgeImageView)
        containerView.addSubview(separatorView)
        containerView.addSubview(bottomRowStack)
    }

    private func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.left.equalToSuperview().inset(16)
            $0.right.equalToSuperview().inset(16)
        }

        topRowStack.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
            $0.trailing.lessThanOrEqualTo(badgeImageView.snp.leading)
        }
        
        badgeImageView.snp.makeConstraints {
            $0.centerY.equalTo(topTitleLabel)
            $0.trailing.equalToSuperview().inset(16)
            $0.size.equalTo(CGSize(width: 44, height: 20))
        }

        separatorView.snp.makeConstraints {
            $0.top.equalTo(topRowStack.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }

        bottomRowStack.snp.makeConstraints {
            $0.top.equalTo(separatorView.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16)
            $0.size.height.equalTo(48)
        }
        
        chevronView.snp.makeConstraints {
            $0.centerY.equalTo(bottomTitleLabel)
            $0.width.equalTo(16)
        }

        topLeftIconView.snp.makeConstraints { $0.size.equalTo(24) }
    }

    func configureData(model: LimitSettingModel) {
        topLeftIconView.image = UIImage(named: model.topLeftIcon)
        topTitleLabel.text = "Limit Kartu Tarik Tunai"
        topAmountLabel.text = model.topSubtitleLabel
        bottomTitleLabel.text = "Limit harian terpakai"
        bottomUsedLabel.text = model.bottomSubtitleLabel

        badgeImageView.image = model.isPremiumBadge
            ? UIImage(named: "limit_setting_premium_badge_icon")
            : UIImage(named: "limit_setting_basic_badge_icon")
        
        if model.isPremiumBadge {
            badgeImageView.snp.remakeConstraints {
                $0.centerY.equalTo(topTitleLabel)
                $0.trailing.equalToSuperview().inset(16)
                $0.size.equalTo(CGSize(width: 66, height: 20))
            }
        }
    }
}

