//
//  FundingSourceSectionView.swift
//  BottomSheetViewControllerExample
//
//  Created by PT Diksha Teknologi Indonesia on 28/06/25.
//
import UIKit
import SnapKit

class FundingSourceSectionView: UIView {

    // MARK: - UI Components

    private let titleSectionLabel: UILabel = {
        let label = UILabel()
        label.text = "Sumber Dana"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    
    
    private let backgroundContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()

    private let cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 4
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        return label
    }()

    private lazy var textStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.axis = .vertical
        stackView.spacing = 2
        return stackView
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupLayout()
    }

    // MARK: - Setup View

    private func setupView() {
        addSubview(titleSectionLabel)
        addSubview(backgroundContainerView)
        backgroundContainerView.addSubview(cardImageView)
        backgroundContainerView.addSubview(textStackView)
    }

    private func setupLayout() {
        titleSectionLabel.snp.remakeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        backgroundContainerView.snp.makeConstraints {
            $0.top.equalTo(titleSectionLabel.snp.bottom).offset(16)
            $0.leading.bottom.trailing.equalToSuperview()
        }

        cardImageView.snp.makeConstraints {
            $0.width.equalTo(57)
            $0.height.equalTo(36)
            $0.leading.top.bottom.equalTo(backgroundContainerView).inset(16)
        }

        textStackView.snp.makeConstraints {
            $0.leading.equalTo(cardImageView.snp.trailing).offset(16)
            $0.centerY.equalTo(cardImageView.snp.centerY)
            $0.trailing.lessThanOrEqualToSuperview().inset(16)
        }
    }

    // MARK: - Configure Method

    func configure(image: UIImage?, title: String, subtitle: String) {
        cardImageView.image = image
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
}
