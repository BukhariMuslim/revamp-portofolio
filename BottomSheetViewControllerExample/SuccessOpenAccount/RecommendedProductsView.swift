//
//  RecommendedProductsView.swift
//  BottomSheetViewControllerExample
//
//  Created by PT Diksha Teknologi Indonesia on 29/06/25.
//

import UIKit
import Foundation
import SnapKit

final class RecommendedProductsView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = ConstantsColor.black900
        label.font = UIFont.Brimo.Title.smallSemiBold
        label.numberOfLines = 0
        label.text = "Product Pilihan Untukmu"
        return label
    }()

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        return cv
    }()

    private let items = Array(1...10) // Dummy data

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupContraint()
        configureCollectionView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupContraint()
        configureCollectionView()
    }

    private func setupViews() {
        addSubview(titleLabel)
        addSubview(collectionView)
    }

    private func setupContraint() {
        
        titleLabel.snp.remakeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
            
        }
        
        collectionView.snp.remakeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(RecommendedProductCell.self, forCellWithReuseIdentifier: "RecommendedProductCell")
    }
}

extension RecommendedProductsView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendedProductCell", for: indexPath) as? RecommendedProductCell else { return UICollectionViewCell() }
        cell.configure(title: "Token Listrik", subtitle: "Beli Token listrik di BRImo, langsung dapat Cashback s.d 100rb!", badge: "Cashback 100rb", image: "illustrations/token_listrik")
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 100
        let height = collectionView.bounds.height
        return CGSize(width: width, height: height)
    }
}
