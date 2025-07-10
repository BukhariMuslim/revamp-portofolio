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
    
    private let notifyWhatsAppView: NotifyTransactionView = {
        let view = NotifyTransactionView()
        view.isDetailVisible = true
        return view
    }()
    
    private let notifyWhatsAppTextView: NotifyTransactionView = {
        let view = NotifyTransactionView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraint()
    }
    
    private func setupView(){
        view.backgroundColor = ConstantsColor.white900
        view.addSubviews(backgroundContainerView, roundBackgroundView)
        roundBackgroundView.addSubviews(titleLabel, notifyWhatsAppView, notifyWhatsAppTextView)
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
        
        notifyWhatsAppView.snp.remakeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(titleLabel.snp.bottom).offset(24)
        }
        
        notifyWhatsAppTextView.snp.remakeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(notifyWhatsAppView.snp.bottom).offset(24)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        roundBackgroundView.roundCorners(corners: [.topLeft, .topRight], radius: 24)
    }
}
