//
//  AccountCardDetailManagerAtivityView.swift
//  BottomSheetViewControllerExample
//
//  Created by Phincon on 07/07/25.
//

import Foundation
import UIKit

class AccountCardDetailManagerActivityView: UIView, UITableViewDataSource, UITableViewDelegate {

    private let titleLabel = UILabel()
    
    private let monthContainer = UIView()
    private let monthScrollView = UIScrollView()
    private let monthStack = UIStackView()
    private let fixedMonthIcon = UIImageView()
    
    private let dateLabel = UILabel()
    private let tableView = UITableView()
    
    private var monthLabels: [UILabel] = []
    
    private var transactions: [(icon: String, title: String, subtitle: String, time: String, amount: String, isCredit: Bool)] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        clipsToBounds = true
        setupLayout()
        setupMonthChips()
        setupDummyTransactions()
        tableView.reloadData()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        titleLabel.text = "Riwayat Transaksi"
        titleLabel.font = .Brimo.Title.smallSemiBold
        titleLabel.textColor = ConstantsColor.black900

        monthScrollView.showsHorizontalScrollIndicator = false
        monthStack.axis = .horizontal
        monthStack.spacing = 8
        monthStack.alignment = .center

        fixedMonthIcon.image = UIImage(systemName: "line.3.horizontal.decrease.circle")
        fixedMonthIcon.tintColor = .darkGray

        dateLabel.text = "14 Juni 2025"
        dateLabel.font = .Brimo.Body.mediumRegular
        dateLabel.textColor = ConstantsColor.black500

        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = true
        tableView.showsVerticalScrollIndicator = false
        tableView.register(TransactionTableViewCell.self, forCellReuseIdentifier: "TransactionTableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        tableView.backgroundColor = .white

        addSubview(titleLabel)
        addSubview(monthContainer)
        monthContainer.addSubview(monthScrollView)
        monthScrollView.addSubview(monthStack)
        monthContainer.addSubview(fixedMonthIcon)
        addSubview(dateLabel)
        addSubview(tableView)

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        monthContainer.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(32)
        }

        monthScrollView.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.trailing.equalTo(fixedMonthIcon.snp.leading).offset(-8)
        }

        monthStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalToSuperview()
        }

        fixedMonthIcon.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-4)
            $0.width.height.equalTo(20)
        }


        dateLabel.snp.makeConstraints {
            $0.top.equalTo(monthContainer.snp.bottom).offset(20)
            $0.leading.equalToSuperview()
        }

        tableView.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func setupMonthChips() {
        let months = ["Januari", "Feb", "Mar", "Apr", "Mei", "Jun", "Jul", "Agu", "Sep", "Okt", "Nov"]
        
        for (index, text) in months.enumerated() {
            let label = UILabel()
            label.text = "\(text.prefix(3))" //max 3 character
            label.font = .Brimo.Body.mediumRegular
            label.textAlignment = .center
            label.layer.cornerRadius = 16
            label.clipsToBounds = true
            label.isUserInteractionEnabled = true
            label.tag = index
            label.snp.makeConstraints { $0.size.equalTo(CGSize(width: 48, height: 32)) }

            // Add tap gesture
            let tap = UITapGestureRecognizer(target: self, action: #selector(handleMonthTap(_:)))
            label.addGestureRecognizer(tap)

            // Save label
            monthLabels.append(label)
            monthStack.addArrangedSubview(label)
        }

        // Set initial active (default last month)
        setActiveMonth(at: months.count - 1)

        // Auto-scroll last chip near icon
        DispatchQueue.main.async {
            guard let lastLabel = self.monthLabels.last else { return }

            let labelFrameInScroll = lastLabel.convert(lastLabel.bounds, to: self.monthScrollView)
            let iconFrameInScroll = self.fixedMonthIcon.convert(self.fixedMonthIcon.bounds, to: self.monthScrollView)

            let desiredOffsetX = labelFrameInScroll.maxX - iconFrameInScroll.minX + 8
            let finalOffset = max(desiredOffsetX, 0)

            self.monthScrollView.setContentOffset(CGPoint(x: finalOffset, y: 0), animated: false)
        }
    }

    private func setupDummyTransactions() {
        transactions = [
            ("qrcode", "Pembayaran QRIS", "Alfamart Gatot Subroto - 12232319320921832", "12:30:21 AM", "-Rp20.000,00", false),
            ("arrow.left.arrow.right", "Transfer Dana", "Dari BCA - Wijayakusuma\n102499920012", "12:00:21 AM", "+Rp250.000,00", true),
            ("qrcode", "Pembayaran QRIS", "Alfamart Gatot Subroto - 12232319320921832", "12:30:21 AM", "-Rp20.000,00", false),
            ("qrcode", "Pembayaran QRIS", "Alfamart Gatot Subroto - 12232319320921832", "12:30:21 AM", "-Rp20.000,00", false)
        ]
    }

    // MARK: - TableView DataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionTableViewCell", for: indexPath) as? TransactionTableViewCell else {
            return UITableViewCell()
        }

        let item = transactions[indexPath.row]
        cell.configure(iconName: item.icon, title: item.title, subtitle: item.subtitle, time: item.time, amount: item.amount, isCredit: item.isCredit)
        return cell
    }
    
    @objc private func handleMonthTap(_ gesture: UITapGestureRecognizer) {
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


}

class TransactionTableViewCell: UITableViewCell {

    private let iconView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let amountLabel = UILabel()
    private let vStack = UIStackView()
    private let hStack = UIStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .white
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        iconView.contentMode = .scaleAspectFit
        iconView.tintColor = .black
        iconView.snp.makeConstraints { $0.size.equalTo(24) }

        titleLabel.font = .Brimo.Body.mediumSemiBold
        titleLabel.textColor = ConstantsColor.black900
        
        subtitleLabel.font = .Brimo.Body.mediumRegular
        subtitleLabel.textColor = ConstantsColor.black500
        subtitleLabel.numberOfLines = 0

        amountLabel.font = .Brimo.Body.largeSemiBold
        amountLabel.textColor = ConstantsColor.black900
        amountLabel.textAlignment = .right

        vStack.axis = .vertical
        vStack.spacing = 4
        vStack.addArrangedSubview(titleLabel)
        vStack.addArrangedSubview(subtitleLabel)

        hStack.axis = .horizontal
        hStack.spacing = 12
        hStack.alignment = .top
        hStack.addArrangedSubview(iconView)
        hStack.addArrangedSubview(vStack)
        hStack.addArrangedSubview(amountLabel)

        contentView.addSubview(hStack)
        hStack.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12)
            $0.leading.trailing.equalToSuperview()
        }
    }

    func configure(iconName: String, title: String, subtitle: String, time: String, amount: String, isCredit: Bool) {
        iconView.image = UIImage(systemName: iconName)
        titleLabel.text = title
        subtitleLabel.text = "\(subtitle)\n\(time)"
        amountLabel.text = amount
        amountLabel.textColor = isCredit ? .systemGreen : .black
    }
}
