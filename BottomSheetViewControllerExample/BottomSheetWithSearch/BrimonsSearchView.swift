//
//  BrimonsSearchView.swift
//  BottomSheetViewControllerExample
//
//  Created by PT Diksha Teknologi Indonesia on 27/06/25.
//

import UIKit
import SnapKit

class BrimonsSearchView: UIView {

    private let iconSize: CGFloat = 20
    private let padding: CGFloat = 12
    var onTextChanged: ((String) -> Void)?

    private lazy var searchIconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        imageView.tintColor = .gray
        return imageView
    }()

    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = .gray
        button.alpha = 0 // initially hidden
        button.addTarget(self, action: #selector(clearText), for: .touchUpInside)
        return button
    }()

    private lazy var textField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Search"
        tf.borderStyle = .none
        tf.keyboardType = .decimalPad
        tf.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        return tf
    }()
    
    var placeHolderTextField: String = "" {
        didSet {
            textField.placeholder = placeHolderTextField
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        self.backgroundColor = .systemGray6
        self.layer.cornerRadius = 22
        self.clipsToBounds = true

        addSubview(searchIconImageView)
        addSubview(closeButton)
        addSubview(textField)

        // Layout with SnapKit
        searchIconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(padding)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(iconSize)
        }

        closeButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(padding)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(iconSize)
        }

        textField.snp.makeConstraints { make in
            make.leading.equalTo(searchIconImageView.snp.trailing).offset(padding)
            make.trailing.equalTo(closeButton.snp.leading).offset(-padding)
            make.top.bottom.equalToSuperview()
        }

        self.snp.makeConstraints { make in
            make.height.equalTo(44)
        }
    }

    @objc private func clearText() {
        textField.text = ""
        closeButton.alpha = 0
    }

    @objc private func textDidChange() {
        let isEmpty = textField.text?.isEmpty ?? true
        UIView.animate(withDuration: 0.2) {
            self.closeButton.alpha = isEmpty ? 0 : 1
        }
        onTextChanged?(textField.text ?? "")
    }

    func getText() -> String {
        return textField.text ?? ""
    }
}
