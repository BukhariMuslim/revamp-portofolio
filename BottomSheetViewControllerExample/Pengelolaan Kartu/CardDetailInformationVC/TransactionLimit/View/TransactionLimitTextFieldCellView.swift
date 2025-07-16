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
    
    private let clearButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "limit_setting_close_button_textfield"), for: .normal)
        btn.tintColor = UIColor.systemGray
        btn.layer.borderColor = UIColor.systemGray4.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 10
        btn.contentEdgeInsets = .init(top: 2, left: 2, bottom: 2, right: 2)
        return btn
    }()
    
    // MARK: Init
    
    init() {
        super.init(frame: .zero)
        setupView()
        setupConstraints()
        clearButton.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupView() {
        backgroundColor = UIColor.systemGray6
        layer.cornerRadius = 20
        addSubviews(titleLabel, textField, clearButton)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
            $0.trailing.lessThanOrEqualTo(clearButton.snp.leading).offset(-8)
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalTo(clearButton.snp.leading).offset(-8)
            $0.bottom.equalToSuperview().inset(16)
        }
        clearButton.snp.makeConstraints {
            $0.centerY.equalTo(textField)
            $0.trailing.equalToSuperview().inset(16)
            $0.size.equalTo(20)
        }
    }
    
    @objc private func clearTapped() { textField.text = "Rp0" }
}
