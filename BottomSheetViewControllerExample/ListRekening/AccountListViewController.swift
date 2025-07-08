//
//  FundingSourceViewController.swift
//  BottomSheetViewControllerExample
//
//  Created by PT Diksha Teknologi Indonesia on 06/07/25.
//


import UIKit
import SnapKit

class AccountListViewController: BrimonsBottomSheetVC, UITableViewDataSource, UITableViewDelegate {

    // MARK: - UI Components

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .Brimo.Title.smallSemiBold
        label.textColor = ConstantsColor.black900
        label.text = "Ubah Sumber Dana"
        return label
    }()

    private lazy var closeImgView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "close_bottomsheet_img")
        return img
    }()

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        table.bouncesZoom = false
        table.rowHeight = UITableView.automaticDimension
        table.showsVerticalScrollIndicator = false
        table.estimatedRowHeight = 100
        table.register(AccountListTableViewCell.self, forCellReuseIdentifier: "AccountListTableViewCell")
        return table
    }()

    // MARK: - Data

    var selectedIndex: Int = 0

    let fundingSources: [AccountModel] = [
        AccountModel(logoName: "debit", username: "@marselasatya", cardNumbers: ["6013 3455 0999 120"], balance: "Rp5.000.000", isUtama: true),
        AccountModel(logoName: "debit", username: nil, cardNumbers: ["6013 3455 0999 444", "6013 3455 0999 120"], balance: "Rp4.250.325", isUtama: false),
        AccountModel(logoName: "debit", username: "@marselasatya", cardNumbers: ["6013 3455 0999 120"], balance: "Rp2.123.749", isUtama: false)
    ]

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Ubah Sumber Dana"
        setupViews()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateTableViewHeight()
    }

    // MARK: - Setup

    private func setupViews() {
        containerView.addSubview(titleLabel)
        containerView.addSubview(closeImgView)
        containerView.addSubview(tableView)

        self.setContent(content: containerView)

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.centerX.equalToSuperview()
        }

        closeImgView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().inset(16)
            $0.size.equalTo(32)
        }

        tableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(0).priority(.high) // Will be updated
            $0.bottom.lessThanOrEqualToSuperview() // Prevent cutoff
        }
    }

    private func updateTableViewHeight() {
        tableView.layoutIfNeeded()
        titleLabel.layoutIfNeeded()
        
        let titleTopInset: CGFloat = 20
        let titleToTableSpacing: CGFloat = 12
        let titleHeight = titleLabel.intrinsicContentSize.height

        let tableContentHeight = tableView.contentSize.height
        let contentTotal = titleTopInset + titleHeight + titleToTableSpacing + tableContentHeight
        let maxHeight: CGFloat = UIScreen.main.bounds.height - getTopSafeAreaHeight()
        let finalHeight = min(contentTotal, maxHeight)
        
        tableView.isScrollEnabled = contentTotal > maxHeight

        tableView.snp.updateConstraints {
            $0.height.equalTo(finalHeight).priority(.high)
        }
    }

    // MARK: - UITableViewDataSource & Delegate

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fundingSources.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AccountListTableViewCell", for: indexPath) as? AccountListTableViewCell else {
            return UITableViewCell()
        }
        let model = fundingSources[indexPath.row]
        cell.configure(with: model, isSelected: indexPath.row == selectedIndex)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        tableView.reloadData() // update jika isi berubah
    }
}


