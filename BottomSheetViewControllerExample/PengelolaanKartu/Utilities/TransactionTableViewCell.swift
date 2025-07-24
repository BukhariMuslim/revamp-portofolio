//
//  TransactionTableViewCell.swift
//  BottomSheetViewControllerExample
//
//  Created by Bukhari Muslim on 17/07/25.
//

import UIKit
import SnapKit
import SkeletonView

class TransactionTableViewCell: UITableViewCell {
    private let iconView: UIImageView = UIImageView()
    private let titleLabel: UILabel = UILabel()
    private let subtitleLabel: UILabel = UILabel()
    private let amountLabel: UILabel = UILabel()
    private let statusView: UIView = UIView()
    private let statusLabel: UILabel = UILabel()
    private let containerStack: UIStackView = UIStackView()
    private let descriptionStack: UIStackView = UIStackView()
    private let rightStack: UIStackView = UIStackView()
    private let bottomBorderView: UIView = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .white
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        configureSkeleton()
        iconView.contentMode = .scaleAspectFit
        iconView.tintColor = .black
        iconView.configureSkeleton(cornerRadius: 12)
        iconView.snp.makeConstraints { $0.size.equalTo(24) }

        titleLabel.font = .Brimo.Body.mediumSemiBold
        titleLabel.textColor = .Brimo.Black.main
        titleLabel.configureSkeleton(cornerRadius: 7)
        
        subtitleLabel.font = .Brimo.Body.mediumRegular
        subtitleLabel.textColor = .Brimo.Black.x600
        subtitleLabel.numberOfLines = 0
        subtitleLabel.configureSkeleton(cornerRadius: 7)

        amountLabel.font = .Brimo.Body.largeSemiBold
        amountLabel.textColor = .Brimo.Black.main
        amountLabel.textAlignment = .right
        amountLabel.configureSkeleton(cornerRadius: 8)
        
        statusView.backgroundColor = .Brimo.Green.x100
        statusView.layer.cornerRadius = 8
        statusView.configureSkeleton(cornerRadius: 8)
        
        statusLabel.font = .Brimo.Body.smallSemiBold
        statusLabel.textColor = .Brimo.Green.main
        statusView.addSubview(statusLabel)

        descriptionStack.axis = .vertical
        descriptionStack.spacing = 4
        descriptionStack.addArrangedSubview(titleLabel)
        descriptionStack.addArrangedSubview(subtitleLabel)
        descriptionStack.configureSkeleton()
        
        rightStack.axis = .vertical
        rightStack.spacing = 0
        rightStack.alignment = .trailing
        rightStack.distribution = .equalSpacing
        rightStack.addArrangedSubview(amountLabel)
        rightStack.addArrangedSubview(statusView)
        rightStack.configureSkeleton()

        containerStack.axis = .horizontal
        containerStack.spacing = 12
        containerStack.alignment = .top
        containerStack.addArrangedSubview(iconView)
        containerStack.addArrangedSubview(descriptionStack)
        containerStack.addArrangedSubview(rightStack)
        containerStack.configureSkeleton()

        contentView.addSubview(containerStack)
        contentView.configureSkeleton()
        
        bottomBorderView.backgroundColor = .Brimo.Black.x200
        
        contentView.addSubview(bottomBorderView)
        
        containerStack.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12)
            $0.leading.trailing.equalToSuperview()
        }
        
        rightStack.snp.makeConstraints {
            $0.height.equalToSuperview()
        }
        
        statusLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(2)
            $0.leading.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview().inset(2)
        }
        
        bottomBorderView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(0)
        }
    }

    func configure(item: ActivityHistoryItemViewModel, isShowBorder: Bool = false) {
        var iconImage: UIImage? = UIImage()
        switch item.iconName {
        case ActivityIconType.qris.rawValue:
            iconImage = UIImage(named: "menu/qr")

        case ActivityIconType.transfer.rawValue:
            iconImage = UIImage(named: "menu/transfer")

        case ActivityIconType.transfer.rawValue:
            iconImage = UIImage(named: "menu/briva")
        
        case ActivityIconType.ewalet.rawValue:
            iconImage = UIImage(named: "menu/ewallet")

        default:
            break
        }
        iconView.image = iconImage
        titleLabel.text = item.title
        let subtitleText = [item.subTitle, item.date].joined(separator: "\n")
        subtitleLabel.setText(subtitleText, lineHeight: 18)
        if isShowBorder {
            amountLabel
                .setAmountLabel(
                    amountText: item.amount,
                    mainFont: .Brimo.Body.largeSemiBold,
                    decimalFont: .Brimo.Body.smallSemiBold
                )
        } else {
            amountLabel.text = item.amount
        }
        
        if isShowBorder {
            bottomBorderView.snp.updateConstraints {
                $0.height.equalTo(1)
            }
        } else {
            bottomBorderView.snp.updateConstraints {
                $0.height.equalTo(0)
            }
        }
        
        var statusLabelColor: UIColor = .Brimo.Green.main
        var statusViewBackgroundColor: UIColor = .Brimo.Green.x100
        var statuText: String = ""
        
        switch(item.status) {
        case ActivityItemStatus.success.rawValue:
            statusLabelColor = .Brimo.Green.main
            statusViewBackgroundColor = .Brimo.Green.x100
            statuText = "Success"
            
        case ActivityItemStatus.failed.rawValue:
            statusLabelColor = .Brimo.Red.main
            statusViewBackgroundColor = .Brimo.Red.x100
            statuText = "Gagal"
            
        case ActivityItemStatus.process.rawValue:
            statusLabelColor = .Brimo.Yellow.main
            statusViewBackgroundColor = .Brimo.Yellow.x100
            statuText = "Diproses"
            
        case ActivityItemStatus.pending.rawValue:
            statusLabelColor = .Brimo.Black.x700
            statusViewBackgroundColor = .Brimo.Black.x200
            statuText = "Menunggu"
            
        default: break
        }
        
        statusLabel.text = statuText
        statusLabel.textColor = statusLabelColor
        statusView.backgroundColor = statusViewBackgroundColor
    }
}

enum ActivityIconType: String {
    case qris = "icon_pembelian_qris"
    case transfer = "icon_transfer"
    case briva = "icon_briva"
    case ewalet = "icon_e_wallet"
}

enum ActivityItemStatus: String {
    case success
    case failed
    case process
    case pending
}
