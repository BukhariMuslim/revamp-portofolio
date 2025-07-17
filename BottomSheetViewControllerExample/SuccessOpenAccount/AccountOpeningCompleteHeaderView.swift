//
//  AccountOpeningCompleteHeaderView.swift
//  BottomSheetViewControllerExample
//
//  Created by PT Diksha Teknologi Indonesia on 29/06/25.
//


import UIKit
import SnapKit

final class AccountOpeningCompleteHeaderView: UIView {

    // MARK: - UI Components

    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = UIImage(named: "illustrations/check")
        iv.layer.cornerRadius = 60
        return iv
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Transaksi Berhasil"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .Brimo.White.main
        label.font = UIFont.Brimo.Title.mediumRegular
        return label
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.text = "Rp 101.000"
        label.textAlignment = .center
        label.textColor = .Brimo.White.main
        label.font = UIFont.Brimo.Headline.smallSemiBold
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "6 Juni 2025, 12:20:33 WIB"
        label.textAlignment = .center
        label.textColor = ConstantsColor.white900
        label.font = UIFont.Brimo.Body.largeRegular
        return label
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Setup
    private func setupViews() {
        addSubviews(imageView, titleLabel, amountLabel, dateLabel)
    }

    private func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(40)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(CGSize(width: 120, height: 120))
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        amountLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        dateLabel.snp.makeConstraints {
            $0.top.equalTo(amountLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
    }

    // MARK: - Public Configuration
    func configure(title: String, date: String, image: UIImage?, amount: String) {
        titleLabel.text = title
        dateLabel.text = date
        imageView.image = image
        amountLabel.text = amount
    }
}
