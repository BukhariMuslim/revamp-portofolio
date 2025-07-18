//
//  ReusableBottomSheetViewController.swift
//  BottomSheetViewControllerExample
//
//  Created by sia santos on 17/07/25.
//

import UIKit
import SnapKit

class ReusableBottomSheetViewController: BrimonsBottomSheetVC {
    
    var onActionButtonTapped: (() -> Void)?
    var onCloseButtonTapped: (() -> Void)?
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.Brimo.White.main
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.Brimo.Title.mediumSemiBold
        label.textColor = UIColor.Brimo.Black.main
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = UIColor.Brimo.Black.main
        return button
    }()
    
    private let contentContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.Brimo.White.main
        return view
    }()
    
    private let actionButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.Brimo.Primary.main
        button.layer.cornerRadius = 25
        button.titleLabel?.font = UIFont.Brimo.Title.mediumSemiBold
        button.setTitleColor(UIColor.Brimo.White.main, for: .normal)
        return button
    }()
    
    var titleText: String = "Title" {
        didSet { titleLabel.text = titleText }
    }
    
    var buttonTitle: String = "Simpan" {
        didSet { actionButton.setTitle(buttonTitle, for: .normal) }
    }
    
    var contentView: UIView? {
        didSet { setupContentView() }
    }
    
    var shouldShowButton: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupActions()
    }
    
    private func setupViews() {
        containerView.addSubviews(
            titleLabel,
            closeButton,
            contentContainerView
        )
        
        if shouldShowButton {
            containerView.addSubview(actionButton)
        }
        
        setContent(content: containerView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.leading.greaterThanOrEqualToSuperview().offset(60)
            make.trailing.lessThanOrEqualToSuperview().offset(-60)
        }
        
        closeButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.trailing.equalToSuperview().inset(20)
            make.width.height.equalTo(24)
        }
        
        contentContainerView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview()
            if shouldShowButton {
                make.bottom.equalTo(actionButton.snp.top).offset(-20)
            } else {
                make.bottom.equalTo(containerView.safeAreaLayoutGuide.snp.bottom).offset(-20)
            }
        }
        
        if shouldShowButton {
            actionButton.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(20)
                make.height.equalTo(50)
                make.bottom.equalTo(containerView.safeAreaLayoutGuide.snp.bottom).offset(-20)
            }
            actionButton.setTitle(buttonTitle, for: .normal)
        }
    }
    
    private func setupContentView() {
        contentContainerView.subviews.forEach { $0.removeFromSuperview() }
        guard let contentView = contentView else { return }
        
        contentContainerView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupActions() {
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        if shouldShowButton {
            actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        }
    }
    
    @objc private func actionButtonTapped() {
        onActionButtonTapped?()
    }
    
    @objc private func closeButtonTapped() {
        if let onClose = onCloseButtonTapped {
            onClose()
        } else {
            dismissBottomSheet()
        }
    }
}

extension ReusableBottomSheetViewController {
    static func create(
        title: String,
        buttonTitle: String = "Simpan",
        contentView: UIView,
        showActionButton: Bool = true,
        onActionTapped: (() -> Void)? = nil,
        onCloseTapped: (() -> Void)? = nil
    ) -> ReusableBottomSheetViewController {
        let controller = ReusableBottomSheetViewController()
        controller.titleText = title
        controller.buttonTitle = buttonTitle
        controller.contentView = contentView
        controller.shouldShowButton = showActionButton
        controller.onActionButtonTapped = onActionTapped
        controller.onCloseButtonTapped = onCloseTapped
        return controller
    }
}
