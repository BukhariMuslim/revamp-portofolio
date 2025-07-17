//
//  AccountCardDetailFilter.swift
//  BottomSheetViewControllerExample
//
//  Created by Bukhari Muslim on 16/07/25.
//

import UIKit
import SnapKit

class AccountCardDetailFilter: UIView {
    private let titleLabel: UILabel = UILabel()
    
    private let monthContainer: UIView = UIView()
    private let monthScrollView: UIScrollView = UIScrollView()
    private let monthStack: UIStackView = UIStackView()
    private let fixedMonthIcon: UIImageView = UIImageView()
    
    private var monthLabels: [UILabel] = []
    
    private var sectionTitle: String = ""
    
    init(title: String = "Riwayat Qitta") {
        super.init(frame: .zero)
        sectionTitle = title
        setupLayout()
        setupConstraint()
        setupMonthChips()
        setNeedsLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        titleLabel.text = sectionTitle
        titleLabel.font = .Brimo.Title.smallSemiBold
        titleLabel.textColor = .Brimo.Black.main
        titleLabel.isUserInteractionEnabled = false

        monthScrollView.showsHorizontalScrollIndicator = false
        monthStack.axis = .horizontal
        monthStack.spacing = 8
        monthStack.alignment = .center

        fixedMonthIcon.image = UIImage(named: "utilities/big/filter")
        
        addSubviews(titleLabel, monthContainer)
        monthContainer.addSubviews(monthScrollView, fixedMonthIcon)
        monthScrollView.addSubview(monthStack)
    }
    
    private func setupConstraint() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        monthContainer.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(32)
            $0.bottom.equalToSuperview().inset(16)
        }

        monthScrollView.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.trailing.equalTo(fixedMonthIcon.snp.leading).offset(-8)
        }

        monthStack.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview()
            $0.height.equalToSuperview()
        }

        fixedMonthIcon.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-4)
            $0.width.height.equalTo(32)
        }
    }
    
    private func setupMonthChips() {
        let months: [String] = ["Januari", "Feb", "Mar", "Apr", "Mei", "Jun", "Jul", "Agu", "Sep", "Okt", "Nov"]
        let MAX_CHAR: Int = 3
        
        for (index, text) in months.enumerated() {
            let label = UILabel()
            label.text = "\(text.prefix(MAX_CHAR))"
            label.font = .Brimo.Body.mediumRegular
            label.textAlignment = .center
            label.layer.cornerRadius = 16
            label.clipsToBounds = true
            label.isUserInteractionEnabled = true
            label.tag = index
            label.snp.makeConstraints { $0.size.equalTo(CGSize(width: 48, height: 32)) }

            let tap = UITapGestureRecognizer(target: self, action: #selector(handleMonthTap(_:)))
            label.addGestureRecognizer(tap)

            monthLabels.append(label)
            monthStack.addArrangedSubview(label)
        }

        setActiveMonth(at: months.count - 1)

        DispatchQueue.main.async {
            guard let lastLabel = self.monthLabels.last else { return }

            let labelFrameInScroll = lastLabel.convert(lastLabel.bounds, to: self.monthScrollView)
            let iconFrameInScroll = self.fixedMonthIcon.convert(self.fixedMonthIcon.bounds, to: self.monthScrollView)

            let desiredOffsetX = labelFrameInScroll.maxX - iconFrameInScroll.minX + 8
            let finalOffset = max(desiredOffsetX, 0)

            self.monthScrollView.setContentOffset(CGPoint(x: finalOffset, y: 0), animated: false)
        }
    }
    
    @objc
    private func handleMonthTap(_ gesture: UITapGestureRecognizer) {
        guard let tappedLabel = gesture.view as? UILabel else { return }
        setActiveMonth(at: tappedLabel.tag)
    }
    
    private func setActiveMonth(at index: Int) {
        guard index >= 0, index < monthLabels.count else { return }

        for (i, label) in monthLabels.enumerated() {
            label.backgroundColor = (i == index) ? ConstantsColor.primary100 : ConstantsColor.black100
            label.textColor = (i == index) ? .Brimo.Primary.main : ConstantsColor.black900
        }

        let activeLabel = monthLabels[index]
        let labelFrame = activeLabel.convert(activeLabel.bounds, to: monthScrollView)
        let visibleRect = CGRect(origin: monthScrollView.contentOffset, size: monthScrollView.bounds.size)

        let spacing: CGFloat = 24

        if !visibleRect.contains(labelFrame) {
            var targetOffsetX: CGFloat = 0

            if labelFrame.minX < visibleRect.minX {
                targetOffsetX = labelFrame.minX - spacing
            } else if labelFrame.maxX > visibleRect.maxX {
                targetOffsetX = labelFrame.maxX - monthScrollView.bounds.width + spacing
            }

            targetOffsetX = max(0, min(targetOffsetX, monthScrollView.contentSize.width - monthScrollView.bounds.width))
            monthScrollView.setContentOffset(CGPoint(x: targetOffsetX, y: 0), animated: true)
        }
    }
    
    func updateTitle(_ title: String) {
        titleLabel.text = title
        titleLabel.sizeToFit()
    }
}
