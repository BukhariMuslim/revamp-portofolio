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
        let img = UIImageView()
        img.image = UIImage(named: "background_blue_secondary")
        return img
    }()
    
    private let headerView = AccountCardManagerHeaderView()
    private let menuCollectionView = AccountCardManagerCategoryView()
    
    private lazy var roundBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = ConstantsColor.white900
        return view
    }()
    
    private let listActivityView = AccountCardDetailManagerActivityView()
    
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
        roundBackgroundView.roundCorners(corners: [.topLeft, .topRight], radius: 24)
    }
    
    private func setupView(){
        view.backgroundColor = ConstantsColor.white900
        view.addSubviews(backgroundContainerView, headerView, menuCollectionView, roundBackgroundView)
        roundBackgroundView.addSubview(listActivityView)
        
        let menuItems: [CardMenuItem] = [
            CardMenuItem(title: "Informasi Rekening", image: "category_image", action: showDetailInformation),
            CardMenuItem(title: "Detail Kartu", image: "category_image", action: showDetailCard),
            CardMenuItem(title: "E-Statement", image: "category_image")
        ]

        menuCollectionView.configure(items: menuItems)
    }
    
    private func showDetailInformation() {
        let vc = CardDetailInformationVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showDetailCard() {
        let vc = CardManagementVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupConstraint(){
        backgroundContainerView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }

        headerView.snp.remakeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.leading.trailing.equalToSuperview()
        }
        
        menuCollectionView.snp.remakeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        roundBackgroundView.snp.remakeConstraints {
            $0.top.equalTo(menuCollectionView.snp.bottom).offset(24)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        listActivityView.snp.remakeConstraints {
            $0.top.equalTo(roundBackgroundView.snp.top).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
    }

}
