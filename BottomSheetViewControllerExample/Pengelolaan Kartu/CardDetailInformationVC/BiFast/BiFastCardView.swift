//
//  PhoneConnectionCardView.swift
//  BottomSheetViewControllerExample
//
//  Created by Phincon on 08/07/25.
//


import UIKit
import SnapKit

struct BiFastCardItem {
    var leftIcon: String
    var title: String
    var subTitle: String
    var titleBtn: String
}

final class BiFastCardView: UIView {

    // MARK: - Public Components
    let connectButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.Brimo.Body.mediumSemiBold
        button.setTitleColor(ConstantsColor.white900, for: .normal)
        button.backgroundColor = .Brimo.Primary.main
        button.layer.cornerRadius = 16
        return button
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = ConstantsColor.black900
        label.font = .Brimo.Body.largeSemiBold
        return label
    }()

    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .Brimo.Body.mediumRegular
        label.textColor = ConstantsColor.black900
        return label
    }()

    // MARK: - Private Components

    private let leftIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let infoStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 2
        return stack
    }()
    
    var connectBtnAction: (() -> Void)?

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Setup

    private func setupView() {
        backgroundColor = ConstantsColor.black100
        layer.cornerRadius = 16
        clipsToBounds = true

        infoStack.addArrangedSubview(subTitleLabel)
        infoStack.addArrangedSubview(titleLabel)

        addSubviews(leftIconView, infoStack, connectButton)
        connectButton.addTarget(self, action: #selector(connectBtn), for: .touchUpInside)
    }

    private func setupConstraints() {
        leftIconView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }

        infoStack.snp.makeConstraints {
            $0.leading.equalTo(leftIconView.snp.trailing).offset(12)
            $0.centerY.equalToSuperview()
            $0.top.equalToSuperview().inset(12).priority(.high)
        }

        connectButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(32)
            $0.width.greaterThanOrEqualTo(100)
        }
    }
    
    func setupContent(item: BiFastCardItem){
        connectButton.setTitle(item.titleBtn, for: .normal)
        leftIconView.image = UIImage(named: item.leftIcon)?.withRenderingMode(.alwaysTemplate)
        leftIconView.tintColor = ConstantsColor.black900
        titleLabel.text = item.title
        subTitleLabel.text = item.subTitle
    }
    
    @objc private func connectBtn(_ sender: UIButton){
        connectBtnAction?()
    }
}
