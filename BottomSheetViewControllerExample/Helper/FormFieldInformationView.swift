//
//  AliasInputView.swift
//  BottomSheetViewControllerExample
//
//  Created by Phincon on 08/07/25.
//


import UIKit
import SnapKit

final class FormFieldInformationView: UIView {

    // MARK: - Public Properties

    var titleTextColor: UIColor = .gray {
        didSet { titleLabel.textColor = titleTextColor }
    }

    var inputTextColor: UIColor = .black {
        didSet { textField.textColor = inputTextColor }
    }

    var placeholderText: String = "" {
        didSet {
            if !isActive {
                setPlaceholder(placeholderText)
            }
        }
    }

    var activeBorderColor: UIColor = UIColor(red: 0.0, green: 0.46, blue: 1.0, alpha: 1.0)
    var inactiveBorderColor: UIColor = .clear

    public private(set) var textField: UITextField = {
        let tf = UITextField()
        tf.placeholder = ""
        tf.font = .Brimo.Body.largeSemiBold
        tf.textColor = ConstantsColor.black900
        tf.borderStyle = .none
        tf.textAlignment = .left
        tf.backgroundColor = .clear
        return tf
    }()

    public private(set) var titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .Brimo.Body.mediumRegular
        label.textColor = ConstantsColor.black900
        label.alpha = 0
        return label
    }()

    public private(set) var errorLabel: UILabel = {
        let label = UILabel()
        label.font = .Brimo.Body.mediumRegular
        label.textColor = ConstantsColor.black500
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()

    public func setError(_ message: String?) {
        errorLabel.text = message
        errorLabel.isHidden = message == nil
    }

    // MARK: - Private Properties

    private var isActive: Bool = false {
        didSet {
            updateUI(animated: true)
        }
    }
    
    var onTextChange: ((String) -> Void)?

    private var centerYConstraint: Constraint?
    private var bottomConstraint: Constraint?

    // MARK: - UI Components

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.96, green: 0.97, blue: 1, alpha: 1)
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.clear.cgColor
        return view
    }()

    private let clearButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .gray
        button.isHidden = true
        return button
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
        setupEvents()
        updateUI(animated: false)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Setup

    private func setupView() {
        addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(textField)
        containerView.addSubview(clearButton)
        addSubview(errorLabel)

        clearButton.addTarget(self, action: #selector(clearText), for: .touchUpInside)
    }

    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(56)
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(containerView).offset(12)
            make.top.equalTo(containerView).offset(10)
        }

        clearButton.snp.makeConstraints { make in
            make.trailing.equalTo(containerView).inset(12)
            make.centerY.equalTo(containerView)
            make.size.equalTo(20)
        }

        textField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalTo(containerView).offset(12)
            make.trailing.equalTo(clearButton.snp.leading).offset(-8)

            centerYConstraint = make.centerY.equalTo(containerView).constraint
            bottomConstraint = make.bottom.equalTo(containerView).inset(10).constraint
            bottomConstraint?.deactivate()
        }

        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

    private func setupEvents() {
        textField.addTarget(self, action: #selector(textFieldDidBeginEditing), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(textFieldDidEndEditing), for: .editingDidEnd)
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }

    // MARK: - Actions

    @objc private func clearText() {
        textField.text = ""
        textField.sendActions(for: .editingChanged)
    }

    @objc private func textFieldDidBeginEditing() {
        isActive = true
    }

    @objc private func textFieldDidEndEditing() {
        isActive = !(textField.text?.isEmpty ?? true)
    }

    @objc private func textFieldDidChange() {
        onTextChange?(textField.text ?? "")
    }

    // MARK: - UI Update

    private func updateUI(animated: Bool) {
        let shouldShowTitle = isActive || !(textField.text?.isEmpty ?? true)
        let newBorderColor = isActive ? activeBorderColor.cgColor : inactiveBorderColor.cgColor
        clearButton.isHidden = !isActive

        let animations = {
            self.titleLabel.alpha = shouldShowTitle ? 1 : 0

            let placeholder = shouldShowTitle ? "" : self.placeholderText
            self.setPlaceholder(placeholder)

            self.containerView.layer.borderColor = newBorderColor

            if shouldShowTitle {
                self.centerYConstraint?.deactivate()
                self.bottomConstraint?.activate()
            } else {
                self.bottomConstraint?.deactivate()
                self.centerYConstraint?.activate()
            }

            self.layoutIfNeeded()
        }

        if animated {
            UIView.animate(withDuration: 0.25, animations: animations)
        } else {
            animations()
        }
    }

    // MARK: - Helper

    private func setPlaceholder(_ text: String) {
        textField.attributedPlaceholder = NSAttributedString(
            string: text,
            attributes: [.foregroundColor: ConstantsColor.black900]
        )
    }
}
