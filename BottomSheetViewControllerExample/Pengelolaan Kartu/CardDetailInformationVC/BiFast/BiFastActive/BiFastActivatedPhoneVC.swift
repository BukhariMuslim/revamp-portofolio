//
//  BiFastActiveVC.swift
//  BottomSheetViewControllerExample
//
//  Created by Phincon on 08/07/25.
//

import UIKit
import SnapKit

class BiFastActivatedPhoneVC: UIViewController {

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
    
    private lazy var biFastCardView: BIFastCardActiveView = {
        let view = BIFastCardActiveView()
        return view
    }()
    
    private lazy var emailSectionView: BiFastCardView = {
      let view = BiFastCardView()
        view.setupContent(item: BiFastCardItem(leftIcon: "bi_fast_email_ic", title: "Email", subTitle: "@marsela@gmail.com", titleBtn: "Hubungkan"))
        return view
    }()
    
    private lazy var alertView: BiInformationAlertView = {
        let view = BiInformationAlertView()
        // please later change the configure with another value
//        view.configure()
        return view
    }()
    
    var biFastStatus: BIFastStatus = .success
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupView()
        setupLayout()
        
        // handling for success, block and connect to anthoer bank
        biFastCardView.biFastStatus(status: biFastStatus)
        biFastCardView.bIFastCardSuccessFooterView.blockBtnTaped = {
            [weak self] in
            guard let self else { return }
            let vc = BottomSheetWithTwoBtnVC()
            vc.setupContent(item: BottomSheetTwoButtonContent(image: "illustrations/warning", title: "Buka blokir Proxy BI-Fast?", subtitle: "Proxy BI-Fast akan aktif kembali dan dapat digunakan pada saat transfer.", agreeBtnTitle: "Ya, Aktifkan", cancelBtnTitle: "Batalkan"))
            self.presentBrimonsBottomSheet(viewController: vc)
        }
        
        biFastCardView.bIFastCardSuccessFooterView.deleteBtnTaped = {
            [weak self] in
            guard let self else { return }
            let vc = BottomSheetWithTwoBtnVC()
            vc.setupContent(item: BottomSheetTwoButtonContent(image: "illustrations/warning", title: "Hapus Proxy BI-Fast?", subtitle: "Alias yang dihapus tidak bisa digunakan untuk transfer, tapi bisa dihubungkan lagi ke rekening yang sama atau lainnya.", agreeBtnTitle: "Ya, Hapus", cancelBtnTitle: "Batalkan"))
            self.presentBrimonsBottomSheet(viewController: vc)
        }
        
        biFastCardView.connectToAnotherBankBtnTap = {
            [weak self] in
            guard let self else { return }
            let vc = BottomSheetWithTwoBtnVC()
            vc.setupContent(item: BottomSheetTwoButtonContent(image: "question_mark_ic", title: "Alihkan Proxy BI-Fast ke BRI", subtitle: "Kamu akan mengambil alih Proxy BI-Fast dari bank asal ke rekening di BRI", agreeBtnTitle: "Alihkan Proxy BI-FAST ", cancelBtnTitle: "Batalkan"))
            self.presentBrimonsBottomSheet(viewController: vc)
        }
        
        emailSectionView.connectBtnAction = {
            [weak self] in
            guard let self else { return }
            let vc = BiFastActivatedEmaillVC()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        roundBackgroundView.roundCorners(corners: [.topLeft, .topRight], radius: 24)
    }
    
    private func setupView() {
        view.addSubviews(backgroundContainerView, roundBackgroundView)
        roundBackgroundView.addSubviews(biFastCardView, emailSectionView,alertView)
    }
    
    private func setupLayout() {
        backgroundContainerView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
        
        roundBackgroundView.snp.remakeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        biFastCardView.snp.remakeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        emailSectionView.snp.remakeConstraints {
            $0.top.equalTo(biFastCardView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        alertView.snp.remakeConstraints {
            $0.top.equalTo(emailSectionView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
}
