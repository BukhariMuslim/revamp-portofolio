//
//  BiFastSetupVC.swift
//  BottomSheetViewControllerExample
//
//  Created by Phincon on 08/07/25.
//

import UIKit
import SnapKit

class BiFastSetupVC: UIViewController {

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
    
    private lazy var phoneBiFastCardView: BiFastCardView = {
        let view = BiFastCardView()
        return view
    }()
    
    private lazy var emailBiFastCardView: BiFastCardView = {
        let view = BiFastCardView()
        return view
    }()
    
    private lazy var biFastAlertView: BiInformationAlertView = {
        let view = BiInformationAlertView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
        
        // dummy Data
        phoneBiFastCardView.setupContent(item: BiFastCardItem(leftIcon: "bi_fast_phone_number_ic", title: "Nomor Handphone", subTitle: "0896 6215 1339", titleBtn: "Hubungkan"))
        emailBiFastCardView.setupContent(item: BiFastCardItem(leftIcon: "bi_fast_email_ic", title: "Email", subTitle: "marsela@gmail.com", titleBtn: "Hubungkan"))
        
        phoneBiFastCardView.connectBtnAction = {
            [weak self] in
            guard let self else { return }
            let vc = BiFastActiveVC()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        roundBackgroundView.roundCorners(corners: [.topLeft, .topRight], radius: 24)
    }

    private func setupView() {
        view.addSubviews(backgroundContainerView, roundBackgroundView)
        roundBackgroundView.addSubviews(phoneBiFastCardView, emailBiFastCardView, biFastAlertView)
    }
    
    private func setupLayout() {
        backgroundContainerView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
        
        roundBackgroundView.snp.remakeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        phoneBiFastCardView.snp.remakeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(70)
        }
        
        emailBiFastCardView.snp.remakeConstraints {
            $0.top.equalTo(phoneBiFastCardView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(70)
        }
        
        biFastAlertView.snp.remakeConstraints {
            $0.top.equalTo(emailBiFastCardView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
}
