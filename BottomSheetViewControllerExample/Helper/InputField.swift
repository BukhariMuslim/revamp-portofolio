//
//  InputField.swift
//  BottomSheetViewControllerExample
//
//  Created by Phincon on 08/07/25.
//


import UIKit
import Combine

private extension UIColor {
    static var inputFieldBackground: UIColor {
        return UIColor.Brimo.Black.x100
    }
    
    static var inputFieldHint: UIColor {
        return UIColor.Brimo.Black.x500
    }
}

final class InputField: UIView {

    // MARK: - Enums
    enum InputFieldType {
        case standard
        case prefix(String)
        case dropdown
    }
    
    enum State {
        case normal
        case active
        case error(String)
        case disabled
        case disabledFilled
    }

    private(set) var state: State = .normal {
        didSet {
            updateUI(for: state)
        }
    }
    
    private let type: InputFieldType

    private var chevronWidthConstraint: NSLayoutConstraint!
    private var chevronHeightConstraint: NSLayoutConstraint!

    // MARK: - UI Components
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 16
        return view
    }()

    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .none
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }()

    private lazy var floatingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var prefixLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.isHidden = true
        return label
    }()

    private lazy var bottomLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor.Brimo.Black.main
        label.isHidden = true
        return label
    }()

    private lazy var chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "chevron.down")
        imageView.tintColor = UIColor.Brimo.Black.main
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        return imageView
    }()

    // MARK: - Properties
    var text: String? {
        get { return textField.text }
        set {
            textField.text = newValue
            textFieldDidChange()
            updateStateForText()
        }
    }

    var placeholder: String? {
        didSet {
            if case .dropdown = type {
                if let placeholder = placeholder {
                    textField.font = .Brimo.Body.largeRegular
                    textField.attributedPlaceholder = NSAttributedString(
                        string: placeholder,
                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.Brimo.Black.main]
                    )
                } else {
                    textField.attributedPlaceholder = nil
                }
            } else {
                floatingLabel.text = placeholder
            }
        }
    }
    
    var title: String? {
        didSet {
            titleLabel.text = title
            titleLabel.isHidden = title == nil
            
            // Update constraints based on title presence
            if title != nil {
                containerTopToViewConstraint?.isActive = false
                containerTopToTitleConstraint?.isActive = true
            } else {
                containerTopToTitleConstraint?.isActive = false
                containerTopToViewConstraint?.isActive = true
            }
        }
    }
    
    var hintText: String? {
        didSet {
            updateUI(for: state)
        }
    }
    
    var keyboardType: UIKeyboardType {
        get { return textField.keyboardType }
        set { textField.keyboardType = newValue }
    }
    
    var isSecureTextEntry: Bool {
        get { return textField.isSecureTextEntry }
        set { textField.isSecureTextEntry = newValue }
    }

    var textAlignment: NSTextAlignment {
        get { return textField.textAlignment }
        set { textField.textAlignment = newValue }
    }
    
    var font: UIFont? {
        get { return textField.font }
        set { textField.font = newValue }
    }
    
    weak var delegate: UITextFieldDelegate? {
        get { return textField.delegate }
        set { textField.delegate = newValue }
    }

    var onDropdownTapped: (() -> Void)?
    var onFocusChange: ((Bool) -> Void)?

    // For floating label animation
    private var floatingLabelYConstraint: NSLayoutConstraint?
    private let floatingAnimationOffset: CGFloat = -12
    private let placeholderFontSize: CGFloat = 14
    private let floatingLabelFontSize: CGFloat = 12
    
    // For title label positioning
    private var containerTopToTitleConstraint: NSLayoutConstraint?
    private var containerTopToViewConstraint: NSLayoutConstraint?

    // MARK: - Initialization
    init(type: InputFieldType = .standard, frame: CGRect = .zero) {
        self.type = type
        super.init(frame: frame)
        setupViews()
        setupDelegates()
        updateUI(for: .normal)
        updateStateForText()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods
    func setState(_ newState: State) {
        self.state = newState
    }

    override func becomeFirstResponder() -> Bool {
        return textField.becomeFirstResponder()
    }

    // MARK: - Setup
    private func setupViews() {
        addSubview(containerView)
        containerView.addSubview(floatingLabel)
        containerView.addSubview(textField)
        addSubview(bottomLabel)
        addSubview(titleLabel)
        containerView.addSubview(chevronImageView)
        
        floatingLabel.font = .systemFont(ofSize: placeholderFontSize)
        bottomLabel.font = .systemFont(ofSize: 12)
        titleLabel.font = .systemFont(ofSize: 14, weight: .medium)

        setupConstraints()
    }

    private func setupDelegates() {
        textField.delegate = self
    }

    private func setupConstraints() {
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        bottomLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        bottomLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        bottomLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        switch type {
        case .standard:
            setupStandardConstraints()
        case .prefix(let prefixString):
            prefixLabel.text = prefixString
            setupPrefixConstraints()
        case .dropdown:
            setupDropdownConstraints()
        }
    }
    
    private func setupStandardConstraints() {
        textField.font = .systemFont(ofSize: placeholderFontSize)
        
        // Create both possible constraints for container positioning
        containerTopToTitleConstraint = containerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16)
        containerTopToViewConstraint = containerView.topAnchor.constraint(equalTo: topAnchor)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 64),

            textField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            textField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            textField.heightAnchor.constraint(equalToConstant: 20),
            
            bottomLabel.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 4)
        ])
        
        // Activate appropriate constraint based on title presence
        if title != nil {
            containerTopToTitleConstraint?.isActive = true
        } else {
            containerTopToViewConstraint?.isActive = true
        }
        
        floatingLabel.leadingAnchor.constraint(equalTo: textField.leadingAnchor).isActive = true
        floatingLabelYConstraint = floatingLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        floatingLabelYConstraint?.isActive = true
    }
    
    private func setupPrefixConstraints() {
        containerView.addSubview(prefixLabel)
        prefixLabel.isHidden = false
        textField.font = .systemFont(ofSize: 24, weight: .bold)
        floatingLabel.font = .systemFont(ofSize: floatingLabelFontSize)
        
        // Create both possible constraints for container positioning
        containerTopToTitleConstraint = containerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8)
        containerTopToViewConstraint = containerView.topAnchor.constraint(equalTo: topAnchor)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 80),
            
            floatingLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            floatingLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            
            prefixLabel.leadingAnchor.constraint(equalTo: floatingLabel.leadingAnchor),
            prefixLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            prefixLabel.widthAnchor.constraint(equalToConstant: 34),

            textField.leadingAnchor.constraint(equalTo: prefixLabel.trailingAnchor, constant: 4),
            textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            textField.lastBaselineAnchor.constraint(equalTo: prefixLabel.lastBaselineAnchor),
            
            bottomLabel.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 4)
        ])
        
        // Activate appropriate constraint based on title presence
        if title != nil {
            containerTopToTitleConstraint?.isActive = true
        } else {
            containerTopToViewConstraint?.isActive = true
        }
    }
    
    private func setupDropdownConstraints() {
        chevronImageView.isHidden = false
        floatingLabel.isHidden = true
        textField.isUserInteractionEnabled = false

        containerTopToTitleConstraint = containerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16)
        containerTopToViewConstraint = containerView.topAnchor.constraint(equalTo: topAnchor)

        chevronWidthConstraint = chevronImageView.widthAnchor.constraint(equalToConstant: 16)
        chevronHeightConstraint = chevronImageView.heightAnchor.constraint(equalToConstant: 16)

        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 64),

            textField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            textField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            textField.trailingAnchor.constraint(equalTo: chevronImageView.leadingAnchor, constant: -8),

            chevronImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            chevronImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            chevronWidthConstraint,
            chevronHeightConstraint,

            bottomLabel.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 4)
        ])

        if title != nil {
            containerTopToTitleConstraint?.isActive = true
        } else {
            containerTopToViewConstraint?.isActive = true
        }

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dropdownTapped))
        containerView.addGestureRecognizer(tapGesture)
    }
    
    private func updateStateForText() {
        guard case .standard = type else { return }
        if textField.text?.isEmpty ?? true {
            hideFloatingLabel(animated: false)
        } else {
            showFloatingLabel(animated: false)
        }
    }

    // MARK: - UI Updates
    private func updateUI(for state: State) {
        if let hint = hintText, case .error = state {
            // Error message takes priority
        } else if let hint = hintText {
            bottomLabel.text = hint
            bottomLabel.textColor = .inputFieldHint
            bottomLabel.isHidden = false
        } else {
            bottomLabel.isHidden = true
            bottomLabel.text = ""
        }

        switch state {
        case .normal:
            containerView.layer.borderColor = UIColor.Brimo.Black.x200.cgColor
            floatingLabel.textColor = .inputFieldHint
            textField.isEnabled = true
            textField.textColor = UIColor.Brimo.Black.main
            containerView.backgroundColor = .inputFieldBackground
        case .active:
            containerView.layer.borderColor = UIColor.Brimo.Primary.main.cgColor
            floatingLabel.textColor = UIColor.Brimo.Primary.main
            textField.isEnabled = true
            textField.textColor = UIColor.Brimo.Black.main
            containerView.backgroundColor = .inputFieldBackground
        case .error(let message):
            containerView.layer.borderColor = UIColor.Brimo.Red.main.cgColor
            floatingLabel.textColor = UIColor.Brimo.Red.main
            bottomLabel.text = message
            bottomLabel.textColor = UIColor.Brimo.Red.main
            bottomLabel.isHidden = false
            textField.isEnabled = true
            textField.textColor = UIColor.Brimo.Black.main
            containerView.backgroundColor = .inputFieldBackground
        case .disabled:
            containerView.layer.borderColor = UIColor.Brimo.Black.x200.cgColor
            floatingLabel.textColor = .inputFieldHint
            textField.isEnabled = false
            textField.text = ""
            textField.textColor = .inputFieldHint
            containerView.backgroundColor = .inputFieldBackground
            hideFloatingLabel(animated: false)
        case .disabledFilled:
            containerView.layer.borderColor = UIColor.Brimo.Black.x200.cgColor
            floatingLabel.textColor = UIColor.Brimo.Black.x600
            textField.isEnabled = false
            textField.textColor = UIColor.Brimo.Black.x600
            containerView.backgroundColor = .inputFieldBackground
            showFloatingLabel(animated: false)
        }
        
        if case .dropdown = type {
            textField.isEnabled = false
        }

        if case .prefix = type {
            floatingLabel.textColor = .inputFieldHint
        }

        if case .error = state {
            if case .prefix = type {
                floatingLabel.textColor = UIColor.Brimo.Red.main
            }
        }
    }

    // MARK: - Actions & Animations
    @objc private func textFieldDidChange() {
        if case .error = state {
            setState(.active)
        }
    }

    @objc private func dropdownTapped() {
        onDropdownTapped?()
    }

    private func showFloatingLabel(animated: Bool) {
        guard case .standard = type else { return }
        
        floatingLabelYConstraint?.constant = floatingAnimationOffset
        
        let animator = UIViewPropertyAnimator(duration: animated ? 0.3 : 0, curve: .easeInOut) {
            self.floatingLabel.font = .systemFont(ofSize: self.floatingLabelFontSize)
            self.layoutIfNeeded()
        }
        animator.startAnimation()
    }

    private func hideFloatingLabel(animated: Bool) {
        guard case .standard = type else { return }
        
        floatingLabelYConstraint?.constant = 0
        
        let animator = UIViewPropertyAnimator(duration: animated ? 0.3 : 0, curve: .easeInOut) {
            self.floatingLabel.font = .systemFont(ofSize: self.placeholderFontSize)
            self.layoutIfNeeded()
        }
        animator.startAnimation()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateUI(for: state)
    }
}

// MARK: - UITextFieldDelegate
extension InputField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if case .dropdown = type { return }
        if case .disabled = state { return }
        if case .disabledFilled = state { return }
        
        setState(.active)
        if case .standard = type {
            showFloatingLabel(animated: true)
        }
        onFocusChange?(true)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if case .dropdown = type { return }
        if case .disabled = state { return }
        if case .disabledFilled = state { return }
        
        if case .error = state {
            // Keep error state
            return
        }
        
        setState(.normal)
       
        if case .standard = type, textField.text?.isEmpty ?? true {
            hideFloatingLabel(animated: true)
        }
        onFocusChange?(false)
    }
}

extension InputField {
    func setInputField(isUserInteraction: Bool) {
        textField.isUserInteractionEnabled = isUserInteraction
    }

    func setInputFieldFont(_ font: UIFont) {
        textField.font = font
    }

    func setInputFieldTextColor(_ color: UIColor) {
        textField.textColor = color
    }

    func borderOff() {
        containerView.layer.borderWidth = 0
    }

    func changeImageView(icon: UIImage) {
        chevronImageView.image = icon
    }

    public func resizeImageView(width: CGFloat, height: CGFloat, animated: Bool = false) {
        chevronWidthConstraint.constant = width
        chevronHeightConstraint.constant = height

        if animated {
            UIView.animate(withDuration: 0.3) {
                self.layoutIfNeeded()
            }
        } else {
            self.layoutIfNeeded()
        }
    }

    func showFloatingLabelForced(font: UIFont, color: UIColor, text: String? = "") {
        let animated = false
        floatingLabelYConstraint?.constant = floatingAnimationOffset
        floatingLabel.isHidden = false

        let animator = UIViewPropertyAnimator(duration: animated ? 0.3 : 0, curve: .easeInOut) {
            self.floatingLabel.font = font
            self.floatingLabel.textColor = color
            if self.floatingLabel.text != "" {
                self.floatingLabel.text = text
            }
            self.layoutIfNeeded()
        }
        animator.startAnimation()
    }

    func setupFloatingLabel() {
        guard case .dropdown = type else { return }
        floatingLabel.leadingAnchor.constraint(equalTo: textField.leadingAnchor).isActive = true
        floatingLabelYConstraint = floatingLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        floatingLabelYConstraint?.isActive = true
    }
}
