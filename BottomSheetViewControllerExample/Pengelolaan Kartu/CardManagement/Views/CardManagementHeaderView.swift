//
//  CardManagementHeaderView.swift
//  BottomSheetViewControllerExample
//
//  Created by Bukhari Muslim on 08/07/25.
//

import UIKit
import SnapKit

enum CardType {
    case classic
    case gold
}

class CardManagementHeaderView: UIView {
    var image: UIImage? {
        didSet {
            cardImageView.image = image
        }
    }
    
    private let cardImageView: UIImageView =  {
        let imageView: UIImageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .Brimo.Title.smallRegular
        label.textColor = .Brimo.White.main
        return label
    }()
    
    private let accountNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .Brimo.Title.smallRegular
        label.textColor = .Brimo.White.main
        return label
    }()
    
    public var type: CardType = .classic {
        didSet {
            switch type {
            default:
                cardImageView.image = UIImage(named: "kartu_debit_bg")
            }
        }
    }
    
    public var name: String = "" {
        didSet {
            nameLabel.text = name
        }
    }
    
    public var accountNumber: String = "" {
        didSet {
            accountNumberLabel.text = accountNumber
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }

    private func setupLayout() {
        addSubviews(cardImageView, nameLabel, accountNumberLabel)
        image = UIImage(named: "kartu_debit_bg")
        
        cardImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(cardImageView.snp.width).multipliedBy(212.0 / 343.0)
            $0.bottom.equalToSuperview().inset(24)
        }
        
        accountNumberLabel.snp.makeConstraints {
            $0.leading.equalTo(cardImageView.snp.leading).offset(16)
            $0.bottom.equalToSuperview().inset(40)
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(cardImageView.snp.leading).offset(16)
            $0.bottom.equalTo(accountNumberLabel.snp.top).offset(-8)
        }
    }
}
