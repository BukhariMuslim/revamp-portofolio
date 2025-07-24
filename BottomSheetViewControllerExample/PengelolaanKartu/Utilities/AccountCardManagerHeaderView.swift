//
//  AccountCardManagerHeaderView.swift
//  BottomSheetViewControllerExample
//
//  Created by Phincon on 07/07/25.
//

import Foundation
import UIKit
import SnapKit
import SkeletonView

class AccountCardManagerHeaderView: UIView {

    // MARK: - UI Elements
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "6013 01 3455 504\nksajdks"
        label.font = .Brimo.Body.largeRegular
        label.textColor = ConstantsColor.white900
        label.numberOfLines = 1
        label.configureSkeleton(cornerRadius: 7)
        return label
    }()

    private let copyBtn: UIButton = {
        let btn = UIButton()
        btn
            .setImage(
                UIImage(named: "utilities/copy_outline")?
                    .withRenderingMode(.alwaysTemplate),
                for: .normal
            )
        btn.tintColor = ConstantsColor.white900
        btn.configureSkeleton(cornerRadius: 7)
        return btn
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .Brimo.Headline.smallSemiBold
        label.textColor = ConstantsColor.white900
        label.numberOfLines = 1
        label.configureSkeleton(cornerRadius: 16)
        return label
    }()

    private let eyeBtn: UIButton = {
        let btn = UIButton()
        btn
            .setImage(
                UIImage(named: "utilities/hide_eye")?
                    .withRenderingMode(.alwaysTemplate),
                for: .normal
            )
        btn.configureSkeleton(cornerRadius: 10)
        return btn
    }()
    
    private let maskedText: String = "Rp\u{2022}\u{2022}\u{2022}\u{2022}\u{2022}\u{2022}\u{2022}\u{2022}"
    private let DEFAULT_TEXT: String = "Rp10.000.000"
    
    public var isMasked: Bool = false
    
    public var subtitle: String? {
        didSet {
            updateMaskedText()
        }
    }
    
    public var isLoading: Bool = false {
        didSet {
            setSkeleton()
        }
    }

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
        configureSkeleton()
        addSubview(titleLabel)
        addSubview(copyBtn)
        addSubview(subtitleLabel)
        addSubview(eyeBtn)
        subtitle = DEFAULT_TEXT
        eyeBtn
            .addTarget(self, action: #selector(toggleEye), for: .touchUpInside)
        
        updateMaskedText()

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview().offset(-20)
        }

        copyBtn.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.leading.equalTo(titleLabel.snp.trailing).offset(8)
            make.height.width.equalTo(16)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.centerX.equalToSuperview().offset(-20)
        }

        eyeBtn.snp.makeConstraints { make in
            make.centerY.equalTo(subtitleLabel)
            make.leading.equalTo(subtitleLabel.snp.trailing).offset(8)
            make.bottom.equalToSuperview()
            make.height.width.equalTo(24)
        }
    }
    
    private func updateMaskedText() {
        subtitleLabel.text = isMasked ? maskedText : (subtitle ?? DEFAULT_TEXT)
        let imageName = isMasked ? "utilities/hide_eye" : "utilities/unhide_eye"
        
        let image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        eyeBtn.setImage(image, for: .normal)
        eyeBtn.tintColor = ConstantsColor.white900
    }
    
    @objc private func toggleEye() {
        isMasked.toggle()
        updateMaskedText()
    }
    
    private func setSkeleton() {
        if isLoading {
            showAnimatedSkeleton(usingColor: .Brimo.Primary.main)
        } else {
            stopSkeletonAnimation()
        }
    }
}


extension UIView {
    func configureSkeleton(cornerRadius: CGFloat = 0.0) {
        self.isSkeletonable = true
        
        if let label = self as? UILabel {
            label.linesCornerRadius = Int(cornerRadius)
            label.skeletonCornerRadius = Float(cornerRadius)
            if label.numberOfLines == 1 {
                label.layer.cornerRadius = cornerRadius
                label.layer.masksToBounds = true
                label.lastLineFillPercent = 100
            }
        } else {
            skeletonCornerRadius = Float(cornerRadius)
        }
    }
    
    func showAnimatedSkeletonRecursively(usingColor color: UIColor = .Brimo.Black.x200) {
        self.isSkeletonable = true
        
        if self.subviews.isEmpty {
            self.showAnimatedSkeleton(usingColor: color)
        } else {
            for subview in subviews {
                subview.showAnimatedSkeletonRecursively(usingColor: color)
            }
        }
    }
    
    func stopSkeletonRecursively() {
        if self.subviews.isEmpty {
            self.hideSkeleton(reloadDataAfter: true, transition: .none)
        } else {
            for subview in subviews {
                subview.stopSkeletonRecursively()
            }
        }
    }
}
