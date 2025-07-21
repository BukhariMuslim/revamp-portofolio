//
//  EStatementMonthCell.swift
//  BottomSheetViewControllerExample
//
//  Created by User01 on 18/07/25.
//

import UIKit

class EStatementMonthCell: UITableViewCell {

    static let identifier = "EStatementMonthCell"

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .Brimo.Black.x100
        view.layer.cornerRadius = 16
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .Brimo.Body.largeRegular
        label.textColor = ConstantsColor.black900
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .Brimo.Body.mediumRegular
        label.textColor = ConstantsColor.black500
        return label
    }()

    private let textStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        return stack
    }()

    private let chevronImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "arrows/chevron_right"))
        imageView.tintColor = .black
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear

        setupUI()

        isSkeletonable = true
        contentView.isSkeletonable = true
        [containerView, textStack, titleLabel, subtitleLabel, chevronImage].forEach {
            $0.isSkeletonable = true
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.addSubview(textStack)
        containerView.addSubview(chevronImage)

        textStack.addArrangedSubview(titleLabel)
        textStack.addArrangedSubview(subtitleLabel)

        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.height.equalTo(18)
        }

        textStack.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview().inset(16)
            make.trailing.lessThanOrEqualTo(chevronImage.snp.leading).offset(-8)
        }

        chevronImage.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
    }
    func configureIsLast(_ isLast: Bool) {
        containerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(isLast ? 0 : 16)
        }
    }

    func configure(title: String, subtitle: String?) {
        titleLabel.text = title
        if let subtitle = subtitle, !subtitle.isEmpty {
            subtitleLabel.isHidden = false
            subtitleLabel.text = subtitle
        } else {
            subtitleLabel.isHidden = true
        }
    }
}
