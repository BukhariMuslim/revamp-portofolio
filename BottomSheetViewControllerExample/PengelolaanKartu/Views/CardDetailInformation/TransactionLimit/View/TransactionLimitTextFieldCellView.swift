//
//  TransactionLimitTextFieldCellView.swift
//  BottomSheetViewControllerExample
//
//  Created by sia santos on 16/07/25.
//

import UIKit
import SnapKit

// MARK: - Reusable rounded input view
class TransactionLimitTextFieldCellView: UIView {
    
    let textField: UITextField = {
        let tf = UITextField()
        tf.font = .boldSystemFont(ofSize: 24)
        tf.textColor = .black
        tf.keyboardType = .numberPad
        tf.borderStyle = .none
        tf.backgroundColor = .clear
        tf.setContentHuggingPriority(.defaultLow, for: .vertical)
        return tf
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "Nominal Limit"
        label.textColor = UIColor.secondaryLabel
        return label
    }()
    
    // MARK: Init
    
    init() {
        super.init(frame: .zero)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupView() {
        backgroundColor = UIColor.systemGray6
        layer.cornerRadius = 20
        
        textField.clearButtonMode = .always
        textField.tintColor = .label

        addSubviews(titleLabel, textField)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().offset(-8)
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalToSuperview().offset(-8)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
    
    @objc private func clearTapped() {
        textField.text = "Rp0"
    }
}
