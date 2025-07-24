//
//  ActivityFilterHeaderView.swift
//  BottomSheetViewControllerExample
//
//  Created by Bukhari Muslim on 24/07/25.
//

import UIKit
import SnapKit
import SkeletonView

class ActivityFilterHeaderView: UIView {
    private let titleLabel: UILabel = UILabel()
    
    private let monthContainer: UIView = UIView()
    private let monthScrollView: UIScrollView = UIScrollView()
    private let monthStack: UIStackView = UIStackView()
    private let filterImageView: UIImageView = UIImageView()
    
    private var sectionTitle: String = ""
    
    public var isLoading: Bool = false {
        didSet {
            setSkeleton()
        }
    }
    
    init(title: String = "Aktivitas Qitta") {
        super.init(frame: .zero)
        sectionTitle = title
        setupLayout()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        configureSkeleton()
        titleLabel.configureSkeleton()
        titleLabel.text = sectionTitle
        titleLabel.font = .Brimo.Title.smallSemiBold
        titleLabel.textColor = .Brimo.Black.main
        titleLabel.isUserInteractionEnabled = false
        titleLabel.configureSkeleton(cornerRadius: 7)

//        monthScrollView.showsHorizontalScrollIndicator = false
        monthStack.axis = .horizontal
        monthStack.spacing = 8
        monthStack.alignment = .center
        monthStack.distribution = .equalCentering
        monthStack.configureSkeleton()

        filterImageView.image = UIImage(named: "utilities/big/filter")
        filterImageView.configureSkeleton(cornerRadius: 16)
        filterImageView.snp.makeConstraints {
            $0.width.height.equalTo(32)
        }
        
        addSubviews(monthStack)
        monthStack.addArrangedSubview(titleLabel)
        monthStack.addArrangedSubview(filterImageView)
    }
    
    private func setupConstraint() {
//        titleLabel.snp.makeConstraints {
//            $0.top.equalToSuperview()
//            $0.leading.equalToSuperview().offset(16)
//            $0.trailing.equalToSuperview().inset(16)
//        }
        
//        monthContainer.snp.makeConstraints {
//            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
//            $0.leading.equalToSuperview()
//            $0.trailing.equalToSuperview().inset(16)
//            $0.height.equalTo(32)
//            $0.bottom.equalToSuperview().inset(16)
//        }
//
//        monthScrollView.snp.makeConstraints {
//            $0.leading.top.bottom.equalToSuperview()
//            $0.trailing.equalTo(filterImageView.snp.leading).offset(-8)
//        }

        monthStack.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(32)
            $0.bottom.equalToSuperview().inset(16)
        }

//        filterImageView.snp.makeConstraints {
//            $0.centerY.equalToSuperview()
//            $0.trailing.equalToSuperview().offset(-4)
//            $0.width.height.equalTo(32)
//        }
    }
    
    func updateTitle(_ title: String) {
        titleLabel.text = title
        titleLabel.sizeToFit()
    }
    
    private func setSkeleton() {
        if isLoading {
            titleLabel.snp.remakeConstraints {
                $0.width.equalTo(150)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) { [weak self] in
                guard let self = self else { return }
                self.showAnimatedSkeleton(usingColor: .Brimo.Black.x200)
                self.monthStack.showAnimatedSkeletonRecursively(usingColor: .Brimo.Black.x200)
            }
        } else {
            titleLabel.snp.removeConstraints()
            stopSkeletonAnimation()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) { [weak self] in
                guard let self = self else { return }
                self.monthStack.stopSkeletonRecursively()
            }
        }
    }
}
