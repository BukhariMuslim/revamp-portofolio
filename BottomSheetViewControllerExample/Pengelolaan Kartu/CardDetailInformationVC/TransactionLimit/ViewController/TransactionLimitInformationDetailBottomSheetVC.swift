//
//  TransactionLimitInformationDetailBottomSheetVC.swift
//  BottomSheetViewControllerExample
//
//  Created by sia santos on 16/07/25.
//

import UIKit
import SnapKit

class TransactionLimitInformationDetailBottomSheetVC: BrimonsBottomSheetVC {
    
    var didTapAgreeButton: (() -> Void)?
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Informasi Tentang Limit"
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
        btn.setTitle("Mengerti", for: .normal)
        btn.titleLabel?.font = UIFont.Brimo.Title.smallSemiBold
        btn.setTitleColor(ConstantsColor.white900, for: .normal)
        btn.backgroundColor = .Brimo.Primary.main
        btn.layer.cornerRadius = 28
        btn.titleLabel?.textAlignment = .center
        return btn
    }()
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isSelectable = true
        textView.isScrollEnabled = true
        textView.backgroundColor = .white
        textView.textColor = ConstantsColor.black500
        textView.font = UIFont.Brimo.Body.largeRegular
        return textView
    }()
    
    private let scrollView = UIScrollView()
    private let contentStack = UIStackView()
        
    var textInput: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
    }
    
    private func setupView(){
        view.addSubview(containerView)
        containerView.addSubviews(titleLabel, closeImgView, textView, agreeBtn)
        setContent(content: containerView)
        
        closeImgView.addTapGesture(target: self, action: #selector(closeBtnAction))
        agreeBtn.addTapGesture(target: self, action: #selector(agreeBtnAction))
        textView.snp.makeConstraints { $0.height.greaterThanOrEqualTo(340) }
    }
    
    private func setupLayout() {
        containerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }

        closeImgView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview().inset(16)
            $0.size.equalTo(32)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        agreeBtn.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().offset(-(getTopSafeAreaHeight() + 24))
            $0.height.equalTo(56)
        }

        textView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(36)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(agreeBtn.snp.top).offset(-16)
        }
    }
    
    @objc private func closeBtnAction(){
        dismissBottomSheet()
    }
    
    @objc private func agreeBtnAction(){
        dismissBottomSheet()
    }
    
    @objc private func cancelBtnAction(){
        dismissBottomSheet()
    }
    
    func setupTextView(input: String) {
        textView.text = input
    }
}
