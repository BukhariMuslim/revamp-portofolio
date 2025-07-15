//
//  BottomSheetWithTwoBtnVC.swift
//  BottomSheetViewControllerExample
//
//  Created by Phincon on 09/07/25.
//

import UIKit
import SnapKit

struct BottomSheetTwoButtonContent {
    var image: String?
    var title: String?
    var subtitle: String?
    var agreeBtnTitle: String?
    var cancelBtnTitle: String?
    var hideCancelBtn: Bool = false
    var actionButtonTap: EventHandler?
}

class BottomSheetWithTwoBtnVC: BrimonsBottomSheetVC {

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let imgView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "illustrations/warning")
        iv.tintColor = .black
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Blokir Proxy BI-Fast?"
        label.textColor = ConstantsColor.black900
        label.font = .Brimo.Title.smallSemiBold
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private let descLabel: UILabel = {
        let label = UILabel()
        label.text = "Alias tidak bisa dipakai untuk transfer atau dihubungkan ke rekening lain."
        label.textColor = UIColor(hex: "#7B90A6")
        label.font = .Brimo.Body.largeRegular
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let agreeBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Ya, Blokir", for: .normal)
        btn.titleLabel?.font = UIFont.Brimo.Title.smallSemiBold
        btn.setTitleColor(ConstantsColor.white900, for: .normal)
        btn.backgroundColor = .Brimo.Primary.main
        btn.layer.cornerRadius = 28
        btn.titleLabel?.textAlignment = .center
        return btn
    }()
    
    private let cancelBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Batalkan", for: .normal)
        btn.titleLabel?.font = UIFont.Brimo.Title.smallSemiBold
        btn.setTitleColor(.Brimo.Primary.main, for: .normal)
        btn.layer.cornerRadius = 28
        btn.layer.borderWidth = 1.5
        btn.layer.borderColor = UIColor.Brimo.Primary.main.cgColor
        btn.titleLabel?.textAlignment = .center
        return btn
    }()
    
    private lazy var closeImgView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "close_bottomsheet_img")
        img.isUserInteractionEnabled = true
        return img
    }()
    
    private let buttonStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.distribution = .fill
        return stack
    }()
    
    var closeBtnTap: EventHandler?
    var actionButtonTap: EventHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
    }
    
    private func setupView(){
        view.addSubview(containerView)
        containerView.addSubviews(imgView, closeImgView, titleLabel, descLabel, buttonStackView)
        
        // Masukkan tombol ke dalam stackView
        buttonStackView.addArrangedSubview(agreeBtn)
        buttonStackView.addArrangedSubview(cancelBtn)
        
        setContent(content: containerView)
        
        closeImgView.addTapGesture(target: self, action: #selector(closeBtnAction))
        agreeBtn.addTapGesture(target: self, action: #selector(agreeBtnAction))
        cancelBtn.addTapGesture(target: self, action: #selector(cancelBtnAction))
    }
    
    @objc private func closeBtnAction(){
        dismissBottomSheet()
    }
    
    @objc private func agreeBtnAction(){
        actionButtonTap?()
        dismissBottomSheet()
    }
    
    @objc private func cancelBtnAction(){
        dismissBottomSheet()
    }
    
    private func setupLayout(){
        closeImgView.snp.remakeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview().inset(16)
            $0.size.equalTo(32)
        }
        
        imgView.snp.remakeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(200)
        }
        
        titleLabel.snp.remakeConstraints {
            $0.top.equalTo(imgView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        descLabel.snp.remakeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(descLabel.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().offset(-(getTopSafeAreaHeight() + 24))
        }
        
        agreeBtn.snp.makeConstraints { $0.height.equalTo(56) }
        cancelBtn.snp.makeConstraints { $0.height.equalTo(56) }
    }
    
    func setupContent(item: BottomSheetTwoButtonContent){
        imgView.image = UIImage(named: item.image ?? "")
        titleLabel.text = item.title ?? ""
        descLabel.text = item.subtitle ?? ""
        agreeBtn.setTitle(item.agreeBtnTitle, for: .normal)
        cancelBtn.setTitle(item.cancelBtnTitle, for: .normal)
        cancelBtn.isHidden = item.hideCancelBtn
        actionButtonTap = item.actionButtonTap
    }
}
