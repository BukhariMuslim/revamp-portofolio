//
//  TransactionLimitBottomSheetVC.swift
//  BottomSheetViewControllerExample
//
//  Created by sia santos on 16/07/25.
//

import UIKit
import SnapKit

struct CardLimitDataModel {
    var minimumLimit: Double = 0
    var maximumLimit: Double = 15000000
}

class TransactionLimitBottomSheetVC: BrimonsBottomSheetVC {
    
    var didTapAgreeButton: ((Double) -> Void)?
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Limit Kartu Tarik Tunai"
        label.textColor = ConstantsColor.black900
        label.font = .Brimo.Title.smallSemiBold
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private lazy var closeImgView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "close_bottomsheet_img")
        img.isUserInteractionEnabled = true
        return img
    }()
    
    private let agreeBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Simpan", for: .normal)
        btn.titleLabel?.font = UIFont.Brimo.Title.smallSemiBold
        btn.setTitleColor(ConstantsColor.white900, for: .normal)
        btn.backgroundColor = .Brimo.Primary.main
        btn.layer.cornerRadius = 28
        btn.titleLabel?.textAlignment = .center
        return btn
    }()
    
    private let textField = TransactionLimitView()
    private var sliderValue: Double = 0
    private var containerBottomConstraint: Constraint?
    
    var dataModel: CardLimitDataModel = CardLimitDataModel(minimumLimit: 0, maximumLimit: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
        configureClosure()
    }
    
    private func setupView(){
        view.addSubview(containerView)
        containerView.addSubviews(titleLabel, closeImgView, textField, agreeBtn)
        setContent(content: containerView)
        
        closeImgView.addTapGesture(target: self, action: #selector(closeBtnAction))
        agreeBtn.addTapGesture(target: self, action: #selector(agreeBtnAction))
    }
    
    private func configureClosure() {
        textField.onKeyboardHeightChange = {[weak self]  in
            guard let self = self else {
                return
            }
            
            containerBottomConstraint?.update(offset: -300)

            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
        }
        
        textField.onValueChanged = {[weak self] sliderValue in
            guard let self = self else {
                return
            }
            
            self.sliderValue = sliderValue
        }
    }
    
    
    private func setupLayout() {
        containerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            self.containerBottomConstraint = $0.bottom.equalToSuperview().constraint
        }
        
        closeImgView.snp.remakeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview().inset(16)
            $0.size.equalTo(32)
        }
        
        titleLabel.snp.remakeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(36)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        agreeBtn.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().offset(-(getTopSafeAreaHeight() + 24))
        }
        
        agreeBtn.snp.makeConstraints { $0.height.equalTo(56) }
    }
    
    @objc private func closeBtnAction(){
        dismissBottomSheet()
    }
    
    @objc private func agreeBtnAction(){
        didTapAgreeButton?(self.sliderValue)
        dismissBottomSheet()
    }
    
    @objc private func cancelBtnAction(){
        dismissBottomSheet()
    }
    
    @objc private func handleKeyboard(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else {
            return
        }
        
        let keyboardHeight = view.convert(keyboardFrame, from: nil).intersection(view.bounds).height
        let isVisible = keyboardFrame.origin.y < UIScreen.main.bounds.height
        
        containerBottomConstraint?.update(offset: isVisible ? -keyboardHeight : 0)
        
        UIView.animate(withDuration: animationDuration) {
            self.view.layoutIfNeeded()
        }
    }
}
