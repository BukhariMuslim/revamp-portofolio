//
//  BlockedCardManagementVC.swift
//  BottomSheetViewControllerExample
//
//  Created by Bukhari Muslim on 15/07/25.
//

import UIKit
import SnapKit

class BlockedCardManagementVC: UIViewController {
    private lazy var backgroundContainerView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "background_blue_secondary")
        return img
    }()
    
    private lazy var mainImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "illustrations/empty")
        img.contentMode = .scaleAspectFit
        img.snp.makeConstraints { make in
            make.width.height.equalTo(96)
        }
        return img
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Kamu tidak memiliki kartu aktif"
        label.font = .Brimo.Body.largeSemiBold
        label.textColor = .Brimo.Black.main
        label.textAlignment = .center
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Kamu dapat datang ke kantor cabang terdekat untuk membuat Kartu Debit, atau buat Kartu Debit Virtual sekarang"
        label.numberOfLines = 0
        label.font = .Brimo.Body.mediumRegular
        label.textColor = .Brimo.Black.x700
        label.textAlignment = .center
        return label
    }()
    
    private let headerView: UIView = UIView()
    private let contentView: UIView = UIView()
    private let centerContainerView: UIView = UIView()
    private let textContainerView: UIView = UIView()
    private var scrollContainerView: StickyRoundedContainerView!
    
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
        centerContainerView.addSubviews(mainImage, titleLabel, subTitleLabel)
        contentView.addSubviews(centerContainerView)
        
        scrollContainerView = StickyRoundedContainerView(
            headerView: headerView,
            contentView: contentView,
            isStickyEnabled: false
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
        
        centerContainerView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.top.bottom.trailing.leading
                .greaterThanOrEqualToSuperview()
                .offset(16)
        }
        
        mainImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.greaterThanOrEqualToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(mainImage.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().offset(16)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().inset(24)
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
