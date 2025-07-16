//
//  CardSettingsItem.swift
//  BottomSheetViewControllerExample
//
//  Created by Bukhari Muslim on 09/07/25.
//

import UIKit
import SnapKit

class CardSettingsItem: UIView {
    // MARK: - Subviews
    private let iconView: UIImageView = {
        let iv = UIImageView()
        iv.tintColor = .Brimo.Black.x600
        iv.contentMode = .scaleAspectFit
        iv.setContentHuggingPriority(.required, for: .horizontal)
        iv.snp.makeConstraints { $0.size.equalTo(24) }
        return iv
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.font = .Brimo.Body.largeSemiBold
        label.textColor = .Brimo.Black.main
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var leftStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [iconView, textLabel])
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        return stack
    }()
    
    private lazy var containerStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [leftStack, rightView])
        stack.axis = .horizontal
        stack.spacing = 12
        stack.alignment = .center
        stack.distribution = .fill
        return stack
    }()
    
    private let bottomBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = .Brimo.Black.x200
        return view
    }()
    
    private let tapGesture = UITapGestureRecognizer()
    private let showBottomBorder: Bool
    var rightView: UIView
    
    // MARK: - Init
    init(
        icon: UIImage?,
        text: String,
        showBottomBorder: Bool = false,
        rightView: UIView = UIView(),
        onTap: (() -> Void)? = nil
    ) {
        self.rightView = rightView
        self.showBottomBorder = showBottomBorder
        self.onTap = onTap
        super.init(frame: .zero)
        
        setupUI()
        configure(icon: icon, text: text)
        
        if onTap != nil {
            addGestureRecognizer(tapGesture)
            tapGesture.addTarget(self, action: #selector(handleTap))
            isUserInteractionEnabled = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Logic
    private var onTap: (() -> Void)?
    
    @objc private func handleTap() {
        onTap?()
    }
    
    private func setupUI() {
        addSubview(containerStack)
        containerStack.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        if showBottomBorder {
            addSubview(bottomBorderView)
            bottomBorderView.snp.makeConstraints {
                $0.top.equalTo(containerStack.snp.bottom).offset(16)
                $0.leading.trailing.equalToSuperview()
                $0.height.equalTo(1)
                $0.bottom.equalToSuperview()
            }
        } else {
            containerStack.snp.makeConstraints {
                $0.top.leading.trailing.equalToSuperview()
                $0.bottom.equalToSuperview().inset(16)
            }
        }
    }
    
    private func configure(icon: UIImage?, text: String) {
        if let icon = icon {
            iconView.image = icon.withRenderingMode(.alwaysTemplate)
        }
        textLabel.text = text
    }
}
