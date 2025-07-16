//
//  TransactionLimitView.swift
//  BottomSheetViewControllerExample
//
//  Created by sia santos on 16/07/25.
//

import UIKit
import SnapKit

final class TransactionLimitView: UIView {
    var onValueChanged: ((Double) -> Void)?
    var onKeyboardHeightChange: (() -> Void)?
    
    private let limitInput = TransactionLimitTextFieldCellView()
    private let errorLabel = UILabel()
    private let slider = UISlider()
    private let minLabel = UILabel()
    private let maxLabel = UILabel()
    
    private let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "Rp"
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        formatter.groupingSeparator = "."
        formatter.locale = Locale(identifier: "id_ID")
        return formatter
    }()
    
    private var sliderTopConstraint: Constraint?
    private var minLimit: Double = 10_000
    private var maxLimit: Double = 15_000_000
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        layoutUI()
        wireActions()
        updateState(value: 0)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    func setInitialValue(_ v: Double, dataModel: CardLimitDataModel) {
        minLimit = Double(dataModel.minimumLimit)
        maxLimit = Double(dataModel.maximumLimit)

        slider.minimumValue = Float(minLimit)
        slider.maximumValue = Float(maxLimit)

        let clamped = max(minLimit, min(maxLimit, v))
        limitInput.textField.text = formatter.string(from: clamped as NSNumber)
        slider.setValue(Float(clamped), animated: false)
        updateState(value: clamped)

        // update labels
        minLabel.text = formatRupiah(Int(minLimit))
        maxLabel.text = formatRupiah(Int(maxLimit))
    }

    private func formatRupiah(_ value: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        formatter.locale = Locale(identifier: "id_ID")
        return "Rp" + (formatter.string(from: NSNumber(value: value)) ?? "\(value)")
    }
    
    private func configureUI() {
        backgroundColor = .systemBackground
        errorLabel.font = .systemFont(ofSize: 12)
        errorLabel.textColor = .systemRed
        errorLabel.text = "Batas maksimal limit adalah Rp\(maxLimit)"
        errorLabel.isHidden = true
        
        slider.minimumValue = Float(minLimit)
        slider.maximumValue = Float(maxLimit)
        
        [minLabel, maxLabel].forEach { $0.font = .systemFont(ofSize: 12) }
        minLabel.text = formatRupiah(Int(minLimit))
        maxLabel.text = formatRupiah(Int(maxLimit))
        
        limitInput.textField.text = formatter.string(from: 0)
    }
    
    private func layoutUI() {
        addSubviews(limitInput, errorLabel,
                    slider, minLabel, maxLabel)
        
        limitInput.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        
        errorLabel.snp.makeConstraints {
            $0.top.equalTo(limitInput.snp.bottom).offset(8)
            $0.leading.equalTo(limitInput)
        }
        
        slider.snp.makeConstraints {
            sliderTopConstraint = $0.top.equalTo(errorLabel.snp.bottom).offset(16).constraint
            $0.leading.trailing.equalTo(limitInput)
        }
        
        minLabel.snp.makeConstraints {
            $0.top.equalTo(slider.snp.bottom).offset(4)
            $0.leading.equalTo(slider)
            $0.bottom.equalToSuperview().inset(24)
        }
        
        maxLabel.snp.makeConstraints {
            $0.centerY.equalTo(minLabel)
            $0.trailing.equalTo(slider)
        }
    }
    
    private func wireActions() {
        limitInput.textField.delegate = self
        limitInput.textField.addTarget(self,
                                       action: #selector(textFieldChanged(_:)),
                                       for: .editingChanged)
        slider.addTarget(self, action: #selector(sliderChanged(_:)), for: .valueChanged)
    }
    
    @objc private func textFieldChanged(_ tf: UITextField) {
        let digits = tf.text?.components(separatedBy: CharacterSet.decimalDigits.inverted).joined() ?? "0"
        let value = Double(digits) ?? 0
        tf.text = formatter.string(from: value as NSNumber)
        slider.setValue(Float(value), animated: true)
        updateState(value: value)
    }
    
    @objc private func sliderChanged(_ s: UISlider) {
        let stepped = Double(Int(s.value / 1000) * 1000)
        limitInput.textField.text = formatter.string(from: stepped as NSNumber)
        updateState(value: stepped)
    }
    
    
    private func updateState(value: Double) {
        var errorText: String? = nil
        
        if value < minLimit {
            errorText = "Batas minimal limit adalah \(formatRupiah(Int(minLimit)))"
        } else if value > maxLimit {
            errorText = "Batas maksimal limit adalah \(formatRupiah(Int(maxLimit)))"
        }

        if let error = errorText {
            errorLabel.text = error
            errorLabel.isHidden = false
            sliderTopConstraint?.update(offset: 16)
            limitInput.layer.borderWidth = 1
            limitInput.layer.borderColor = UIColor.systemRed.cgColor
        } else {
            errorLabel.isHidden = true
            sliderTopConstraint?.update(offset: 0)
            limitInput.layer.borderWidth = 0
            limitInput.layer.borderColor = nil
            onValueChanged?(value)
        }

        UIView.animate(withDuration: 0.25) {
            self.layoutIfNeeded()
        }
    }

}

extension TransactionLimitView: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.isEmpty ?? true {
            textField.text = formatter.string(from: 0)
            updateState(value: 0)
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.onKeyboardHeightChange?()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string.isEmpty { return true }
        let currentText = textField.text ?? ""
        let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
        let digitsOnly = prospectiveText.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        return digitsOnly.count <= 12
    }
}
