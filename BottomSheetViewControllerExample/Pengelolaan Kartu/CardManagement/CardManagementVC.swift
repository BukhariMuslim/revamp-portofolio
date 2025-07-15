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

enum LIST_CARD_INDEX: Int {
    case status = 0
    case onlineTransaction
    case domesticTransaction
    case internationalTransaction
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
    private var switches: [CustomSizedSwitch] = []
    
    public var model: SavingCard!
    
    public var blockAction: EventHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraint()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = "Detail Kartu"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        updateScrollHeaderHeight()
    }
    
    private func setupView() {
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
        
        switches = [
            CustomSizedSwitch(),
            CustomSizedSwitch(),
            CustomSizedSwitch(),
            CustomSizedSwitch()
        ]
        
        settingsSectionView.items = [
            CardSettingsItem(
                icon: UIImage(named: "essentials/bank/single_outline"),
                text: "Status Kartu",
                showBottomBorder: true,
                rightView: switches[0],
                onTap: showActivateStatusCard
            ),
            CardSettingsItem(
                icon: UIImage(named: "utilities/globe"),
                text: "Transaksi Online",
                showBottomBorder: true,
                rightView: switches[1],
                onTap: showActivateOnlineTransaction
            ),
            CardSettingsItem(
                icon: UIImage(named: "utilities/rp"),
                text: "Transaksi Dalam Negeri",
                showBottomBorder: true,
                rightView: switches[2],
                onTap: showActivateDomesticTransaction
            ),
            CardSettingsItem(
                icon: UIImage(named: "essentials/dollar_square_outline"),
                text: "Transaksi Luar Negeri",
                showBottomBorder: true,
                rightView: switches[3],
                onTap: showActivateInternationalTransaction
            ),
            CardSettingsItem(
                icon: UIImage(named: "utilities/setting_outline"),
                text: "Transaksi Ubah Limit",
                showBottomBorder: true,
                rightView: CustomizedImage(imageName: "arrows/chevron_right"),
                onTap: showTransactionLimitSetting
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
                rightView: CustomizedImage(imageName: "arrows/chevron_right"),
                onTap: showPermanentBlockCard
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

extension CardManagementVC {
    private func showActivateStatusCard() {
        let vc: BottomSheetWithTwoBtnVC = BottomSheetWithTwoBtnVC()
        var title: String = "Aktifkan Status Kartu"
        var subtitle: String = "Kamu akan mengaktifkan kembali untuk Status Kartu"
        var agreeBtnTitle: String = "Ya, Aktifkan"
        let itemIndex: Int = LIST_CARD_INDEX.status.rawValue
        if switches[itemIndex].isOn {
            title = "Nonaktifkan Status Kartu"
            subtitle = "Penonaktifan ini bersifat sementara dan kartu dapat diaktifkan kembali kapan saja."
            agreeBtnTitle = "Ya, Nonaktifkan"
        }
        let buttonContent: BottomSheetTwoButtonContent = BottomSheetTwoButtonContent(
            image: "illustrations/confirmation",
            title: title,
            subtitle: subtitle,
            agreeBtnTitle: agreeBtnTitle,
            cancelBtnTitle: "Batalkan",
            actionButtonTap: { [weak self] in
                guard let self = self else { return }
                self.switches[itemIndex].isOn.toggle()
                if let item = self.settingsSectionView.items[itemIndex] as? CardSettingsItem {
                    item.rightView = self.switches[itemIndex]
                    var tempItems = self.settingsSectionView.items
                    tempItems[itemIndex] = item
                    self.settingsSectionView.items = tempItems
                }
            }
        )
        vc.setupContent(item: buttonContent)
        
        self.presentBrimonsBottomSheet(viewController: vc)
    }
    
    private func showActivateOnlineTransaction() {
        let vc: BottomSheetWithTwoBtnVC = BottomSheetWithTwoBtnVC()
        var title: String = "Aktifkan Transaksi Online"
        var subtitle: String = "Kamu akan mengaktifkan kembali untuk Transaksi Online pada kartu ini."
        var agreeBtnTitle: String = "Ya, Aktifkan"
        let itemIndex: Int = LIST_CARD_INDEX.onlineTransaction.rawValue
        if switches[itemIndex].isOn {
            title = "Nonaktifkan Transaksi Online"
            subtitle = "Penonaktifkan ini bersifat sementara dan dapat diaktifkan kembali untuk melakukan Transaksi Online pada kartu ini."
            agreeBtnTitle = "Ya, Nonaktifkan"
        }
        let buttonContent: BottomSheetTwoButtonContent = BottomSheetTwoButtonContent(
            image: "illustrations/confirmation",
            title: title,
            subtitle: subtitle,
            agreeBtnTitle: agreeBtnTitle,
            cancelBtnTitle: "Batalkan",
            actionButtonTap: { [weak self] in
                guard let self = self else { return }
                self.switches[itemIndex].isOn.toggle()
                if let item = self.settingsSectionView.items[itemIndex] as? CardSettingsItem {
                    item.rightView = self.switches[itemIndex]
                    var tempItems = self.settingsSectionView.items
                    tempItems[itemIndex] = item
                    self.settingsSectionView.items = tempItems
                }
            }
        )
        vc.setupContent(item: buttonContent)
        
        self.presentBrimonsBottomSheet(viewController: vc)
    }
    
    private func showActivateDomesticTransaction() {
        let vc: BottomSheetWithTwoBtnVC = BottomSheetWithTwoBtnVC()
        var title: String = "Aktifkan Transaksi Dalam Negeri"
        var subtitle: String = "Kamu akan mengaktifkan kembali untuk Transaksi Dalam Negeri pada kartu ini"
        var agreeBtnTitle: String = "Ya, Aktifkan"
        let itemIndex: Int = LIST_CARD_INDEX.domesticTransaction.rawValue
        if switches[itemIndex].isOn {
            title = "Nonaktifkan Transaksi Dalam Negeri"
            subtitle = "Penonaktifan ini bersifat sementara dan dapat dibuka kembali untuk Transaksi Dalam Negeri."
            agreeBtnTitle = "Ya, Nonaktifkan"
        }
        let buttonContent: BottomSheetTwoButtonContent = BottomSheetTwoButtonContent(
            image: "illustrations/confirmation",
            title: title,
            subtitle: subtitle,
            agreeBtnTitle: agreeBtnTitle,
            cancelBtnTitle: "Batalkan",
            actionButtonTap: { [weak self] in
                guard let self = self else { return }
                self.switches[itemIndex].isOn.toggle()
                if let item = self.settingsSectionView.items[itemIndex] as? CardSettingsItem {
                    item.rightView = self.switches[itemIndex]
                    var tempItems = self.settingsSectionView.items
                    tempItems[itemIndex] = item
                    self.settingsSectionView.items = tempItems
                }
            }
        )
        vc.setupContent(item: buttonContent)
        
        self.presentBrimonsBottomSheet(viewController: vc)
    }
    
    private func showActivateInternationalTransaction() {
        let vc: BottomSheetWithTwoBtnVC = BottomSheetWithTwoBtnVC()
        var title: String = "Aktifkan Transaksi Luar Negeri"
        var subtitle: String = "Kamu akan mengaktifkan kembali untuk Transaksi Luar Negeri pada kartu ini"
        var agreeBtnTitle: String = "Ya, Aktifkan"
        let itemIndex: Int = LIST_CARD_INDEX.internationalTransaction.rawValue
        if switches[itemIndex].isOn {
            title = "Nonaktifkan Transaksi Luar Negeri"
            subtitle = "Penonaktifan ini bersifat sementara dan dapat dibuka kembali untuk Transaksi Luar Negeri."
            agreeBtnTitle = "Ya, Nonaktifkan"
        }
        let buttonContent: BottomSheetTwoButtonContent = BottomSheetTwoButtonContent(
            image: "illustrations/confirmation",
            title: title,
            subtitle: subtitle,
            agreeBtnTitle: agreeBtnTitle,
            cancelBtnTitle: "Batalkan",
            actionButtonTap: { [weak self] in
                guard let self = self else { return }
                self.switches[itemIndex].isOn.toggle()
                if let item = self.settingsSectionView.items[itemIndex] as? CardSettingsItem {
                    item.rightView = self.switches[itemIndex]
                    var tempItems = self.settingsSectionView.items
                    tempItems[itemIndex] = item
                    self.settingsSectionView.items = tempItems
                }
            }
        )
        vc.setupContent(item: buttonContent)
        
        self.presentBrimonsBottomSheet(viewController: vc)
    }
    
    private func showTransactionLimitSetting() {
        let mockModels: LimitSettingModel = LimitSettingModel(
            topLeftIcon: "sms_orange_ic",
            topSubtitleLabel: "Rp15.000.000",
            bottomSubtitleLabel: "Rp0/Rp15.000.000",
            isPremiumBadge: Bool.random()
        )
        
        let limitSettingViewController: LimitSettingVC = LimitSettingVC()
        limitSettingViewController.models = [mockModels, mockModels, mockModels, mockModels]
        
        self.navigationController?.pushViewController(limitSettingViewController, animated: true)
    }
    
    private func showPermanentBlockCard() {
        let vc: BottomSheetWithTwoBtnVC = BottomSheetWithTwoBtnVC()
        let buttonContent: BottomSheetTwoButtonContent = BottomSheetTwoButtonContent(
            image: "illustrations/lock",
            title: "Blokir Kartu Permanen",
            subtitle: "Setelah diblokir, kartu debit kamu tidak dapat digunakan lagi untuk semua transaksi.",
            agreeBtnTitle: "Ya, Blokir",
            cancelBtnTitle: "Batalkan",
            actionButtonTap: { [weak self] in
                guard let self = self else { return }
                self.blockAction?()
                let vc: BlockedCardManagementVC = BlockedCardManagementVC()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        )
        vc.setupContent(item: buttonContent)
        
        self.presentBrimonsBottomSheet(viewController: vc)
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
