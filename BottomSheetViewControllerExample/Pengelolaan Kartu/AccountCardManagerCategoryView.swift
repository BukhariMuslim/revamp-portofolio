//
//  CardMenu.swift
//  BottomSheetViewControllerExample
//
//  Created by Phincon on 07/07/25.
//

import Foundation
import UIKit
import SnapKit

class AccountCardManagerCard: UIView {
    
    private let iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.tintColor = .orange
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .Brimo.Body.largeRegular
        label.textColor = ConstantsColor.white900
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private var action: EventHandler?
    
    init(title: String, image: String, action: EventHandler?) {
        super.init(frame: .zero)
        self.action = action
        setupUI()
        iconView.image = UIImage(named: image)
        titleLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(iconView)
        addSubview(titleLabel)
        
        iconView.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 56, height: 56))
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconView.snp.bottom).offset(8)
            make.bottom.leading.trailing.equalToSuperview()
        }
        
        if action != nil {
            isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
            self.addGestureRecognizer(tap)
            self.isUserInteractionEnabled = true
        }
    }
    
    @objc private func viewTapped() {
        action?()
    }
}


class AccountCardManagerCategoryView: UIView {
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 5
        stack.alignment = .top
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func configure(items: [CardMenuItem]) {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        for item in items {
            let view = AccountCardManagerCard(title: item.title, image: item.image, action: item.action)
            stackView.addArrangedSubview(view)
        }

        // Adjust distribution
        if items.count <= 2 {
            stackView.distribution = .equalSpacing
        } else {
            stackView.distribution = .fillEqually
        }
    }
}
