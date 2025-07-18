//
//  EStatementOptionView.swift
//  BottomSheetViewControllerExample
//
//  Created by User01 on 18/07/25.
//

import UIKit

final class EStatementOptionView: UIView {

    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let tapArea = UIView()

    init(image: UIImage?, title: String) {
        super.init(frame: .zero)
        setup(image: image, title: title)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup(image: UIImage?, title: String) {
        addSubview(tapArea)
        tapArea.addSubviews(iconImageView, titleLabel)

        iconImageView.image = image
        iconImageView.contentMode = .scaleAspectFit

        titleLabel.text = title
        titleLabel.font = .Brimo.Body.largeSemiBold
        titleLabel.textColor = ConstantsColor.black900

        tapArea.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(40)
        }

        iconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }

        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(iconImageView.snp.trailing).offset(12)
            $0.centerY.equalToSuperview()
            $0.trailing.lessThanOrEqualToSuperview()
        }
    }
}
