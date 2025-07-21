//
//  CostumeMonthPickerCell.swift
//  BottomSheetViewControllerExample
//
//  Created by sia santos on 21/07/25.
//

import UIKit
import SnapKit

struct MonthSliderData {
    let title: String
    let year: Int
    let date: Date
    let isCurrent: Bool
}

final class CostumeMonthPickerCell: UITableViewCell {
    
    static let reuseIdentifier = "CostumeMonthPickerCell"
    
    private let monthLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Brimo.Title.mediumSemiBold
        label.textAlignment = .left
        return label
    }()
    
    private let yearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Brimo.Title.mediumSemiBold
        label.textAlignment = .right
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(containerView)
        containerView.addSubview(monthLabel)
        containerView.addSubview(yearLabel)
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 40, bottom: 8, right: 40))
        }
        
        monthLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.trailing.lessThanOrEqualTo(yearLabel.snp.leading).offset(-16)
        }
        
        yearLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.greaterThanOrEqualTo(60)
        }
    }
    
    func configure(with monthData: MonthSliderData, isSelected: Bool) {
        monthLabel.text = monthData.title
        yearLabel.text = "\(monthData.year)"
        
        if isSelected {
            monthLabel.textColor = UIColor.Brimo.Primary.main
            yearLabel.textColor = UIColor.Brimo.Primary.main
        } else {
            monthLabel.textColor = UIColor.Brimo.Black.x600
            yearLabel.textColor = UIColor.Brimo.Black.x600
        }
    }
}
