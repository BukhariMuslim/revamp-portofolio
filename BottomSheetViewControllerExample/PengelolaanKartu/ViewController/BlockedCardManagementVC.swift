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
    
    private lazy var backgroundBtnView: UIView = {
        let view = UIView()
        view.backgroundColor = ConstantsColor.white900
        return view
    }()

    private lazy var separatorBtnView: UIView = {
        let view = UIView()
        view.backgroundColor = .Brimo.Black.x300
        return view
    }()

    private lazy var saveBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .Brimo.Primary.main
        btn.setTitleColor(ConstantsColor.white900, for: .normal)
        btn.titleLabel?.font = .Brimo.Title.smallSemiBold
        btn.setTitle("Buat Kartu Debit Virtual", for: .normal)
        btn.layer.cornerRadius = 28
        return btn
    }()
    
    private let headerView: UIView = UIView()
    private let contentView: UIView = UIView()
    private let centerContainerView: UIView = UIView()
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 0
        return stackView
    }()
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
        contentStackView.addArrangedSubview(mainImage)
        contentStackView.setCustomSpacing(16, after: mainImage)

        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.setCustomSpacing(4, after: titleLabel)

        contentStackView.addArrangedSubview(subTitleLabel)
        
        centerContainerView.addSubviews(contentStackView, backgroundBtnView)
        backgroundBtnView.addSubviews(separatorBtnView, saveBtn)
        contentView.addSubviews(centerContainerView)
        
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
        
        contentView.snp.makeConstraints {
            $0.width.equalTo(scrollContainerView.snp.width)
            $0.height.greaterThanOrEqualTo(scrollContainerView.snp.height)
        }
        
        contentStackView.snp.makeConstraints {
            $0.width.lessThanOrEqualTo(contentView.snp.width)
            $0.edges.equalToSuperview()
        }
        
        centerContainerView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.greaterThanOrEqualToSuperview().offset(16)
            $0.trailing.lessThanOrEqualToSuperview().offset(-16)
            $0.top.greaterThanOrEqualToSuperview().offset(24)
            $0.bottom.lessThanOrEqualToSuperview().offset(-24)
        }
        
        backgroundBtnView.snp.remakeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(96)
        }

        separatorBtnView.snp.remakeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
            $0.bottom.equalTo(backgroundBtnView.snp.top)
        }

        saveBtn.snp.remakeConstraints {
            $0.leading.top.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(56)
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
