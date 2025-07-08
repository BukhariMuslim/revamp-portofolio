//
//  MainTableViewCell.swift
//  BottomSheetViewControllerExample
//
//  Created by PT Diksha Teknologi Indonesia on 02/07/25.
//


import UIKit
import SnapKit
import SkeletonView

class MainTableViewCell: UITableViewCell {

    static let reuseIdentifier = "MainTableViewCell"

    // MARK: - UI Elements
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Loading..."
        label.isSkeletonable = true
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        isSkeletonable = true
        contentView.isSkeletonable = true
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup UI
    private func setupViews() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

    // MARK: - Configure Cell
    func configure(with text: String) {
        titleLabel.text = text
    }
}

class SkeletonViewController: UIViewController {

    var shouldAnimate = true

    // MARK: - UI
    let tableView: UITableView = {
        let tableView = UITableView()
//        tableView.isSkeletonable = true
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        return tableView
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        view.isSkeletonable = true
        setupTableView()

        // Simulasi delay data loading 4 detik
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            self.shouldAnimate = false
//            self.tableView.stopSkeletonAnimation()
//            self.view.hideSkeleton()
            self.tableView.reloadData()
        }
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.reuseIdentifier)

        tableView.showAnimatedGradientSkeleton()
    }
}

// MARK: - UITableViewDataSource + SkeletonView
extension SkeletonViewController: SkeletonTableViewDataSource, UITableViewDelegate {

    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return MainTableViewCell.reuseIdentifier
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reuseIdentifier, for: indexPath) as? MainTableViewCell else {
            return UITableViewCell()
        }

        if shouldAnimate {
            cell.showAnimatedGradientSkeleton()
        } else {
            cell.hideSkeleton()
            cell.configure(with: "Data row \(indexPath.row + 1)")
        }

        return cell
    }
}
