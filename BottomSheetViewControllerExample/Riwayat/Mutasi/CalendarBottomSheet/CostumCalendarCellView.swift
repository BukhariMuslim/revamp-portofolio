//
//  CostumCalendarCellView.swift
//  BottomSheetViewControllerExample
//
//  Created by sia santos on 18/07/25.
//

import UIKit
import SnapKit

class CostumCalendarCellView: UICollectionViewCell {
    
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.Brimo.Body.largeRegular
        return label
    }()
    
    private let backgroundColorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(backgroundColorView)
        contentView.addSubview(dayLabel)
        
        backgroundColorView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(40)
        }
        
        dayLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func configure(
        date: Date?,
        isSelected: Bool,
        isInRange: Bool,
        isStart: Bool,
        isEnd: Bool,
        isDisabled: Bool
    ) {
        guard let date = date else {
            dayLabel.text = ""
            backgroundColorView.backgroundColor = .clear
            return
        }
        
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        dayLabel.text = "\(day)"
        
        if isSelected {
            backgroundColorView.backgroundColor = UIColor.Brimo.Primary.main
            dayLabel.textColor = UIColor.Brimo.White.main
            dayLabel.font = UIFont.Brimo.Body.largeSemiBold
        } else if isInRange {
            backgroundColorView.backgroundColor = UIColor.Brimo.Primary.x100
            dayLabel.textColor = UIColor.Brimo.Primary.main
            dayLabel.font = UIFont.Brimo.Body.largeRegular
        } else {
            backgroundColorView.backgroundColor = .clear
            dayLabel.textColor = isDisabled ? ConstantsColor.black500 : UIColor.Brimo.Black.main
            dayLabel.font = UIFont.Brimo.Body.largeRegular
        }
    }
}
