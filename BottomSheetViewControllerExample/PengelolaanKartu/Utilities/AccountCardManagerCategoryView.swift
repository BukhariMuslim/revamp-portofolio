//
//  CardMenu.swift
//  BottomSheetViewControllerExample
//
//  Created by Phincon on 07/07/25.
//

import Foundation
import UIKit
import SnapKit
import SkeletonView

class AccountCardManagerCard: UIView {
    
    private let iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.tintColor = .orange
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        imageView.configureSkeleton(cornerRadius: 16)
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .Brimo.Body.largeRegular
        label.textColor = ConstantsColor.white900
        label.numberOfLines = 2
        label.textAlignment = .center
        label.configureSkeleton(cornerRadius: 7)
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
        configureSkeleton()
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
    
    public var isLoading: Bool = false {
        didSet {
            setSkeleton()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        configureSkeleton()
        stackView.configureSkeleton()
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.centerX.equalToSuperview()
            make.leading.greaterThanOrEqualToSuperview().offset(12)
            make.trailing.lessThanOrEqualToSuperview().inset(12)
        }
    }
    
    var selectedIndex: ((Int)-> Void)?

    func configure(items: [CardMenuItem]) {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        for (_, item) in items.enumerated() {
            let view = AccountCardManagerCard(title: item.title, image: item.image, action: item.action)
            stackView.addArrangedSubview(view)
        }
        
        stackView.distribution = .fillEqually
    }
    
    @objc private func handleCardTap(_ sender: UITapGestureRecognizer) {
        guard let tappedView = sender.view else { return }
        let index = tappedView.tag
        selectedIndex?(index)
    }
    
    private func setSkeleton() {
        if isLoading {
            showAnimatedSkeleton(usingColor: .Brimo.Primary.main)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) { [weak self] in
                guard let self = self else { return }
                self.stackView.subviews.forEach { $0.showAnimatedSkeleton(usingColor: .Brimo.Primary.main) }
            }
        } else {
            stopSkeletonAnimation()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) { [weak self] in
                guard let self = self else { return }
                self.stackView.subviews.forEach { $0.stopSkeletonAnimation() }
            }
        }
    }
}


extension UIView {
    func prepareSkeletonRecursively() {
        isSkeletonable = true
        subviews.forEach { $0.prepareSkeletonRecursively() }
    }
}
