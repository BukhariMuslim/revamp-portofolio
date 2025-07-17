//
//  RiwayatMutasiCellView.swift
//  BottomSheetViewControllerExample
//
//  Created by sia santos on 17/07/25.
//

import UIKit
import SnapKit

class RiwayatMutasiCellView: UICollectionViewCell {
    
    static let reuseIdentifier = "RiwayatAktifitasCellView"

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let transactionIDLabel: UILabel = {
        let label = UILabel()
        label.font = .Brimo.Body.mediumSemiBold
        label.textColor = .Brimo.Black.main
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .Brimo.Body.mediumSemiBold
        label.textColor = .Brimo.Black.main
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .Brimo.Body.largeSemiBold
        label.textAlignment = .right
        label.numberOfLines = 1
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .Brimo.Body.mediumRegular
        label.textColor = ConstantsColor.black500
        label.textAlignment = .right
        label.numberOfLines = 1
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.94, green: 0.94, blue: 0.96, alpha: 1.0)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .clear
        
        addSubview(containerView)
        containerView.addSubviews(
            transactionIDLabel,
            descriptionLabel,
            priceLabel,
            timeLabel,
            separatorView
        )
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        priceLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(16)
            make.width.greaterThanOrEqualTo(120)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.trailing.equalTo(priceLabel)
            make.top.equalTo(priceLabel.snp.bottom).offset(4)
            make.width.greaterThanOrEqualTo(100)
        }
        
        transactionIDLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(16)
            make.trailing.lessThanOrEqualTo(priceLabel.snp.leading).offset(-16)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(transactionIDLabel)
            make.top.equalTo(transactionIDLabel.snp.bottom).offset(4)
            make.trailing.lessThanOrEqualTo(timeLabel.snp.leading).offset(-16)
        }
        
        separatorView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
        transactionIDLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        descriptionLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }
    
    func configure(with transaction: RiwayatMutasiItemModel, isLastIndex: Bool = false) {
        transactionIDLabel.text = transaction.transactionID
        descriptionLabel.text = transaction.description
        
        if transaction.price.hasPrefix("+") {
            priceLabel.textColor = UIColor(hexString: "#27AE60")
        } else {
            priceLabel.textColor = .black
        }
        priceLabel.text = transaction.price
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        timeLabel.text = "\(formatter.string(from: transaction.time)) WIB"
        separatorView.isHidden = isLastIndex
    }
}
