//
//  CardManagementVC.swift
//  BottomSheetViewControllerExample
//
//  Created by Bukhari Muslim on 08/07/25.
//

import UIKit
import SnapKit

struct SavingCard {
    let name: String
    let cardName: String
    let cardType: String
    let cardNumber: String
    let currency: String
}

class CardManagementVC: UIViewController {
    private lazy var backgroundContainerView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "background_blue_secondary")
        return img
    }()
    
    private lazy var pinnedRoundedContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 24
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.masksToBounds = true
        return view
    }()
    
    private var isMasked: Bool = true
    private var headerHeight: CGFloat = 0
    private let headerView: CardManagementHeaderView = CardManagementHeaderView()
    private let topCardView: CardManagementSectionView = CardManagementSectionView(
        title: "Rekening Terhubung"
    )
    private let settingsSectionView: CardManagementSectionView = CardManagementSectionView(
        title: "Pengaturan Kartu"
    )
    private let contentView: UIView = UIView()
    private var scrollContainerView: StickyRoundedContainerView!
    
    public var model: SavingCard!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraint()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        updateScrollHeaderHeight()
    }
    
    private func setupView() {
        title = "Detail Kartu"
        
        model = SavingCard(
            name: "Marsela Satya",
            cardName: "BritAma",
            cardType: "classic",
            cardNumber: "0290344596811122",
            currency: "IDR"
        )
        
        topCardView.isHighlight = true
        topCardView.items = [
            CardInfoItem(
                key: CardInfoDetail.jenisRek.rawValue,
                value: model.cardName
            ),
            CardInfoItem(
                key: CardInfoDetail.nomorRek.rawValue,
                value: model.cardNumber
                    .spaced(
                        isMasked: isMasked,
                        maskedOnSeqenceIndex: [1, 2]
                    )
            ),
            CardInfoItem(
                key: CardInfoDetail.currency.rawValue,
                value: model.currency,
                symbol: UIImage(named: "flags/circle/indonesia")
            )
        ]
        
        settingsSectionView.items = [
            CardSettingsItem(
                icon: UIImage(named: "essentials/bank/single_outline"),
                text: "Status Kartu",
                showBottomBorder: true,
                rightView: CustomSizedSwitch()
            ),
            CardSettingsItem(
                icon: UIImage(named: "utilities/globe"),
                text: "Transaksi Online",
                showBottomBorder: true,
                rightView: CustomSizedSwitch()
            ),
            CardSettingsItem(
                icon: UIImage(named: "utilities/rp"),
                text: "Transaksi Dalam Negeri",
                showBottomBorder: true,
                rightView: CustomSizedSwitch()
            ),
            CardSettingsItem(
                icon: UIImage(named: "essentials/dollar_square_outline"),
                text: "Transaksi Luar Negeri",
                showBottomBorder: true,
                rightView: CustomSizedSwitch()
            ),
            CardSettingsItem(
                icon: UIImage(named: "utilities/setting_outline"),
                text: "Transaksi Ubah Limit",
                showBottomBorder: true,
                rightView: CustomizedImage(imageName: "arrows/chevron_right")
            ),
            CardSettingsItem(
                icon: UIImage(named: "utilities/card_edit_outline"),
                text: "Ubah PIN Kartu Debit",
                showBottomBorder: true,
                rightView: CustomizedImage(imageName: "arrows/chevron_right")
            ),
            CardSettingsItem(
                icon: UIImage(named: "utilities/lock"),
                text: "Blokir kartu permanen",
                rightView: CustomizedImage(imageName: "arrows/chevron_right")
            )
        ]
        
        headerView.name = model.name
        headerView.accountNumber = model.cardNumber
            .spaced(
                isMasked: isMasked,
                maskedOnSeqenceIndex: [1, 2]
            )
        
        contentView.addSubviews(topCardView, settingsSectionView)
        
        scrollContainerView = StickyRoundedContainerView(
            headerView: headerView,
            contentView: contentView,
            isStickyEnabled: true
        )
        
        view.backgroundColor = ConstantsColor.white900
        view.addSubviews(backgroundContainerView, scrollContainerView)
    }
    
    private func setupConstraint() {
        backgroundContainerView.snp.remakeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        scrollContainerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        topCardView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(-8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        settingsSectionView.snp.makeConstraints {
            $0.top.equalTo(topCardView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
    
    private func updateScrollHeaderHeight() {
        headerView.layoutIfNeeded()
        
        let headerHeight = headerView.systemLayoutSizeFitting(
            CGSize(width: view.bounds.width, height: UIView.layoutFittingCompressedSize.height)
        ).height
        
        scrollContainerView.setHeaderHeight(headerHeight)
    }
}

extension String {
    func spaced(every n: Int = 4, isMasked: Bool = false, maskedWith mask: Character = "•", maskedOnSeqenceIndex sequence: Set<Int> = Set()) -> String {
        return self.enumerated().map { index, char in
            let charAfterMasked = isMasked ? sequence.contains(index / n) ? mask : char : char
            return (index > 0 && index % n == 0) ? " \(charAfterMasked)" : "\(charAfterMasked)"
        }.joined()
    }
}
