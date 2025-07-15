//
//  BiFastActivatedEmaillVC.swift
//  BottomSheetViewControllerExample
//
//  Created by Phincon on 09/07/25.
//

import UIKit
import SnapKit

class BiFastActivatedEmaillVC: UIViewController {

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
    
    private lazy var phoneNumberBiFastCardView: BIFastCardActiveView = {
        let view = BIFastCardActiveView()
        view.biFastStatus(status: .success)
        return view
    }()
    
    private lazy var emailBiFastCardView: BIFastCardActiveView = {
        let view = BIFastCardActiveView()
        view.biFastStatus(status: .success)
        view.setContent(item: BIFastCardActiveItem(image: "bi_fast_email_ic", title: "marsela@gmail.com", badge: "Aktif", name: "Marsela Nababan", cardNumber: "BRI - 05994 0101 5080 007 "))
        return view
    }()
    
    private lazy var biFastAlertView: BiInformationAlertView = {
        let view = BiInformationAlertView()
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupView()
        setupLayout()
        
        phoneNumberBiFastCardView.bIFastCardSuccessFooterView.deleteBtnTaped = {
            [weak self] in
            guard let self else { return }
            let vc = BottomSheetWithTwoBtnVC()
            vc.setupContent(item: BottomSheetTwoButtonContent(image: "illustrations/warning", title: "Hapus Proxy BI-Fast?", subtitle: "Alias yang dihapus tidak bisa digunakan untuk transfer, tapi bisa dihubungkan lagi ke rekening yang sama atau lainnya.", agreeBtnTitle: "Ya, Hapus", cancelBtnTitle: "Batalkan"))
            self.presentBrimonsBottomSheet(viewController: vc)
        }
        
        phoneNumberBiFastCardView.bIFastCardSuccessFooterView.blockBtnTaped = {
            [weak self] in
            guard let self else { return }
            let vc = BottomSheetWithTwoBtnVC()
            vc.setupContent(item: BottomSheetTwoButtonContent(image: "illustrations/warning", title: "Buka blokir Proxy BI-Fast?", subtitle: "Proxy BI-Fast akan aktif kembali dan dapat digunakan pada saat transfer.", agreeBtnTitle: "Ya, Aktifkan", cancelBtnTitle: "Batalkan"))
            self.presentBrimonsBottomSheet(viewController: vc)
        }
        
        emailBiFastCardView.bIFastCardSuccessFooterView.deleteBtnTaped = {
            [weak self] in
            guard let self else { return }
            let vc = BottomSheetWithTwoBtnVC()
            vc.setupContent(item: BottomSheetTwoButtonContent(image: "illustrations/warning", title: "Hapus Proxy BI-Fast?", subtitle: "Alias yang dihapus tidak bisa digunakan untuk transfer, tapi bisa dihubungkan lagi ke rekening yang sama atau lainnya.", agreeBtnTitle: "Ya, Hapus", cancelBtnTitle: "Batalkan"))
            self.presentBrimonsBottomSheet(viewController: vc)
        }
        
        emailBiFastCardView.bIFastCardSuccessFooterView.blockBtnTaped = {
            [weak self] in
            guard let self else { return }
            let vc = BottomSheetWithTwoBtnVC()
            vc.setupContent(item: BottomSheetTwoButtonContent(image: "illustrations/warning", title: "Buka blokir Proxy BI-Fast?", subtitle: "Proxy BI-Fast akan aktif kembali dan dapat digunakan pada saat transfer.", agreeBtnTitle: "Ya, Aktifkan", cancelBtnTitle: "Batalkan"))
            self.presentBrimonsBottomSheet(viewController: vc)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Proxy BI-Fast"
    }
    
    private func setupView() {
        view.addSubviews(backgroundContainerView, roundBackgroundView)
        roundBackgroundView.addSubviews(phoneNumberBiFastCardView, emailBiFastCardView, biFastAlertView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        roundBackgroundView.roundCorners(corners: [.topLeft, .topRight], radius: 24)
    }
    
    private func setupLayout() {
        backgroundContainerView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
        
        roundBackgroundView.snp.remakeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        phoneNumberBiFastCardView.snp.remakeConstraints {
            $0.top.equalTo(roundBackgroundView.snp.top).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        emailBiFastCardView.snp.remakeConstraints {
            $0.top.equalTo(phoneNumberBiFastCardView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        biFastAlertView.snp.remakeConstraints {
            $0.top.equalTo(emailBiFastCardView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
}
