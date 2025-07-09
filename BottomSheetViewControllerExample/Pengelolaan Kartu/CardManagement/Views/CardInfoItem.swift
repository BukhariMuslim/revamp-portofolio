//
//  ManagementCardConnectedItem.swift
//  BottomSheetViewControllerExample
//
//  Created by Bukhari Muslim on 08/07/25.
//

import UIKit
import SnapKit

enum CardInfoDetail: String {
    case jenisRek = "Jenis Rekening"
    case nomorRek = "Nomor Rekening"
    case currency = "Mata Uang"
}

class CardInfoItem: UIView {
    private lazy var keyLabel: UILabel = {
        let label = UILabel()
        label.font = .Brimo.Body.largeRegular
        label.textColor = .Brimo.Black.x600
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.font = .Brimo.Body.largeRegular
        label.textColor = .Brimo.Black.main
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.textAlignment = .right
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(16)
        }
        return imageView
    }()
    
    private lazy var rightStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 4
        stack.alignment = .center
        return stack
    }()
    
    private lazy var stackContainer: UIStackView = {
        let container: UIStackView = .init(
            arrangedSubviews: [keyLabel, rightStack]
        )
        container.axis = .horizontal
        container.spacing = 8
        container.alignment = .center
        container.distribution = .fill
        return container
    }()
    
    init(key: String, value: String, symbol: UIImage? = nil) {
        super.init(frame: .zero)
        setupUI()
        configure(key, value, symbol)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(stackContainer)
        
        stackContainer.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func configure(_ key: String, _ value: String, _ symbolImage: UIImage?) {
        keyLabel.text = key
        valueLabel.text = value
        
        rightStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        if let image = symbolImage {
            imageView.image = image
            rightStack.addArrangedSubview(imageView)
        }
        
        rightStack.addArrangedSubview(valueLabel)
    }
}
