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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        roundBackgroundView.roundCorners(corners: [.topLeft, .topRight], radius: 24)
    }

    
    private func setupView(){
        view.backgroundColor = ConstantsColor.white900
        view.addSubviews(backgroundContainerView, headerView, menuCollectionView, roundBackgroundView)
        roundBackgroundView.addSubview(listActivityView)
        
        let menuItems: [CardMenuItem] = [
            CardMenuItem(title: "Informasi Rekeningss", image: "category_image"),
            CardMenuItem(title: "Detail Kartu", image: "category_image"),
            CardMenuItem(title: "E-Statement", image: "category_image")
        ]

        let menu = menuItems.map { (title: $0.title, image: $0.image) }
        menuCollectionView.configure(items: menu)
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
