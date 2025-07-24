//
//  CustomSingleCardComponentView.swift
//  BottomSheetViewControllerExample
//
//  Created by User01 on 18/07/25.
//

import UIKit

class CustomSingleCardComponentView: UIView {
    private let iconImageView: UIImageView = UIImageView()
    private let nameLabel: UILabel = UILabel()
    private let detailLabel: UILabel = UILabel()

    init(icon: UIImage?, name: String, detail: String) {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()

        if icon != nil {
            iconImageView.image = icon
        } else {
            iconImageView.backgroundColor = ConstantsColor.neutralLight10
        }

        nameLabel.text = name
        detailLabel.text = detail
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupConstraints()
    }

    private func setupViews() {
        clipsToBounds = true

        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.layer.cornerRadius = 4
        iconImageView.clipsToBounds = true
        iconImageView.isSkeletonable = true

        addSubview(iconImageView)

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = .Brimo.Body.mediumRegular
        nameLabel.textColor = ConstantsColor.black900
        nameLabel.isSkeletonable = true

        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.font = .Brimo.Body.mediumRegular
        detailLabel.textColor = ConstantsColor.black500
        detailLabel.isSkeletonable = true

        addSubview(nameLabel)
        addSubview(detailLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 58),
            iconImageView.heightAnchor.constraint(equalToConstant: 36),

            nameLabel.topAnchor.constraint(equalTo: topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 18),

            detailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            detailLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            detailLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            detailLabel.heightAnchor.constraint(equalToConstant: 18),
            detailLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension CustomSingleCardComponentView {
    func changeTextColors(color1: UIColor, color2: UIColor) {
        nameLabel.textColor = color1
        detailLabel.textColor = color2
    }

    func changeTextFonts(font1: UIFont, font2: UIFont) {
        nameLabel.font = font1
        detailLabel.font = font2
    }
}
