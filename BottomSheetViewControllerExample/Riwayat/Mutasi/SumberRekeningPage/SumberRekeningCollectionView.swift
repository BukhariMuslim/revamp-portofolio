//
//  SumberRekeningCollectionView.swift
//  BottomSheetViewControllerExample
//
//  Created by sia santos on 18/07/25.
//

import UIKit
import SnapKit

final class SumberRekeningCollectionView: UIView {
    var onTapCard: ((RiwayatMutasiCardDetailModel) -> Void)?
    var onTapSelectAllCard: (() -> Void)?
        
    private lazy var actionButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Semua Sumber Rekening", for: .normal)
        btn.titleLabel?.font = UIFont.Brimo.Title.mediumSemiBold
        btn.setTitleColor(UIColor.Brimo.Primary.main, for: .normal)
        btn.layer.cornerRadius = 16
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.Brimo.Primary.main.cgColor
        btn.backgroundColor = .clear
        return btn
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 16, left: 20, bottom: 16, right: 20)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        cv.showsVerticalScrollIndicator = false
        cv.alwaysBounceVertical = true
        cv.register(SumberRekeningCellView.self,
                    forCellWithReuseIdentifier: SumberRekeningCellView.reuseIdentifier)
        return cv
    }()
    
    var viewModel: SumberRekeningViewModel
    
    init(viewModel: SumberRekeningViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        backgroundColor = UIColor.Brimo.White.main
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubviews(actionButton, collectionView)
        
        actionButton.addTapGesture(target: self, action: #selector(didTapSelectAllCard))
    }
    
    @objc func didTapSelectAllCard() {
        self.onTapSelectAllCard?()
    }
    
    private func setupConstraints() {
        actionButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(56)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(actionButton.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.greaterThanOrEqualTo(254)
        }
    }
    
    func setData(_ models: [RiwayatMutasiCardDetailModel]) {
        self.viewModel.data = models
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    func refreshData() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

extension SumberRekeningCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = viewModel.data.count
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard indexPath.item < viewModel.data.count else {
            return UICollectionViewCell()
        }

        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SumberRekeningCellView.reuseIdentifier,
            for: indexPath
        ) as? SumberRekeningCellView else {
            return UICollectionViewCell()
        }
        
        let model = viewModel.data[indexPath.item]
        cell.configure(with: model)
        return cell
    }
}

extension SumberRekeningCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.item < viewModel.data.count else { return }
        let model = viewModel.data[indexPath.item]
        onTapCard?(model)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 32
        return CGSize(width: width, height: 68)
    }
}
