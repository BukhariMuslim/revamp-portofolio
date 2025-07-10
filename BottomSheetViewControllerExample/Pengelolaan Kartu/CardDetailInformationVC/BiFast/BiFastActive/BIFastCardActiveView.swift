//
//  ProxyAccountCardView.swift
//  BottomSheetViewControllerExample
//
//  Created by Phincon on 08/07/25.
//


import UIKit
import SnapKit

struct BIFastCardActiveItem {
    var image: String?
    var title: String?
    var badge: String?
    var name: String?
    var cardNumber: String?
}

final class BIFastCardActiveView: UIView {
    // MARK: - Private UI Components
    
    private let topContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .Brimo.Black.x300
        view.clipsToBounds = true
        return view
    }()

    private let phoneIcon: UIImageView = {
        let iv = UIImageView(image: UIImage(systemName: "phone.fill"))
        iv.tintColor = .black
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "0896 6215 1339"
        label.textColor = ConstantsColor.black900
        label.font = .Brimo.Title.smallSemiBold
        return label
    }()

    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Aktif"
        label.textColor = UIColor(hex: "#1E8549")
        label.font = .Brimo.Body.smallSemiBold
        return label
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Marsela Nababan"
        label.textColor = ConstantsColor.black900
        label.font = .Brimo.Body.largeRegular
        return label
    }()

    private let accountLabel: UILabel = {
        let label = UILabel()
        label.text = "BRI - 05994 0101 5080 007"
        label.textColor = ConstantsColor.black900
        label.font = .Brimo.Body.largeRegular
        return label
    }()

    private let horizontalSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .Brimo.Black.x300
        return view
    }()
    
    var bIFastCardSuccessFooterView: BIFastCardSuccessFooterView = {
        let view = BIFastCardSuccessFooterView()
        return view
    }()
    
    private let alertBlockView: BiInformationAlertView = {
       let view = BiInformationAlertView()
        view.configure(icon: "warning_bi_ic", titleText: "Proxy kamu masih terblokir di bank lain. Buka blokirnya dulu, lalu aktifkan di BRI.", backgroundColor: UIColor(hex: "#FFF9EB"), borderColor: UIColor(hex: "#FFBE26"))
        return view
    }()
    
    var connectToAnotherBankBtnTap: (() -> Void)?
    
    private let connectToAnotherBankBtn: UIButton = {
       let btn = UIButton(type: .system)
        btn.setTitle("Ambil Alih", for: .normal)
        btn.titleLabel?.font = UIFont.Brimo.Body.mediumSemiBold
        btn.setTitleColor(.Brimo.Primary.main, for: .normal)
        btn.titleLabel?.textAlignment = .center
        return btn
    }()
    
    private let footerStackView: UIStackView = {
       let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Setup

    private func setupView() {
        backgroundColor = .Brimo.Black.x100
        layer.cornerRadius = 16
        clipsToBounds = true

        addSubviews(topContainerView,
                    nameLabel, accountLabel,
                    horizontalSeparatorView, footerStackView)
        
        topContainerView.addSubviews(phoneIcon, phoneLabel, statusLabel)
        footerStackView.addArrangedSubview(bIFastCardSuccessFooterView)
        footerStackView.addArrangedSubview(alertBlockView)
        footerStackView.addArrangedSubview(connectToAnotherBankBtn)
        
        connectToAnotherBankBtn.addTarget(self, action: #selector(connectToAnotherBankBtnAction), for: .touchUpInside)
    }

    private func setupConstraints() {
        topContainerView.snp.remakeConstraints {
            $0.height.equalTo(48)
            $0.leading.trailing.top.equalToSuperview()
        }
        
        phoneIcon.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(12)
            make.size.equalTo(20)
        }

        phoneLabel.snp.makeConstraints { make in
            make.leading.equalTo(phoneIcon.snp.trailing).offset(8)
            make.centerY.equalTo(phoneIcon)
        }

        statusLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalTo(phoneIcon)
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(topContainerView.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        accountLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        horizontalSeparatorView.snp.makeConstraints { make in
            make.top.equalTo(accountLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(1)
        }
        
        footerStackView.snp.remakeConstraints {
            $0.leading.bottom.trailing.equalToSuperview().inset(12)
            $0.top.equalTo(horizontalSeparatorView.snp.bottom).offset(8)
        }
    }
    
    func biFastStatus(status: BIFastStatus){
        alertBlockView.isHidden = status != .anotherBankBlock
        connectToAnotherBankBtn.isHidden = status != .connectToAnotherBank
        bIFastCardSuccessFooterView.isHidden = status != .success
    }
    
    func setContent(item: BIFastCardActiveItem){
        phoneIcon.image = UIImage(named: item.image ?? "")
        phoneLabel.text = item.title ?? ""
        statusLabel.text = item.badge ?? ""
        nameLabel.text = item.name ?? ""
        accountLabel.text = item.cardNumber ?? ""
    }
    
    @objc private func connectToAnotherBankBtnAction(){
        connectToAnotherBankBtnTap?()
    }
}
