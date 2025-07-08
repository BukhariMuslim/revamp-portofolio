//
//  AccountOpeningPinVC.swift
//  BottomSheetViewControllerExample
//
//  Created by PT Diksha Teknologi Indonesia on 29/06/25.
//

import UIKit

class AccountOpeningPinViewVC: UIViewController {

    let vm = AccountOpeningPinViewVM()
    var pinView: BrimoNsPinReusableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        pinView = BrimoNsPinReusableView(viewModel: vm)
        
        // Do any additional setup after loading the view.
        pinView.delegate = self
        view.addSubview(pinView)
        pinView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension AccountOpeningPinViewVC: BrimoNsReusablePinViewDelegate {
    func didReachMaxAttempt() {
        let vc = BrimoNsReachMaxAttemptPinVC()
        presentBrimonsBottomSheet(viewController: vc)
    }
    
    func didTapForgotPin() {
        
    }
    
    func didFinishInput(pin: String) {
        
    }
}
