//
//  RecommendedProductCell.swift
//  BottomSheetViewControllerExample
//
//  Created by PT Diksha Teknologi Indonesia on 29/06/25.
//
import UIKit
import Foundation
import SnapKit

final class RecommendedProductCell: UICollectionViewCell {
    // MARK: - UI Components
    private let topImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "illustrations/token_listrik")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Token Listrik"
        label.textColor = ConstantsColor.black900
        label.font = UIFont.Brimo.Body.largeSemiBold
        return label
    }()
    
    private let badgeContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.2)
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    private let badgeLabel: UILabel = {
        let label = UILabel()
        label.text = "Cashback 100rb"
        label.textColor = UIColor(hex: "#E84040")
        label.font = UIFont.Brimo.Body.smallSemiBold
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Beli token listrik di Qitta, langsung dapet Cashback s.d. 100rb!"
        label.textColor = ConstantsColor.black900
        label.font = UIFont.Brimo.Body.mediumRegular
        label.numberOfLines = 2
        label.textAlignment = .left
        return label
    }()
    
    private let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Pilih Produk", for: .normal)
        button.setTitleColor(UIColor(hex: "#0054F3"), for: .normal)
        button.titleLabel?.font = UIFont.Brimo.Body.mediumSemiBold
        return button
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        contentView.addSubview(topImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(badgeContainerView)
        badgeContainerView.addSubview(badgeLabel)
        
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(actionButton)
        
        contentView.backgroundColor = .white
    }
    
    // MARK: - Constraints
    private func setupConstraints() {
        topImageView.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(16)
            $0.size.equalTo(32)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(topImageView.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.lessThanOrEqualTo(badgeContainerView.snp.leading).offset(-8)
        }

        badgeContainerView.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.trailing.equalToSuperview().inset(16)
        }

        badgeLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 2, left: 8, bottom: 2, right: 8))
        }

        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(12)
            $0.bottom.greaterThanOrEqualTo(actionButton.snp.top).offset(-12)
        }

        actionButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(12)
            $0.bottom.equalToSuperview().inset(12)
            $0.height.equalTo(40)
        }
    }
    
    // MARK: - Configure
    func configure(title: String, subtitle: String, badge: String, image: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        badgeLabel.text = badge
        topImageView.image = UIImage(named: image)
    }
}
