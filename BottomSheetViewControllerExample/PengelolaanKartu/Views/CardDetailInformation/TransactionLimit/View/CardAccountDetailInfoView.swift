//
//  CardAccountDetailInfoView.swift
//  BottomSheetViewControllerExample
//
//  Created by Phincon on 08/07/25.
//

import Foundation
import UIKit

class CardAccountDetailInfoView: UIView {

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray6
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()

    private let cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "debit")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Marsela Nababan"
        label.font = .Brimo.Body.largeRegular
        label.textColor = ConstantsColor.black900
        return label
    }()

    private let cardNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "1212 **** **** 3254"
        label.font = .Brimo.Title.smallSemiBold
        label.textColor = ConstantsColor.black900
        return label
    }()

    private let chevronImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        imageView.tintColor = ConstantsColor.black900
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }

    private func setupLayout() {
        addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        containerView.addSubview(cardImageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(cardNumberLabel)
        containerView.addSubview(chevronImageView)

        cardImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(58)
            $0.height.equalTo(36)
        }

        chevronImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(16)
        }

        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(cardImageView.snp.trailing).offset(16)
            $0.trailing.lessThanOrEqualTo(chevronImageView.snp.leading).offset(-8)
            $0.top.equalToSuperview().offset(16)
        }

        cardNumberLabel.snp.makeConstraints {
            $0.leading.equalTo(nameLabel)
            $0.trailing.lessThanOrEqualTo(chevronImageView.snp.leading).offset(-8)
            $0.top.equalTo(nameLabel.snp.bottom).offset(4)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
}
