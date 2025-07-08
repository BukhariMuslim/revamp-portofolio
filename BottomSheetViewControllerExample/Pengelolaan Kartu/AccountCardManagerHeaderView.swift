//
//  AccountCardManagerHeaderView.swift
//  BottomSheetViewControllerExample
//
//  Created by Phincon on 07/07/25.
//

import Foundation
import UIKit
import SnapKit

class AccountCardManagerHeaderView: UIView {

    // MARK: - UI Elements

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "6013 01 3455 504"
        label.font = .Brimo.Body.largeRegular
        label.textColor = ConstantsColor.white900
        label.numberOfLines = 1
        return label
    }()

    private let copyBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "ic_copy"), for: .normal)
        return btn
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Rp10.000.000"
        label.font = .Brimo.Headline.smallSemiBold
        label.textColor = ConstantsColor.white900
        label.numberOfLines = 1
        return label
    }()

    private let eyeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "ic_copy"), for: .normal)
        return btn
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    // MARK: - Setup

    private func setupView() {
        addSubview(titleLabel)
        addSubview(copyBtn)
        addSubview(subtitleLabel)
        addSubview(eyeBtn)

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview().offset(-20)
        }

        copyBtn.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.leading.equalTo(titleLabel.snp.trailing).offset(8)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.centerX.equalToSuperview().offset(-20)
        }

        eyeBtn.snp.makeConstraints { make in
            make.centerY.equalTo(subtitleLabel)
            make.leading.equalTo(subtitleLabel.snp.trailing).offset(8)
            make.bottom.equalToSuperview()
        }
    }
}
