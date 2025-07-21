//
//  EStatementSegmentView.swift
//  BottomSheetViewControllerExample
//
//  Created by User01 on 18/07/25.
//

import UIKit

class EStatementSegmentView: UIView {
    let segmentLabel: UILabel = UILabel()
    let underline: UIView = UIView()

    var isSelected: Bool = false {
        didSet {
            updateStyle()
        }
    }

    init(title: String) {
        super.init(frame: .zero)
        setup(title: title)

        isSkeletonable = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup(title: String) {
        isUserInteractionEnabled = true
        translatesAutoresizingMaskIntoConstraints = false

        segmentLabel.text = title
        segmentLabel.textAlignment = .center
        segmentLabel.font = .Brimo.Title.smallRegular
        segmentLabel.translatesAutoresizingMaskIntoConstraints = false
        segmentLabel.setContentHuggingPriority(.required, for: .horizontal)
        segmentLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        segmentLabel.isSkeletonable = true
        addSubview(segmentLabel)

        underline.translatesAutoresizingMaskIntoConstraints = false
        underline.isSkeletonable = true
        addSubview(underline)

        NSLayoutConstraint.activate([
            segmentLabel.topAnchor.constraint(equalTo: topAnchor),
            segmentLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            segmentLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            segmentLabel.heightAnchor.constraint(equalToConstant: 24),

            underline.topAnchor.constraint(equalTo: segmentLabel.bottomAnchor, constant: 9),
            underline.leadingAnchor.constraint(equalTo: leadingAnchor),
            underline.trailingAnchor.constraint(equalTo: trailingAnchor),
            underline.heightAnchor.constraint(equalToConstant: 3),
            underline.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        updateStyle()
    }

    private func updateStyle() {
        segmentLabel.font = isSelected ? .Brimo.Title.smallSemiBold : .Brimo.Title.smallRegular
        segmentLabel.textColor = isSelected ? .Brimo.Primary.main : .Brimo.Black.x600
        underline.backgroundColor = isSelected ? .Brimo.Primary.main : .clear
    }
}
