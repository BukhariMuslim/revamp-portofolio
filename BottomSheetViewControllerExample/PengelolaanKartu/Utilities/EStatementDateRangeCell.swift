//
//  EStatementDateRangeCell.swift
//  BottomSheetViewControllerExample
//
//  Created by User01 on 18/07/25.
//

import UIKit

class EStatementDateRangeCell: UITableViewCell {

    static let identifier = "EStatementDateRangeCell"

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .Brimo.Black.x100
        view.layer.cornerRadius = 16
        return view
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Rentang Waktu"
        label.font = .Brimo.Body.mediumRegular
        label.textColor = ConstantsColor.black900
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "01 Jun - 30 Jun 2025"
        label.font = .Brimo.Body.largeSemiBold
        label.textColor = ConstantsColor.black900
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()

    private let calendarIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "calendar_ic")
        imageView.tintColor = .black
        return imageView
    }()

    private let textStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 2
        return stack
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        selectionStyle = .none
        backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        contentView.addSubview(containerView)
        containerView.addSubview(textStack)
        containerView.addSubview(calendarIcon)

        textStack.addArrangedSubview(subtitleLabel)
        textStack.addArrangedSubview(titleLabel)

        subtitleLabel.snp.makeConstraints { make in
            make.height.equalTo(18)
        }

        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
        }

        textStack.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(12)
            make.leading.equalToSuperview().inset(16)
            make.trailing.lessThanOrEqualTo(calendarIcon.snp.leading).offset(-8)
        }

        calendarIcon.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
    }

    func configure(isLast: Bool) {
        containerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(isLast ? 0 : 12)
        }
    }
}
