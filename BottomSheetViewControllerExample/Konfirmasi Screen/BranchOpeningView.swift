//
//  BranchOpeningView.swift
//  BottomSheetViewControllerExample
//
//  Created by PT Diksha Teknologi Indonesia on 28/06/25.
//


import UIKit
import SnapKit

class BranchOpeningView: UIView {

    private let titleSectionLabel: UILabel = {
        let label = UILabel()
        label.text = "Kantor Cabang Pembuka"
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

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.numberOfLines = 0
        label.text = "Branch Name"
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.text = "Opening soon in your city"
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    private func setupViews() {
        addSubview(titleSectionLabel)
        addSubview(backgroundContainerView)
        backgroundContainerView.addSubview(titleLabel)
        backgroundContainerView.addSubview(subtitleLabel)

        titleSectionLabel.snp.remakeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        backgroundContainerView.snp.remakeConstraints {
            $0.top.equalTo(titleSectionLabel.snp.bottom).offset(16)
            $0.leading.bottom.trailing.equalToSuperview()
        }
        
        titleLabel.snp.remakeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        subtitleLabel.snp.remakeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(12)
        }
    }

    func configure(title: String, subtitle: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
}
