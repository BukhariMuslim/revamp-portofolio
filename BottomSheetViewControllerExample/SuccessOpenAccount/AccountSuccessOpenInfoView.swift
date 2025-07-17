//
//  AccountSuccessOpenInfoView.swift
//  BottomSheetViewControllerExample
//
//  Created by PT Diksha Teknologi Indonesia on 29/06/25.
//

import Foundation
import UIKit
import SnapKit

final class AccountSuccessOpenInfoView: UIView {
    
    private let backgroundContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = ConstantsColor.primary100
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(hex: "#0054F3").cgColor
        view.clipsToBounds = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = ConstantsColor.black900
        label.font = UIFont.Brimo.Body.mediumSemiBold
        label.numberOfLines = 0
        label.text = "Atur dan lihat detail tabungan kamu di halaman Portofolio Saya"
        return label
    }()
    
    private let infoImgView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 4
        imageView.image = UIImage(named: "info_ic")
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupContraint()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupViews(){
        addSubview(backgroundContainerView)
        addSubview(titleLabel)
        addSubview(infoImgView)
    }
    
    private func setupContraint(){
        backgroundContainerView.snp.remakeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview()
        }
        
        infoImgView.snp.remakeConstraints {
            $0.leading.top.equalTo(backgroundContainerView).inset(12)
            $0.size.equalTo(20)
        }
        
        titleLabel.snp.remakeConstraints {
            $0.leading.equalTo(infoImgView.snp.trailing).offset(8)
            $0.top.trailing.bottom.equalTo(backgroundContainerView).inset(12)
        }
    }
    
}
