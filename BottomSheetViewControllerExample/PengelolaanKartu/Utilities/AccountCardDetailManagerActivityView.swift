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
    typealias DetailActivitySelectedHandler = (_ viewController: UIViewController) -> Void
    
    private let tableView = UITableView()
    
    private var transactions: [ActivityHistoryItemViewModel] = []
    
    private var lastTableContentHeight: CGFloat = 0
    private var tableHeightConstraint: Constraint?
    
    private var isShowBorder: Bool = false
    
    var onItemSelected: DetailActivitySelectedHandler?

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
            ActivityHistoryItemViewModel(
                iconName: "icon_e_wallet",
                iconPath: "https://brimo.bri.co.id/erangel/assets/activity/icon_e_wallet.png",
                title: "E Wallet",
                subTitle: "Gopay Customer - 08515688732",
                referenceNumber: "872870709362",
                date: "16 Jul 2025 09:42",
                amount: "Rp16.000",
                status: "process"
            ),
            ActivityHistoryItemViewModel(
                iconName: "icon_e_wallet",
                iconPath: "https://brimo.bri.co.id/erangel/assets/activity/icon_e_wallet.png",
                title: "E Wallet",
                subTitle: "Gopay Customer - 085156436280",
                referenceNumber: "872870708192",
                date: "15 Jul 2025 22:46",
                amount: "Rp36.000",
                status: "success"
            ),
            ActivityHistoryItemViewModel(
                iconName: "icon_e_wallet",
                iconPath: "https://brimo.bri.co.id/erangel/assets/activity/icon_e_wallet.png",
                title: "E Wallet",
                subTitle: "Gopay Customer - 085716770019",
                referenceNumber: "8728701239302",
                date: "15 Jul 2025 19:19",
                amount: "Rp31.000",
                status: "success"
            ),
            ActivityHistoryItemViewModel(
                iconName: "icon_transfer",
                iconPath: "https://brimo.bri.co.id/erangel/assets/activity/icon_transfer.png",
                title: "Transfer",
                subTitle: "BANK JAGO - 104761009676",
                referenceNumber: "8728700192393",
                date: "15 Jul 2025 08:51",
                amount: "Rp102.500",
                status: "success"
            ),
            ActivityHistoryItemViewModel(
                iconName: "icon_transfer",
                iconPath: "https://brimo.bri.co.id/erangel/assets/activity/icon_transfer.png",
                title: "Transfer",
                subTitle: "BANK JAGO - 104761009676",
                referenceNumber: "8728700019292",
                date: "15 Jul 2025 08:50",
                amount: "Rp102.500",
                status: "failed"
            ),
            ActivityHistoryItemViewModel(
                iconName: "icon_pembelian_qris",
                iconPath: "https://brimo.bri.co.id/erangel/assets/activity/icon_pembelian_qris.png",
                title: "Pembelian QRIS",
                subTitle: "V LAUNDRY - 000885003014227",
                referenceNumber: "8728700018190",
                date: "13 Jul 2025 20:33",
                amount: "Rp52.000",
                status: "success"
            ),
            ActivityHistoryItemViewModel(
                iconName: "icon_transfer",
                iconPath: "https://brimo.bri.co.id/erangel/assets/activity/icon_transfer.png",
                title: "Transfer",
                subTitle: "BANK JAGO - 104761009676",
                referenceNumber: "8728700017110",
                date: "13 Jul 2025 18:12",
                amount: "Rp57.200",
                status: "pending"
            ),
            ActivityHistoryItemViewModel(
                iconName: "icon_transfer",
                iconPath: "https://brimo.bri.co.id/erangel/assets/activity/icon_transfer.png",
                title: "Transfer",
                subTitle: "BANK JAGO - 104761009936",
                referenceNumber: "8728700016102",
                date: "13 Jul 2025 15:11",
                amount: "Rp30.520",
                status: "success"
            )
        ]
    }

    // MARK: - TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: TransactionTableViewCell.self),
            for: indexPath
        ) as? TransactionTableViewCell else {
            return UITableViewCell()
        }

        let item = transactions[indexPath.row]
        cell.configure(item: item, isShowBorder: isShowBorder && (transactions.count - 1) != indexPath.row)
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let item = transactions[indexPath.row]
        let detailViewModel: DetailRekeningViewModel = DetailRekeningViewModel(
            amount: item.amount,
            date: item.date,
            remark: item.subTitle,
            reference: item.referenceNumber,
            transactionType: item.title,
            destinationAccount: item.subTitle,
            destinationAccountNumber: item.subTitle,
            additionalAmount: ""
        )
        let detailVC: DetailRekeningVC = DetailRekeningVC(
            viewModel: detailViewModel
        )
        
        onItemSelected?(detailVC)
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
