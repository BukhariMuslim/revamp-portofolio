//
//  WhatsAppNotificationConfigVC.swift
//  BottomSheetViewControllerExample
//
//  Created by Phincon on 10/07/25.
//

import UIKit
import SnapKit

protocol WhatsAppNotificationProtocol: AnyObject {
    func successAddNotification()
}

class WhatsAppNotificationConfigVC: UIViewController {
    
    private let backgroundContainerView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "background_blue_secondary")
        return img
    }()
    
    private lazy var roundBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = ConstantsColor.white900
        return view
    }()
    
    private lazy var alertView: BiInformationAlertView = {
        let view = BiInformationAlertView()
        view.configure(titleText: "Notifikasi Transaksi akan dikenakan biaya sebesar Rp750/transaksi", titleFont: .Brimo.Body.mediumSemiBold)
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Nominal Minimum"
        label.font = .Brimo.Body.largeSemiBold
        label.textColor = ConstantsColor.black900
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Minimum Transaksi uang masuk dan keluar yang ingin dipantau"
        label.font = .Brimo.Body.largeRegular
        label.textColor = ConstantsColor.black500
        label.numberOfLines = 0
        return label
    }()
    
    private let inputField: InputField = {
        let field = InputField(type: .prefix("Rp"))
        field.placeholder = "Nominal Minimum"
        field.hintText = "Minimal Rp 1"
        return field
    }()
    
    private let fundingSourceSectionView = FundingSourceSectionView()
    
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
        btn.setTitle("Aktifkan", for: .normal)
        btn.layer.cornerRadius = 28
        return btn
    }()
    
    weak var delegate: WhatsAppNotificationProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraint()
        fundingSourceSectionView.configure(image: UIImage(named: "debit"), title: "@marselasatya", subtitle: "0290 3445 9681 112")
        saveBtn.addTarget(self, action: #selector(saveBtnAction), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        roundBackgroundView.roundCorners(corners: [.topLeft, .topRight], radius: 24)
    }
    
    @objc private func saveBtnAction(){
        navigationController?.popViewController(animated: true)
        delegate?.successAddNotification()
    }
    
    private func setupView(){
        view.addSubviews(backgroundContainerView, roundBackgroundView)
        roundBackgroundView.addSubviews(alertView, titleLabel, subTitleLabel, inputField, fundingSourceSectionView, separatorBtnView, backgroundBtnView)
        backgroundBtnView.addSubview(saveBtn)
    }
    
    private func setupConstraint(){
        backgroundContainerView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
        
        roundBackgroundView.snp.remakeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.leading.bottom.trailing.equalToSuperview()
        }
        
        alertView.snp.remakeConstraints {
            $0.top.equalTo(roundBackgroundView.snp.top).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        titleLabel.snp.remakeConstraints {
            $0.top.equalTo(alertView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        subTitleLabel.snp.remakeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        inputField.snp.remakeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        fundingSourceSectionView.snp.remakeConstraints {
            $0.top.equalTo(inputField.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        backgroundBtnView.snp.remakeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
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
}
