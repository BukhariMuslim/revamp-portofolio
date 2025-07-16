//
//  CardManagementSettingsView.swift
//  BottomSheetViewControllerExample
//
//  Created by Bukhari Muslim on 09/07/25.
//

import UIKit
import SnapKit

class CardManagementSectionView: UIView {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .Brimo.Body.largeSemiBold
        label.textColor = .Brimo.Black.main
        return label
    }()
    
    private lazy var cardContainerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var cardStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 16
        return stack
    }()
    
    public var isHighlight: Bool = false {
        didSet {
            if isHighlight {
                cardContainerView.backgroundColor = .Brimo.Black.x100
                cardContainerView.layer.cornerRadius = 16
            } else {
                cardContainerView.backgroundColor = .clear
                cardContainerView.layer.cornerRadius = 0
            }
            remakeCardStackViewConstraint()
        }
    }
    
    public var items: [UIView] = [] {
        didSet {
            updateItems()
        }
    }
    
    init(title: String) {
        super.init(frame: .zero)
        titleLabel.text = title
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubviews(titleLabel, cardContainerView)
        cardContainerView.addSubview(cardStackView)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.trailing.equalToSuperview()
        }

        cardContainerView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(16)
        }

        remakeCardStackViewConstraint()
    }
    
    private func remakeCardStackViewConstraint() {
        let constraint: Int = isHighlight ? 16 : 0
        cardStackView.snp.remakeConstraints {
            $0.top.equalToSuperview().offset(constraint)
            $0.leading.equalToSuperview().offset(constraint)
            $0.trailing.equalToSuperview().inset(constraint)
            $0.bottom.equalToSuperview().inset(constraint)
        }
    }
    
    private func updateItems() {
        cardStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for item in items {
            cardStackView.addArrangedSubview(item)
        }
    }
}
