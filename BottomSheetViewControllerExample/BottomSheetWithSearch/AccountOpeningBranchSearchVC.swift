//
//  AccountOpeningBranchSearchViewController.swift
//  BottomSheetViewControllerExample
//
//  Created by PT Diksha Teknologi Indonesia on 27/06/25.
//

import Foundation
import UIKit
import SnapKit

struct DummyLocation {
    var branch: String
    var detailLocation: String
    var distance: String
}

final class AccountOpeningBranchSearchVC: BrimonsBottomSheetVC {
    
    private let dummyBranches = [
        DummyLocation(branch: "Jakarta Branch", detailLocation: "Jl. Thamrin No. 15, Jakarta", distance: "2.3 km"),
        DummyLocation(branch: "Bandung Branch", detailLocation: "Jl. Merdeka No. 10, Bandung", distance: "5.0 km"),
        DummyLocation(branch: "Surabaya Branch", detailLocation: "Jl. Raya No. 25, Surabaya", distance: "10.2 km"),
        DummyLocation(branch: "Medan Branch", detailLocation: "Jl. Pahlawan No. 7, Medan", distance: "12.4 km"),
        DummyLocation(branch: "Denpasar Branch", detailLocation: "Jl. Sunset Road No. 5, Denpasar", distance: "20.1 km"),
        DummyLocation(branch: "Semarang Branch", detailLocation: "Jl. Diponegoro No. 19, Semarang", distance: "7.8 km"),
        DummyLocation(branch: "Makassar Branch", detailLocation: "Jl. Sudirman No. 12, Makassar", distance: "15.6 km"),
        DummyLocation(branch: "Palembang Branch", detailLocation: "Jl. Alamsyah No. 3, Palembang", distance: "8.9 km"),
        DummyLocation(branch: "Yogyakarta Branch", detailLocation: "Jl. Malioboro No. 30, Yogyakarta", distance: "14.5 km"),
        DummyLocation(branch: "Balikpapan Branch", detailLocation: "Jl. Pahlawan No. 11, Balikpapan", distance: "16.2 km"),
        DummyLocation(branch: "Batam Branch", detailLocation: "Jl. Nagoya No. 8, Batam", distance: "18.7 km"),
        DummyLocation(branch: "Pekanbaru Branch", detailLocation: "Jl. Sudirman No. 18, Pekanbaru", distance: "9.1 km"),
        DummyLocation(branch: "Malang Branch", detailLocation: "Jl. Ijen No. 22, Malang", distance: "13.3 km"),
        DummyLocation(branch: "Manado Branch", detailLocation: "Jl. Merdeka No. 21, Manado", distance: "11.5 km"),
        DummyLocation(branch: "Banjarmasin Branch", detailLocation: "Jl. A. Yani No. 16, Banjarmasin", distance: "19.2 km"),
        DummyLocation(branch: "Padang Branch", detailLocation: "Jl. Raya Padang No. 8, Padang", distance: "17.0 km"),
        DummyLocation(branch: "Cirebon Branch", detailLocation: "Jl. Siliwangi No. 5, Cirebon", distance: "10.5 km"),
        DummyLocation(branch: "Solo Branch", detailLocation: "Jl. Slamet Riyadi No. 28, Solo", distance: "6.2 km"),
        DummyLocation(branch: "Pontianak Branch", detailLocation: "Jl. Alun-Alun No. 9, Pontianak", distance: "25.3 km"),
        DummyLocation(branch: "Jambi Branch", detailLocation: "Jl. Jambi No. 4, Jambi", distance: "23.0 km"),
        DummyLocation(branch: "Kendari Branch", detailLocation: "Jl. Sulawesi No. 14, Kendari", distance: "22.1 km"),
        DummyLocation(branch: "Mataram Branch", detailLocation: "Jl. Raya Mataram No. 12, Mataram", distance: "26.4 km"),
        DummyLocation(branch: "Tangerang Branch", detailLocation: "Jl. M.H. Thamrin No. 21, Tangerang", distance: "3.8 km"),
        DummyLocation(branch: "Bekasi Branch", detailLocation: "Jl. Jendral Sudirman No. 5, Bekasi", distance: "5.9 km"),
        DummyLocation(branch: "Depok Branch", detailLocation: "Jl. Margonda No. 15, Depok", distance: "4.2 km"),
        DummyLocation(branch: "Bogor Branch", detailLocation: "Jl. Bogor Raya No. 3, Bogor", distance: "7.4 km"),
        DummyLocation(branch: "Cilegon Branch", detailLocation: "Jl. Merdeka No. 8, Cilegon", distance: "21.0 km"),
        DummyLocation(branch: "Tegal Branch", detailLocation: "Jl. Raya Tegal No. 6, Tegal", distance: "18.3 km"),
        DummyLocation(branch: "Samarinda Branch", detailLocation: "Jl. Samratulangi No. 17, Samarinda", distance: "28.9 km"),
        DummyLocation(branch: "Jayapura Branch", detailLocation: "Jl. Pantai No. 9, Jayapura", distance: "30.0 km")
    ]
    
    private var filteredBranches: [DummyLocation] = []
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var closeImgView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "close_bottomsheet_img")
        return img
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Pilih Kantor BRI"
        label.textAlignment = .center
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var branchOfficeTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(AccountOpeningBranchCell.self, forCellReuseIdentifier: "AccountOpeningBranchCell")
        tableView.register(EmptyBranchCell.self, forCellReuseIdentifier: "EmptyBranchCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var searchView: BrimonsSearchView = {
        let view = BrimonsSearchView()
        view.placeHolderTextField = "Cari Kantor BRI"
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filteredBranches = dummyBranches
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(closeImgView)
        containerView.addSubview(searchView)
        containerView.addSubview(branchOfficeTableView)
        
        self.setContent(content: containerView)
        
        setupLayout()
        
        searchView.onTextChanged = { [weak self] text in
            guard let self else { return }
            self.filterBranches(with: text)
        }
    }
    
    
    private func setupLayout() {
        
        titleLabel.snp.remakeConstraints {
            $0.top.equalTo(containerView.snp.top).offset(20)
            $0.centerX.equalTo(containerView.snp.centerX)
        }
        
        closeImgView.snp.remakeConstraints {
            $0.trailing.equalTo(containerView.snp.trailing).inset(16)
            $0.top.equalTo(containerView.snp.top).offset(10)
            $0.size.equalTo(32)
        }
        
        searchView.snp.remakeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(containerView).inset(16)
            $0.height.equalTo(44)
        }
        
        branchOfficeTableView.snp.remakeConstraints {
            $0.top.equalTo(searchView.snp.bottom).offset(12)
            $0.height.greaterThanOrEqualTo(UIScreen.main.bounds.height - 40).priority(.high) // counting height tableview change -40 to height navigation bar
            $0.leading.trailing.bottom.equalTo(containerView)
        }
    }
    
    private func filterBranches(with query: String) {
        if query.isEmpty {
            filteredBranches = dummyBranches
        } else {
            filteredBranches = dummyBranches.filter { location in
                location.branch.lowercased().contains(query.lowercased()) ||
                location.detailLocation.lowercased().contains(query.lowercased()) ||
                location.distance.lowercased().contains(query.lowercased())
            }
        }
        branchOfficeTableView.reloadData()
    }

}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension AccountOpeningBranchSearchVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredBranches.isEmpty ? 1 : filteredBranches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if filteredBranches.isEmpty {
            return tableView.dequeueReusableCell(withIdentifier: "EmptyBranchCell", for: indexPath)
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AccountOpeningBranchCell", for: indexPath) as? AccountOpeningBranchCell else { return UITableViewCell() }
        cell.configure(title: filteredBranches[indexPath.row].branch, subtitle: filteredBranches[indexPath.row].detailLocation, distanceText: filteredBranches[indexPath.row].distance)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

class AccountOpeningBranchCell: UITableViewCell {

    // MARK: - UI Components

    private let backgroundContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.numberOfLines = 2
        return label
    }()

    private let distanceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    private let distanceContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 14
        view.clipsToBounds = true
        return view
    }()

    private let chevronImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let emptySpaceView = UIView()

    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel, emptySpaceView, distanceContainerView])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .leading // penting agar distanceContainerView tidak dipaksa lebar
        return stackView
    }()

    // MARK: - Initializer

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }

    // MARK: - Layout Setup with SnapKit

    private func setupLayout() {
        contentView.addSubview(backgroundContainerView)
        backgroundContainerView.addSubview(containerStackView)
        backgroundContainerView.addSubview(chevronImageView)
        distanceContainerView.addSubview(distanceLabel)

        backgroundContainerView.snp.remakeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        // Chevron constraints
        chevronImageView.snp.remakeConstraints {
            $0.centerY.equalTo(backgroundContainerView.snp.centerY)
            $0.trailing.equalTo(backgroundContainerView.snp.trailing).inset(16)
            $0.width.height.equalTo(16)
        }

        // Stack view constraints
        containerStackView.snp.remakeConstraints {
            $0.top.leading.equalTo(backgroundContainerView).inset(12)
            $0.bottom.lessThanOrEqualToSuperview().inset(12)
            $0.trailing.lessThanOrEqualTo(chevronImageView.snp.leading).offset(-16)
        }
        
        emptySpaceView.snp.remakeConstraints {
            $0.height.equalTo(8)
        }

        // Distance label in container with padding
        distanceLabel.snp.remakeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(12)
        }

        // Allow distance container to size itself based on label
        distanceContainerView.snp.remakeConstraints {
            $0.height.equalTo(28)
        }

        distanceContainerView.setContentHuggingPriority(.required, for: .horizontal)
        distanceContainerView.setContentCompressionResistancePriority(.required, for: .horizontal)
    }

    // MARK: - Public Configuration Method

    func configure(title: String, subtitle: String, distanceText: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        distanceLabel.text = distanceText
    }
}


final class EmptyBranchCell: UITableViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Yang Anda cari tidak ditemukan"
        label.textAlignment = .center
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Coba gunakan kata kunci lainnya ya"
        label.textAlignment = .center
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImage(systemName: "magnifyingglass")
            .flatMap { UIImageView(image: $0) } ?? UIImageView()
        imageView.tintColor = .lightGray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let containerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.alignment = .center
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .white
        
        contentView.addSubview(containerStackView)
        containerStackView.addArrangedSubview(iconImageView)
        containerStackView.addArrangedSubview(titleLabel)
        containerStackView.addArrangedSubview(subTitleLabel)
        
        iconImageView.snp.makeConstraints { make in
            make.width.height.equalTo(120)
        }
        
        containerStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(24)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}


extension UIViewController {
    func getTopSafeAreaHeight() -> CGFloat {
        return view.safeAreaInsets.top
    }
    
    func getBottomSafeAreaHeight() -> CGFloat {
        return view.safeAreaInsets.bottom
    }
}

