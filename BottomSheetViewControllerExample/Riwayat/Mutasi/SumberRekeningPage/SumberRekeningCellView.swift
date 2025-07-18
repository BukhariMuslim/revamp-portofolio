//
//  SumberRekeningCellView.swift
//  BottomSheetViewControllerExample
//
//  Created by sia santos on 18/07/25.
//

import UIKit
import SnapKit

final class SumberRekeningCellView: UICollectionViewCell {
    static let reuseIdentifier = "SumberRekeningCellView"
    
    private let backgroundContainer: UIView = {
        let view = UIView()
        view.backgroundColor = ConstantsColor.black100
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Brimo.Body.largeSemiBold
        label.textColor = UIColor.Brimo.Black.main
        label.numberOfLines = 1
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Brimo.Body.mediumRegular
        label.textColor = UIColor.Brimo.Black.x600
        label.numberOfLines = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        titleLabel.text = nil
        subtitleLabel.text = nil
    }
    
    private func setupViews() {
        contentView.addSubview(backgroundContainer)
        backgroundContainer.addSubviews(iconImageView, titleLabel, subtitleLabel)
    }
    
    private func setupConstraints() {
        backgroundContainer.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(58)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView).offset(2)
            make.leading.equalTo(iconImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(16)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalTo(titleLabel)
            make.trailing.equalTo(titleLabel)
            make.bottom.lessThanOrEqualTo(iconImageView.snp.bottom).offset(-2)
        }
    }
    
    func configure(with model: RiwayatMutasiCardDetailModel) {
        if let image = UIImage(named: model.cardImage) {
            iconImageView.image = image
        } else {
            iconImageView.backgroundColor = UIColor.Brimo.Primary.main
        }
        
        titleLabel.text = model.name
        subtitleLabel.text = model.cardId
    }
}
