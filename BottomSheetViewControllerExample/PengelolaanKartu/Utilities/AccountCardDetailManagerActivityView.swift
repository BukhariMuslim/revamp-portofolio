//
//  AccountCardDetailManagerActivityView.swift
//  BottomSheetViewControllerExample
//
//  Created by Phincon on 07/07/25.
//

import Foundation
import UIKit
import SnapKit

class AccountCardDetailManagerActivityView: UIView, UITableViewDataSource, UITableViewDelegate {
    private let tableView = UITableView()
    
    private var transactions: [ActivityHistoryViewModel] = []
    
    private var lastTableContentHeight: CGFloat = 0
    private var tableHeightConstraint: Constraint?
    
    private var isShowBorder: Bool = false

    init(isShowBorder: Bool = false) {
        super.init(frame: .zero)
        self.isShowBorder = isShowBorder
        clipsToBounds = true
        setupLayout()
        setupDummyTransactions()
        tableView.reloadData()
        setNeedsLayout()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let contentHeight = tableView.contentSize.height
        if lastTableContentHeight != contentHeight {
            lastTableContentHeight = contentHeight
            tableHeightConstraint?.update(offset: contentHeight + 16)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(TransactionTableViewCell.self, forCellReuseIdentifier: "TransactionTableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        tableView.contentInset.bottom = 16
        tableView.scrollIndicatorInsets = tableView.contentInset

        addSubview(tableView)

        tableView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(120)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
            tableHeightConstraint = $0.height.equalTo(1).constraint
        }
    }

    private func setupDummyTransactions() {
        transactions = [
            ActivityHistoryViewModel(
                icon: "qrcode",
                title: "Pembayaran QRIS",
                subtitle: "Alfamart Gatot Subroto - 12232319320921832",
                time: "12:30:21 AM",
                amount: "-Rp20.000,00",
                status: "success",
                isCredit: false
            ),
            ActivityHistoryViewModel(
                icon: "arrow.left.arrow.right",
                title: "Transfer Dana",
                subtitle: "Dari BCA - Wijayakusuma\n102499920012",
                time: "12:00:21 AM",
                amount: "+Rp250.000,00",
                status: "failed",
                isCredit: false
            ),
            ActivityHistoryViewModel(
                icon: "arrow.left.arrow.right",
                title: "Transfer Dana",
                subtitle: "Dari BCA - Wijayakusuma\n102499920012",
                time: "12:00:21 AM",
                amount: "+Rp250.000,00",
                status: "pending",
                isCredit: false
            ),
            ActivityHistoryViewModel(
                icon: "arrow.left.arrow.right",
                title: "Transfer Dana",
                subtitle: "Dari BCA - Wijayakusuma\n102499920012",
                time: "12:00:21 AM",
                amount: "+Rp250.000,00",
                status: "process",
                isCredit: false
            ),
            ActivityHistoryViewModel(
                icon: "arrow.left.arrow.right",
                title: "Transfer Dana",
                subtitle: "Dari BCA - Wijayakusuma\n102499920012",
                time: "12:00:21 AM",
                amount: "+Rp250.000,00",
                status: "success",
                isCredit: false
            ),
            ActivityHistoryViewModel(
                icon: "arrow.left.arrow.right",
                title: "Transfer Dana",
                subtitle: "Dari BCA - Wijayakusuma\n102499920012",
                time: "12:00:21 AM",
                amount: "+Rp250.000,00",
                status: "success",
                isCredit: false
            ),
            ActivityHistoryViewModel(
                icon: "arrow.left.arrow.right",
                title: "Transfer Dana",
                subtitle: "Dari BCA - Wijayakusuma\n102499920012",
                time: "12:00:21 AM",
                amount: "+Rp250.000,00",
                status: "failed",
                isCredit: false
            )
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
        cell.configure(item: item, isShowBorder: isShowBorder && (transactions.count - 1) != indexPath.row)
        return cell
    }
}

extension UILabel {
    func setText(_ text: String, lineHeight: CGFloat) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = lineHeight
        paragraphStyle.maximumLineHeight = lineHeight
        paragraphStyle.alignment = self.textAlignment

        let attributedString = NSAttributedString(
            string: text,
            attributes: [
                .paragraphStyle: paragraphStyle,
                .baselineOffset: (lineHeight - self.font.lineHeight) / 4,
                .font: self.font ?? UIFont.systemFont(ofSize: 14),
                .foregroundColor: self.textColor ?? .black
            ]
        )

        self.attributedText = attributedString
    }
    
    func setAmountLabel(amountText: String, mainFont: UIFont, decimalFont: UIFont) {
        let attributed = NSMutableAttributedString(string: amountText)

        attributed.addAttribute(.font, value: mainFont, range: NSRange(location: 0, length: amountText.count))

        if let separatorRange = amountText.range(of: "[,.]\\d+$", options: .regularExpression) {
            let nsRange = NSRange(separatorRange, in: amountText)
            attributed.addAttribute(.font, value: decimalFont, range: nsRange)
        }

        self.attributedText = attributed
    }
}
