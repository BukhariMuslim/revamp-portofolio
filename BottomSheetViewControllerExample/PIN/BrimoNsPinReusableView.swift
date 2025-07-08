//
//  BrimoNsPinReusableVIew.swift
//  BottomSheetViewControllerExample
//
//  Created by PT Diksha Teknologi Indonesia on 29/06/25.
//

import Foundation
import UIKit
import Combine
import SnapKit

protocol BrimoNsReusablePinViewDelegate: AnyObject {
    func didTapForgotPin()
    func didFinishInput(pin: String)
    func didReachMaxAttempt()
}

final class BrimoNsPinReusableView: UIView {
    
    // MARK: - Properties
    private let viewModel: BrimoNsReusablePinProtocol
    private var cancellables = Set<AnyCancellable>()
    weak var delegate: BrimoNsReusablePinViewDelegate?
    
    // MARK: - UI Components
    private let titleLabel = UILabel()
    private let forgotButton = UIButton(type: .system)
    private let pinContainer = UIStackView()
    private let pinStackView = UIStackView()
    private let errorLabel = UILabel()
    private let numberPadStackView = UIStackView()
    private var pinDots: [UIView] = []
    
    // MARK: - Init
    init(viewModel: BrimoNsReusablePinProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
        setupNumberPad()
        setupBindings()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
    private func setupViews() {
        backgroundColor = .white
//        backgroundColor = .Brimo.White.main
        
        titleLabel.text = "Masukkan PIN"
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.textColor = .black
//        titleLabel.textColor = .Brimo.Black.main
        titleLabel.textAlignment = .center
        
        forgotButton.setTitle("Lupa PIN?", for: .normal)
//        forgotButton.setTitleColor(.Brimo.Primary.main, for: .normal)
        forgotButton.setTitleColor(.black, for: .normal)
        forgotButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        forgotButton.addTarget(self, action: #selector(forgotButtonTapped), for: .touchUpInside)
        
        pinContainer.axis = .vertical
        pinContainer.spacing = 16
        pinContainer.alignment = .center
        
        pinStackView.axis = .horizontal
        pinStackView.spacing = 32
        for _ in 0..<6 {
            let dot = createPinDot()
            pinDots.append(dot)
            pinStackView.addArrangedSubview(dot)
        }
        
        errorLabel.font = .systemFont(ofSize: 12, weight: .medium)
//        errorLabel.textColor = .Brimo.Red.main
        errorLabel.textColor = .red
        errorLabel.textAlignment = .center
        errorLabel.numberOfLines = 0 // ✅ multiline aktif
        errorLabel.lineBreakMode = .byWordWrapping // ✅ pastikan wrap
        errorLabel.isHidden = true
        
        pinContainer.addArrangedSubview(pinStackView)
        pinContainer.addArrangedSubview(errorLabel)
        
        numberPadStackView.axis = .vertical
        numberPadStackView.spacing = 16
        
        addSubview(titleLabel)
        addSubview(pinContainer)
        addSubview(forgotButton)
        addSubview(numberPadStackView)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(32)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        pinContainer.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
        }

        errorLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(32) // ✅ penting untuk wrapping
        }

        forgotButton.snp.makeConstraints {
            $0.top.equalTo(pinContainer.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
        }

        numberPadStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.top.greaterThanOrEqualTo(forgotButton.snp.bottom).offset(24)
            $0.bottom.equalToSuperview().inset(32)
            $0.height.equalTo(400)
        }
    }

    private func createPinDot() -> UIView {
        let dot = UIView()
//        dot.backgroundColor = .Brimo.Black.x300
        dot.backgroundColor = .black.withAlphaComponent(0.6)
        dot.layer.cornerRadius = 8
        dot.snp.makeConstraints { $0.size.equalTo(16) }
        return dot
    }

    private func setupNumberPad() {
        let keys = [
            ["1", "2", "3"],
            ["4", "5", "6"],
            ["7", "8", "9"],
            ["", "0", "←"]
        ]
        
        for row in keys {
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.spacing = 16
            rowStack.distribution = .fillEqually
            
            for key in row {
                let button = createNumberButton(key)
                rowStack.addArrangedSubview(button)
            }
            
            numberPadStackView.addArrangedSubview(rowStack)
        }
    }

    private func createNumberButton(_ title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 32, weight: .medium)
//        button.setTitleColor(.Brimo.Black.main, for: .normal)
//        button.backgroundColor = (title.isEmpty || title == "←") ? .clear : .Brimo.Black.x100
        button.setTitleColor(.black.withAlphaComponent(0.6), for: .normal)
        button.backgroundColor = (title.isEmpty || title == "←") ? .clear : .black.withAlphaComponent(0.5)
        button.layer.cornerRadius = 16
        button.snp.makeConstraints { $0.height.equalTo(84) }

        if title == "←" {
            button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        } else if !title.isEmpty {
            button.addTarget(self, action: #selector(numberButtonTapped(_:)), for: .touchUpInside)
        }

        return button
    }

    // MARK: - Bindings
    private func setupBindings() {
        viewModel.pinState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.updatePinDots(filledCount: state.filledDots)
            }
            .store(in: &cancellables)

        viewModel.pinValidationState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.handleValidationState(state)
            }
            .store(in: &cancellables)

        viewModel.errorMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                if let message = errorMessage {
                    self?.showError(message)
                } else {
                    self?.hideError()
                }
            }
            .store(in: &cancellables)
        
        viewModel.didReachMaxAttempt
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.delegate?.didReachMaxAttempt()
            }
            .store(in: &cancellables)
    }

    // MARK: - Actions
    @objc private func numberButtonTapped(_ sender: UIButton) {
        guard let number = sender.title(for: .normal) else { return }
        viewModel.clearError()
        viewModel.addDigit(number)
    }

    @objc private func deleteButtonTapped() {
        viewModel.clearError()
        viewModel.deleteDigit()
    }

    @objc private func forgotButtonTapped() {
        delegate?.didTapForgotPin()
    }

    // MARK: - Helper Methods
    private func updatePinDots(filledCount: Int) {
        let hasError = !errorLabel.isHidden
        for (index, dot) in pinDots.enumerated() {
            dot.backgroundColor = index < filledCount
            ? (hasError ? .red : .blue)
            : .black.withAlphaComponent(0.6)
        }
    }

    private func handleValidationState(_ state: PinReusableValidationState) {
        switch state {
        case .valid:
            viewModel.pinState
                .first()
                .receive(on: DispatchQueue.main)
                .sink { [weak self] state in
                    self?.delegate?.didFinishInput(pin: state.currentPin)
                }
                .store(in: &cancellables)
        case .invalid(let message):
            showError(message)
        default: break
        }
    }

    private func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
        updatePinDots(filledCount: 6)
    }

    private func hideError() {
        errorLabel.text = ""
        errorLabel.isHidden = true
    }
}
