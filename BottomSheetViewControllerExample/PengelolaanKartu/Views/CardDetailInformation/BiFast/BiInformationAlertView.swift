//
//  InformationAlertView.swift
//  BottomSheetViewControllerExample
//
//  Created by Phincon on 08/07/25.
//


import UIKit
import SnapKit

final class BiInformationAlertView: UIView {

    // MARK: - UI Components

    private let infoIcon: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "utilities/big/info_circle")
        iv.tintColor = UIColor.systemBlue
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Informasi"
        label.textColor = ConstantsColor.black900
        label.font = .Brimo.Body.mediumSemiBold
        label.numberOfLines = 0
        return label
    }()

    private let bulletLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = ConstantsColor.black900
        label.font = .Brimo.Body.mediumRegular
        label.text = """
        1. Proxy yang dinonaktifkan/hapus tidak bisa digunakan untuk transfer.
        2. Proxy yang dinonaktifkan tidak dapat digunakan pada rekening lain.
        3. Proxy yang telah dihapus dapat digunakan kembali pada rekening yang sama maupun lainnya.
        """
        return label
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
        backgroundColor = ConstantsColor.primary100
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = UIColor.Brimo.Primary.main.cgColor

        addSubviews(infoIcon, infoLabel, bulletLabel)
    }

    private func setupConstraints() {

        infoIcon.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.leading.equalToSuperview().offset(12)
            $0.size.equalTo(24)
        }

        infoLabel.snp.makeConstraints {
            $0.leading.equalTo(infoIcon.snp.trailing).offset(12)
            $0.centerY.equalTo(infoIcon)
            $0.trailing.equalToSuperview().inset(12)
        }

        bulletLabel.snp.makeConstraints {
            $0.top.equalTo(infoIcon.snp.bottom).offset(5)
            $0.trailing.equalToSuperview().inset(12)
            $0.leading.equalTo(infoLabel)
            $0.bottom.equalToSuperview().inset(12)
        }
    }
    
    func configure(
        icon: String? = nil,
        iconTintColor: UIColor? = nil,
        titleText: String? = nil,
        titleTextColor: UIColor? = nil,
        titleFont: UIFont? = nil,
        messageText: String? = nil,
        messageTextColor: UIColor? = nil,
        messageFont: UIFont? = nil,
        backgroundColor: UIColor? = nil,
        borderColor: UIColor? = nil
    ) {
        // Icon image
        let imageName = (icon?.isEmpty == false ? icon : nil) ?? "info_ic"

        // Title
        infoLabel.text = titleText?.isEmpty == false ? titleText : ""
        infoLabel.textColor = titleTextColor ?? ConstantsColor.black900
        infoLabel.font = titleFont ?? .Brimo.Body.mediumSemiBold

        // Message
        bulletLabel.text = messageText?.isEmpty == false ? messageText : ""
        bulletLabel.textColor = messageTextColor ?? ConstantsColor.black900
        bulletLabel.font = messageFont ?? .Brimo.Body.mediumRegular

        // Background & Border
        self.backgroundColor = backgroundColor ?? ConstantsColor.primary100
        self.layer.borderColor = (borderColor ?? UIColor.Brimo.Primary.main).cgColor
    }

}
