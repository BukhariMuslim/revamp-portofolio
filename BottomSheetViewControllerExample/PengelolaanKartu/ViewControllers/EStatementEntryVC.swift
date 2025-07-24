//
//  EStatementEntryVC.swift
//  BottomSheetViewControllerExample
//
//  Created by User01 on 23/07/25.
//

import UIKit

class EStatementEntryVC: UIViewController {

    var showEmptyForCell: Bool = false
    var isLoadingForData: Bool = false

    var numberOfTableSections = 0

    private lazy var backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "background_blue_secondary")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .Brimo.White.main
        view.layer.cornerRadius = 24
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isSkeletonable = true
        return view
    }()

    private let headContainerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16.0
        view.layer.masksToBounds = true
        view.backgroundColor = .Brimo.Black.x100
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isSkeletonable = true

        let leftImage = UIImageView()
        leftImage.image = UIImage(named: "eStatement_ic")
        leftImage.contentMode = .scaleAspectFit
        leftImage.translatesAutoresizingMaskIntoConstraints = false
        leftImage.isSkeletonable = true
        view.addSubview(leftImage)

        let titleLabel = UILabel()
        titleLabel.text = "Buat e-Statement"
        titleLabel.textColor = .Brimo.Black.main
        titleLabel.font = .Brimo.Body.largeSemiBold
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.isSkeletonable = true
        view.addSubview(titleLabel)

        let descLabel = UILabel()
        descLabel.text = "Buat e-statementmu sekarang tanpa datang ke kantor cabang"
        descLabel.numberOfLines = 0
        descLabel.textColor = .Brimo.Black.x600
        descLabel.font = .Brimo.Body.mediumRegular
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        descLabel.isSkeletonable = true
        view.addSubview(descLabel)

        let rightImage = UIImageView()
        rightImage.image = UIImage(named: "arrows/chevron_right")
        rightImage.contentMode = .scaleAspectFit
        rightImage.translatesAutoresizingMaskIntoConstraints = false
        rightImage.isSkeletonable = true
        view.addSubview(rightImage)

        NSLayoutConstraint.activate([
            leftImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            leftImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            leftImage.widthAnchor.constraint(equalToConstant: 40),
            leftImage.heightAnchor.constraint(equalToConstant: 40),

            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leftImage.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: rightImage.leadingAnchor, constant: 8),

            descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            descLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
            descLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

            rightImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            rightImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])

        return view
    }()

    private let mainTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isSkeletonable = true
        tableView.register(EStatementEmptyCell.self, forCellReuseIdentifier: EStatementEmptyCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(backgroundImage)
        view.addSubview(mainView)

        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        setupHeader()
        setupUI()
        setupConstraints()

        showEmptyForCell = false
        isLoadingForData = true
        mainTableView.reloadData()

        if #available(iOS 15.0, *) {
            mainTableView.sectionHeaderTopPadding = 0
        }
    }

    private func setupHeader() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        title = "e-Statement"
        /*addBackButton(
            backgroundType: .transparent,
            title: BrimoConstantV3.eStatementText,
            titleFont: .Brimo.Title.mediumSemiBold
        )*/
    }

    private func setupUI() {
        mainView.addSubview(headContainerView)
        mainView.addSubview(mainTableView)

        mainTableView.delegate = self
        mainTableView.dataSource = self

        headContainerView.addTapGesture(target: self, action: #selector(makeEStatementNow))
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headContainerView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 24),
            headContainerView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16),
            headContainerView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),

            mainTableView.topAnchor.constraint(equalTo: headContainerView.bottomAnchor, constant: 24),
            mainTableView.leadingAnchor.constraint(equalTo: headContainerView.leadingAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: headContainerView.trailingAnchor),
            mainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension EStatementEntryVC {
    @objc
    private func makeEStatementNow() {
        let vc: EStatementMakerVC = EStatementMakerVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension EStatementEntryVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfTableSections > 0 ? numberOfTableSections : 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfTableSections > 0 ? numberOfTableSections : 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if numberOfTableSections < 1 {
            let emptyCell = tableView.dequeueReusableCell(withIdentifier: EStatementEmptyCell.identifier, for: indexPath) as! EStatementEmptyCell
            emptyCell.configure(icon: UIImage(named: "illustrations/empty2") ?? UIImage(),header: "Kamu belum Memiliki e-Statement",desc: "Hemat kertas dan waktu, buat e-statementmu sekarang tanpa datang ke kantor cabang.")
            emptyCell.actionButton.addTarget(self, action: #selector(makeEStatementNow), for: .touchUpInside)
            headContainerView.isHidden = true
            return emptyCell
        }

        headContainerView.isHidden = false
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.clipsToBounds = true

        let label = UILabel()
        label.textColor = .Brimo.Black.x600
        label.font = .Brimo.Body.mediumRegular
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isSkeletonable = true
        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        if numberOfTableSections == 0 {
            label.text = " "
        }

        view.isSkeletonable = true
        return view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return numberOfTableSections > 0 ? 18 : 0
    }
}
