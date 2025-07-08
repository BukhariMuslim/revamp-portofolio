//
//  BrimoNsReachMaxAttemptPinVC.swift
//  BottomSheetViewControllerExample
//
//  Created by PT Diksha Teknologi Indonesia on 29/06/25.
//

import UIKit

class BrimoNsReachMaxAttemptPinVC: BrimonsBottomSheetVC {

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let errorImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "sampleImage"))
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Kamu Telah Mencapai Batas Maksimum Percobaan Verifikasi PIN"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Akun diblokir sementara. Untuk kemananan, silakan atur ulang PIN mu terlebih dahulu."
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let resetBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Atur Ulang Pin", for: .normal)
        btn.backgroundColor = UIColor.blue
        btn.layer.cornerRadius = 28
        return btn
    }()
    
    private let backToLogin: UIButton = {
        let btn = UIButton()
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.blue.cgColor
        btn.setTitle("Kembali Ke Login", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.layer.cornerRadius = 28
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerView.addSubview(errorImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(subTitleLabel)
        containerView.addSubview(resetBtn)
        containerView.addSubview(backToLogin)
        
        self.setContent(content: containerView)
        
        setupLayout()
        
        backToLogin.addTarget(self, action: #selector(handleTapDimmedView), for: .touchUpInside)
        resetBtn.addTarget(self, action: #selector(handleTapDimmedView), for: .touchUpInside)
    }
    
    private func setupLayout() {
        
        errorImageView.snp.remakeConstraints {
            $0.top.equalTo(containerView.snp.top).offset(24)
            $0.size.equalTo(200)
            $0.centerX.equalTo(containerView.snp.centerX)
        }
        
        titleLabel.snp.remakeConstraints {
            $0.top.equalTo(errorImageView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        subTitleLabel.snp.remakeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        resetBtn.snp.remakeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(56)
        }
        
        backToLogin.snp.remakeConstraints {
            $0.top.equalTo(resetBtn.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalTo(containerView.safeAreaLayoutGuide.snp.bottom).inset(24)
            $0.height.equalTo(56)
        }
        
    }

}
