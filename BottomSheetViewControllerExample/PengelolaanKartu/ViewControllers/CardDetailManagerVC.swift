//
//  CardDetailManagerVC.swift
//  BottomSheetViewControllerExample
//
//  Created by Phincon on 07/07/25.
//

import Foundation
import UIKit
import SnapKit

struct CardMenuItem {
    let title: String
    let image: String
    let action: EventHandler?
    
    init(title: String, image: String, action: EventHandler? = nil) {
        self.title = title
        self.image = image
        self.action = action
    }
}

final class CardDetailManagerVC: UIViewController {
    private let backgroundContainerView: UIImageView = {
        let img: UIImageView = UIImageView()
        img.image = UIImage(named: "background_blue_secondary")
        return img
    }()
    
    private let headerView: UIView = UIView()
    private let headerContent: AccountCardManagerHeaderView = AccountCardManagerHeaderView()

    private let menuCollectionView: AccountCardManagerCategoryView = AccountCardManagerCategoryView()
    
    private let listActivityView: AccountCardDetailManagerActivityView = AccountCardDetailManagerActivityView()
    
    private let filterView: ActivityFilterHeaderView = ActivityFilterHeaderView()
    
    private let contentView: UIView = UIView()
    private var scrollContainerView: StickyRoundedContainerView!
    
    private var isBlocked: Bool = false
    
    private var saldoLoading: Bool = false {
        didSet {
            headerContent.isLoading = saldoLoading
            menuCollectionView.isLoading = saldoLoading
        }
    }
    
    private var activityListLoading: Bool = false {
        didSet {
            listActivityView.isLoading = activityListLoading
            filterView.isLoading = activityListLoading
            if scrollContainerView != nil {
                scrollContainerView.isLoading = activityListLoading
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraint()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "BritAma"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateScrollHeaderHeight()
    }
    
    private func setupView(){
        let menuItems: [CardMenuItem] = [
            CardMenuItem(
                title: "Informasi Rekening",
                image: "menu/deposito",
                action: showDetailInformation
            ),
            
            CardMenuItem(
                title: "Detail Kartu",
                image: "menu/credit_card",
                action: isBlocked ? showBlockedDetailCard : showDetailCard
            )//,
            
//            CardMenuItem(
//                title: "E-Statement",
//                image: "menu/pasca_bayar",
//                action: showEStatementInformation
//            )
        ]

        menuCollectionView.configure(items: menuItems)

        listActivityView.onItemSelected = listActivityItemSelected
        contentView.addSubviews(listActivityView)
        
        headerView.addSubviews(headerContent, menuCollectionView)
        
        scrollContainerView = StickyRoundedContainerView(
            headerView: headerView,
            contentView: contentView,
            isStickyEnabled: true,
            compositeHeaderBuilder: { [weak self] container in
                guard let self = self else { return }
                container.addSubview(filterView)
                
                filterView.snp.makeConstraints {
                    $0.edges.equalToSuperview()
                }
            }
        )
        
        view.backgroundColor = ConstantsColor.white900
        view.addSubviews(backgroundContainerView, scrollContainerView)
    }
    
    private func listActivityItemSelected(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func showDetailInformation() {
        let vc: CardDetailInformationVC = CardDetailInformationVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showBlockedDetailCard() {
        let vc: BlockedCardManagementVC = BlockedCardManagementVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showDetailCard() {
        let vc: CardManagementVC = CardManagementVC()
        vc.blockAction = { [weak self] in
            guard let self = self else { return }
            self.isBlocked = true
        }
        navigationController?.pushViewController(vc, animated: true)
    }

    private func showEStatementInformation() {
        //let vc: BrimoNsEStatementListViewController = BrimoNsEStatementListViewController()
        let vc: EStatementEntryVC = EStatementEntryVC()
        navigationController?.pushViewController(vc, animated: true)
    }

    private func setupConstraint(){
        backgroundContainerView.snp.remakeConstraints {
            $0.top.trailing.leading.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        scrollContainerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        headerContent.snp.remakeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        
        menuCollectionView.snp.remakeConstraints {
            $0.top.equalTo(headerContent.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(24)
        }
        
        listActivityView.snp.remakeConstraints {
            $0.top.equalToSuperview().offset(-8)
            $0.leading.trailing.equalToSuperview()
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
