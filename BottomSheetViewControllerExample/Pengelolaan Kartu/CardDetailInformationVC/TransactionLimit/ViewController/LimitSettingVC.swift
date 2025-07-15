//
//  LimitSettingVC.swift
//  BottomSheetViewControllerExample
//
//  Created by sia santos on 15/07/25.
//

import UIKit
import SnapKit

class LimitSettingVC: UIViewController {
    
    var models: [LimitSettingModel] = []
    var didInformation: (() -> Void)?
    var didTapCard: ((LimitSettingModel) -> Void)?
    
    private let backgroundContainerView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "background_blue_secondary")
        return img
    }()

    private let roundBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = .init(top: 24, left: 16, bottom: 24, right: 16)
        layout.minimumLineSpacing = 0
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.register(LimitSettingCellView.self, forCellWithReuseIdentifier: LimitSettingCellView.reuseIdentifier)
        
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavbarButton()
        setupView()
        setupConstraint()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Atur Limit"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        roundBackgroundView.roundCorners(corners: [.topLeft, .topRight], radius: 24)
    }
    
    private func setupView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        view.backgroundColor = .white
        view.addSubviews(backgroundContainerView, roundBackgroundView)
        roundBackgroundView.addSubview(collectionView)
    }
    
    private func configureNavbarButton() {
        navigationController?.navigationBar.tintColor = .systemBlue

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(didTapInfomationButton)
        )
    }
    
    @objc func didTapInfomationButton() {
        didInformation?()
    }
    
    private func setupConstraint() {

        backgroundContainerView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }

        roundBackgroundView.snp.remakeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        collectionView.snp.makeConstraints {
             $0.edges.equalToSuperview()
         }
    }
}

extension LimitSettingVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ cv: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ cv: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cellItem = cv.dequeueReusableCell(
            withReuseIdentifier: LimitSettingCellView.reuseIdentifier,
            for: indexPath
        ) as? LimitSettingCellView else {
            
            return UICollectionViewCell()
        }
        
        cellItem.configureData(model: models[indexPath.item])
        return cellItem
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = models[indexPath.item]
        didTapCard?(item)
    }
    
}

extension LimitSettingVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ cv: UICollectionView,
                        layout cvLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = cv.bounds.width
        return .init(width: width, height: 180)
    }
}
