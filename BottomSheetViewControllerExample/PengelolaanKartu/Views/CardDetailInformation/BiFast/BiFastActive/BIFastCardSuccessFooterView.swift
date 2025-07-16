//
//  BI.swift
//  BottomSheetViewControllerExample
//
//  Created by Phincon on 09/07/25.
//

import Foundation
import UIKit

enum BIFastStatus {
    case success
    case connectToAnotherBank
    case anotherBankBlock
}

final class BIFastCardSuccessFooterView: UIView {
    
    let blockButton = UIButton(type: .system)
    let deleteButton = UIButton(type: .system)
    
    private let verticalSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .Brimo.Black.x300
        return view
    }()
    
    var deleteBtnTaped: (()->Void)?
    var blockBtnTaped: (()->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView(){
        addSubviews(blockButton, deleteButton, verticalSeparator)
        
        deleteButton.setTitle("Hapus", for: .normal)
        deleteButton.titleLabel?.font = UIFont.Brimo.Body.mediumSemiBold
        deleteButton.setTitleColor(.Brimo.Primary.main, for: .normal)
        deleteButton.titleLabel?.textAlignment = .center
        deleteButton.addTarget(self, action: #selector(deleteBtnAction), for: .touchUpInside)
        blockButton.addTarget(self, action: #selector(blockBtnAction), for: .touchUpInside)
        
        blockButton.setTitle("Blokir", for: .normal)
        blockButton.titleLabel?.font = UIFont.Brimo.Body.mediumSemiBold
        blockButton.setTitleColor(.Brimo.Primary.main, for: .normal)
        blockButton.titleLabel?.textAlignment = .center
    }
    
    private func setupConstraints(){
        blockButton.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(8)
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
        }

        deleteButton.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(8)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        
        verticalSeparator.snp.remakeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(blockButton.snp.height)
            $0.width.equalTo(2)
            $0.bottom.equalToSuperview()
        }
    }
    
    @objc private func deleteBtnAction(){
        deleteBtnTaped?()
    }
    
    @objc private func blockBtnAction(){
        blockBtnTaped?()
    }
}
