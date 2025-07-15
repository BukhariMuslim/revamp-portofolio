//
//  NotifyTransactionManagerVC.swift
//  BottomSheetViewControllerExample
//
//  Created by Phincon on 10/07/25.
//

import UIKit
import SnapKit

class NotifyTransactionManagerVC: UIViewController {
    
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
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Cara ternyamanuntuk menerima pesan notifikasi dari semua aktivitas transaksimu"
        label.font = .Brimo.Body.largeRegular
        label.textColor = UIColor(hex: "#7B90A6")
        label.numberOfLines = 0
        return label
    }()
    
    private let phoneNumberInfoView: PhoneNumberInfoView = {
        let view = PhoneNumberInfoView()
        return view
    }()
    
    private let notifyWhatsAppView: NotifyTransactionView = {
        let view = NotifyTransactionView()
        return view
    }()
    
    private let notifyWhatsAppTextView: NotifyTransactionView = {
        let view = NotifyTransactionView()
        view.setupContent(item: NotifyTransactionContent(image: "sms_orange_ic", title: "SMS"))
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraint()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Notifikasi Transaksi"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        roundBackgroundView.roundCorners(corners: [.topLeft, .topRight], radius: 24)
    }
    
    private func setupView(){
        view.backgroundColor = ConstantsColor.white900
        view.addSubviews(backgroundContainerView, roundBackgroundView)
        roundBackgroundView.addSubviews(titleLabel, phoneNumberInfoView, notifyWhatsAppView, notifyWhatsAppTextView)
        
        notifyWhatsAppView.toggleSwitch.addTarget(self, action: #selector(notifyWhatsAppViewAction), for: .touchUpInside)
    }
    
    @objc private func notifyWhatsAppViewAction(){
        let vc = WhatsAppNotificationConfigVC()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupConstraint(){
        backgroundContainerView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
        
        roundBackgroundView.snp.remakeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.leading.bottom.trailing.equalToSuperview()
        }
        
        titleLabel.snp.remakeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(roundBackgroundView.snp.top).offset(24)
        }
        
        phoneNumberInfoView.snp.remakeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(titleLabel.snp.bottom).offset(24)
        }
        
        notifyWhatsAppView.snp.remakeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(phoneNumberInfoView.snp.bottom).offset(24)
        }
        
        notifyWhatsAppTextView.snp.remakeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(notifyWhatsAppView.snp.bottom).offset(24)
        }
    }
}


extension NotifyTransactionManagerVC: WhatsAppNotificationProtocol {
    func successAddNotification() {
        notifyWhatsAppView.isDetailVisible = true
    }
}
