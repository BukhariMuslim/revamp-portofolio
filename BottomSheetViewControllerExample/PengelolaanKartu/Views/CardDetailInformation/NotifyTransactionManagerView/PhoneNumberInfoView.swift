//
//  PhoneNumberInfoView.swift
//  BottomSheetViewControllerExample
//
//  Created by Phincon on 10/07/25.
//

import Foundation
import UIKit
import SnapKit

final class PhoneNumberInfoView: UIView {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "No. Handphone"
        label.font = .Brimo.Body.largeRegular
        label.textColor = ConstantsColor.black900
        return label
    }()
    
    private let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "0822 2222 9999"
        label.font = .Brimo.Body.largeSemiBold
        label.textColor = ConstantsColor.black900
        label.textAlignment = .right
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = ConstantsColor.black100
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let hStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.spacing = 8
        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupViews() {
        addSubview(containerView)
        containerView.addSubview(hStack)
        hStack.addArrangedSubview(titleLabel)
        hStack.addArrangedSubview(phoneNumberLabel)
    }

    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        hStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(16)
        }
    }
}
