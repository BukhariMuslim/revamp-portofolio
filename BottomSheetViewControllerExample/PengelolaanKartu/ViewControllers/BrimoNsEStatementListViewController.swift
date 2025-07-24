//
//  BrimoNsEStatementListViewController.swift
//  brimo-native
//
//  Created by User01 on 16/07/25.
//  Copyright © 2025 BRImo. All rights reserved.
//

import Foundation
import SnapKit
import UIKit
import SkeletonView

class BrimoNsEStatementListViewController: UIViewController {

    var showEmptyForCell: Bool = false
    var numOfAccounts: Int = 2 // layout different for more than 1
    var isLoadingForData: Bool = false

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

    private let segmentedView: UIView = {
        let view = UIView()
        view.clipsToBounds = true

        let line = UIView()
        line.backgroundColor = .Brimo.Black.x300
        line.translatesAutoresizingMaskIntoConstraints = false
        line.isSkeletonable = true
        view.addSubview(line)

        NSLayoutConstraint.activate([
            line.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            line.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            line.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            line.heightAnchor.constraint(equalToConstant: 1)
        ])

        view.translatesAutoresizingMaskIntoConstraints = false
        view.isSkeletonable = true
        return view
    }()

    private lazy var segment1View = EStatementSegmentView(title: "Rekening")
    private lazy var segment2View = EStatementSegmentView(title: "Gabungan")

    private var sourceOfFundsLabel: UILabel = {
        let label = UILabel()
        label.text = "Sumber Rekening"
        label.font = .Brimo.Body.largeSemiBold
        label.textColor = .Brimo.Black.main
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isSkeletonable = true
        return label
    }()

    private let cardContainerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16.0
        view.layer.masksToBounds = true
        view.backgroundColor = .Brimo.Black.x100
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isSkeletonable = true
        return view
    }()

    private var cardSectionView: CustomSingleCardComponentView!

    private let filterScrollView: UIView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = false
        scrollView.alwaysBounceHorizontal = true
        scrollView.isScrollEnabled = true
        scrollView.isUserInteractionEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let filterContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let buttonMonthly: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.setTitle("Bulanan", for: .normal)
        button.titleLabel?.font = .Brimo.Body.mediumRegular
        button.backgroundColor = .Brimo.Primary.x100
        button.setTitleColor(.Brimo.Primary.main, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isSelected = true
        return button
    }()

    private let buttonPeriod: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.setTitle("Periode", for: .normal)
        button.titleLabel?.font = .Brimo.Body.mediumRegular
        button.backgroundColor = .Brimo.Black.x100
        button.setTitleColor(.Brimo.Black.main, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isSelected = false
        return button
    }()

    private let buttonVisa1: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.setTitle("Visa Schengen", for: .normal)
        button.titleLabel?.font = .Brimo.Body.mediumRegular
        button.backgroundColor = .Brimo.Black.x100
        button.setTitleColor(.Brimo.Black.main, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isSelected = false
        return button
    }()

    private let buttonVisa2: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.setTitle("Visa AS US ID KS SG AU RUS", for: .normal)
        button.titleLabel?.font = .Brimo.Body.mediumRegular
        button.backgroundColor = .Brimo.Black.x100
        button.setTitleColor(.Brimo.Black.main, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isSelected = false
        return button
    }()

    private let mainTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isSkeletonable = true
        return tableView
    }()

    var segmentedHeightConstraint: NSLayoutConstraint!
    var sumberFundsTopConstraint: NSLayoutConstraint!
    var filterHeightConstraint: NSLayoutConstraint!
    var tableViewTopConstraint: NSLayoutConstraint!

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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        [segmentedView, sourceOfFundsLabel, cardContainerView, mainTableView].forEach {
            $0.showAnimatedGradientSkeleton()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            let vc = BottomSheetWithTwoBtnVC()
            vc.setupContent(item: BottomSheetTwoButtonContent(
                image: "failed_bottomsheet_ic",
                title: "Gagal Memuat Halaman",
                subtitle: "Terjadi kendala saat memuat halaman. Silakan coba muat ulang untuk lanjutkan prosesmu.",
                agreeBtnTitle: "Muat Ulang",
                cancelBtnTitle: "",
                hideCancelBtn: true,
                actionButtonTap: { [weak self] in
                    self?.fetchData()
                }
            ))

            self.presentBrimonsBottomSheet(viewController: vc)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
            [self.segmentedView, self.sourceOfFundsLabel, self.cardContainerView, self.mainTableView].forEach {
                $0.hideSkeleton()
            }
            self.isLoadingForData = false
            self.mainTableView.reloadData()
        }
    }

    @objc
    private func fetchData() {
        showEmptyForCell = false
        isLoadingForData = true
        mainTableView.reloadData()
        [segmentedView, sourceOfFundsLabel, cardContainerView, mainTableView].forEach {
            $0.showAnimatedGradientSkeleton()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
            [self.segmentedView, self.sourceOfFundsLabel, self.cardContainerView, self.mainTableView].forEach {
                $0.hideSkeleton()
            }
            self.isLoadingForData = false
            self.mainTableView.reloadData()
        }
    }

    private func setupConstraints() {
        if numOfAccounts > 1 {
            segmentedHeightConstraint = segmentedView.heightAnchor.constraint(equalToConstant: 36)
            sumberFundsTopConstraint = sourceOfFundsLabel.topAnchor.constraint(equalTo: segmentedView.bottomAnchor, constant: 24)
            filterHeightConstraint = filterScrollView.heightAnchor.constraint(equalToConstant: 0)
            tableViewTopConstraint = mainTableView.topAnchor.constraint(equalTo: cardContainerView.bottomAnchor, constant: 24)
        } else if numOfAccounts == 1 {
            segmentedHeightConstraint = segmentedView.heightAnchor.constraint(equalToConstant: 0)
            sumberFundsTopConstraint = sourceOfFundsLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 24)
            filterHeightConstraint = filterScrollView.heightAnchor.constraint(equalToConstant: 0)
            tableViewTopConstraint = mainTableView.topAnchor.constraint(equalTo: cardContainerView.bottomAnchor, constant: 24)
        }

        NSLayoutConstraint.activate([
            segmentedView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 24),
            segmentedView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16),
            segmentedView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),
            segmentedHeightConstraint,

            segment1View.topAnchor.constraint(equalTo: segmentedView.topAnchor),
            segment1View.leadingAnchor.constraint(equalTo: segmentedView.leadingAnchor),
            segment1View.bottomAnchor.constraint(equalTo: segmentedView.bottomAnchor),
            segment2View.topAnchor.constraint(equalTo: segmentedView.topAnchor),
            segment2View.leadingAnchor.constraint(equalTo: segment1View.trailingAnchor, constant: 16),
            segment2View.bottomAnchor.constraint(equalTo: segmentedView.bottomAnchor),

            sourceOfFundsLabel.leadingAnchor.constraint(equalTo: segmentedView.leadingAnchor),
            sourceOfFundsLabel.trailingAnchor.constraint(equalTo: segmentedView.trailingAnchor),
            sumberFundsTopConstraint,
            sourceOfFundsLabel.heightAnchor.constraint(equalToConstant: 20),

            cardContainerView.leadingAnchor.constraint(equalTo: segmentedView.leadingAnchor),
            cardContainerView.trailingAnchor.constraint(equalTo: segmentedView.trailingAnchor),
            cardContainerView.topAnchor.constraint(equalTo: sourceOfFundsLabel.bottomAnchor, constant: 8),
            cardContainerView.heightAnchor.constraint(equalToConstant: 68),

            cardSectionView.leadingAnchor.constraint(equalTo: cardContainerView.leadingAnchor, constant: 16),
            cardSectionView.trailingAnchor.constraint(equalTo: cardContainerView.trailingAnchor, constant: -16),
            cardSectionView.topAnchor.constraint(equalTo: cardContainerView.topAnchor, constant: 16),
            cardSectionView.bottomAnchor.constraint(equalTo: cardContainerView.bottomAnchor, constant: -16),
            cardSectionView.heightAnchor.constraint(equalToConstant: 36),

            filterScrollView.leadingAnchor.constraint(equalTo: segmentedView.leadingAnchor),
            filterScrollView.trailingAnchor.constraint(equalTo: segmentedView.trailingAnchor),
            filterScrollView.topAnchor.constraint(equalTo: cardContainerView.bottomAnchor, constant: 24),
            filterHeightConstraint,

            filterContainerView.leadingAnchor.constraint(equalTo: filterScrollView.leadingAnchor),
            filterContainerView.topAnchor.constraint(equalTo: filterScrollView.topAnchor),
            filterContainerView.bottomAnchor.constraint(equalTo: filterScrollView.bottomAnchor),
            filterContainerView.heightAnchor.constraint(equalTo: filterScrollView.heightAnchor),

            buttonMonthly.topAnchor.constraint(equalTo: filterContainerView.topAnchor),
            buttonMonthly.leadingAnchor.constraint(equalTo: filterContainerView.leadingAnchor),
            buttonMonthly.bottomAnchor.constraint(equalTo: filterContainerView.bottomAnchor),

            buttonPeriod.topAnchor.constraint(equalTo: filterContainerView.topAnchor),
            buttonPeriod.bottomAnchor.constraint(equalTo: filterContainerView.bottomAnchor),
            buttonPeriod.leadingAnchor.constraint(equalTo: buttonMonthly.trailingAnchor, constant: 8),

            buttonVisa1.topAnchor.constraint(equalTo: filterContainerView.topAnchor),
            buttonVisa1.bottomAnchor.constraint(equalTo: filterContainerView.bottomAnchor),
            buttonVisa1.leadingAnchor.constraint(equalTo: buttonPeriod.trailingAnchor, constant: 8),

            buttonVisa2.topAnchor.constraint(equalTo: filterContainerView.topAnchor),
            buttonVisa2.bottomAnchor.constraint(equalTo: filterContainerView.bottomAnchor),
            buttonVisa2.leadingAnchor.constraint(equalTo: buttonVisa1.trailingAnchor, constant: 8),
            buttonVisa2.trailingAnchor.constraint(lessThanOrEqualTo: filterContainerView.trailingAnchor),

            filterContainerView.trailingAnchor.constraint(equalTo: filterScrollView.trailingAnchor),

            mainTableView.leadingAnchor.constraint(equalTo: segmentedView.leadingAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: segmentedView.trailingAnchor),
            tableViewTopConstraint,
            mainTableView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor)
        ])
    }

    private func setupUI() {
        mainView.addSubview(segmentedView)

        segment1View.isSelected = true

        [segment1View, segment2View].forEach {
            segmentedView.addSubview($0)
            $0.addTapGesture(target: self, action: #selector(changeSegment(sender:)))
        }

        mainView.addSubview(sourceOfFundsLabel)
        mainView.addSubview(cardContainerView)
        cardSectionView = CustomSingleCardComponentView(icon: nil, name: "@marselasatya", detail: "6013 3455 0999 120")
        cardSectionView.translatesAutoresizingMaskIntoConstraints = false
        cardSectionView.isSkeletonable = true
        cardContainerView.addSubview(cardSectionView)

        mainView.addSubview(filterScrollView)
        filterScrollView.addSubview(filterContainerView)
        [buttonMonthly, buttonPeriod, buttonVisa1, buttonVisa2].forEach {
            $0.addTarget(self, action: #selector(selectFilter(sender:)), for: .touchUpInside)
            filterContainerView.addSubview($0)
        }

        mainView.addSubview(mainTableView)
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(EStatementEmptyCell.self, forCellReuseIdentifier: EStatementEmptyCell.identifier)
        mainTableView.register(EStatementDateRangeCell.self, forCellReuseIdentifier: EStatementDateRangeCell.identifier)
        mainTableView.register(EStatementMonthCell.self, forCellReuseIdentifier: EStatementMonthCell.identifier)

    }

    @objc
    private func selectFilter(sender: UIButton) {
        [buttonMonthly, buttonPeriod, buttonVisa1, buttonVisa2].forEach {
            if $0.isSelected {
                $0.setTitleColor(.Brimo.Black.main, for: .normal)
                $0.backgroundColor = .Brimo.Black.x100
                $0.isSelected = false
            }
        }

        sender.setTitleColor(.Brimo.Primary.main, for: .normal)
        sender.backgroundColor = .Brimo.Primary.x100
        sender.isSelected = true

        if sender == buttonMonthly {
            showEmptyForCell = true
            mainTableView.reloadData()
        } else if sender == buttonPeriod {
            showEmptyForCell = false
            mainTableView.reloadData()
        } else if sender == buttonVisa1 {
            showEmptyForCell = false
            mainTableView.reloadData()
        } else if sender == buttonVisa2 {

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

    @objc
    private func changeSegment(sender: UITapGestureRecognizer) {
        guard let tappedView = sender.view as? EStatementSegmentView else {
            return
        }

        [segment1View, segment2View].forEach {
            $0.isSelected = ($0 == tappedView)
        }

        if segment1View.isSelected {
            showEmptyForCell = false
        } else {
            showEmptyForCell = true
        }

        mainTableView.reloadData()
    }
}

extension BrimoNsEStatementListViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if showEmptyForCell {
            return 1
        }
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if showEmptyForCell {
            return tableView.dequeueReusableCell(withIdentifier: EStatementEmptyCell.identifier, for: indexPath)
        }

        guard let cell = tableView.dequeueReusableCell(withIdentifier: EStatementMonthCell.identifier, for: indexPath) as? EStatementMonthCell else {
            return UITableViewCell()
        }
        if indexPath.row%2 == 0 {
            cell.configure(title: "Month of Year", subtitle: "Period 1 - 30")
        } else {
            cell.configure(title: "Month of Year", subtitle: nil)
        }
        let totalRows = tableView.numberOfRows(inSection: indexPath.section)
        let isLast = indexPath.row == totalRows - 1
        cell.configureIsLast(isLast)
        return cell

        // MARK: (July 2025) filter may be added in the future - figma unclear

        if buttonMonthly.isSelected {

        } else if buttonPeriod.isSelected {

            guard let cell = tableView.dequeueReusableCell(withIdentifier: EStatementDateRangeCell.identifier, for: indexPath) as? EStatementDateRangeCell else {
                return UITableViewCell()
            }
            let totalRows = tableView.numberOfRows(inSection: indexPath.section)
            let isLast = indexPath.row == totalRows - 1
            cell.configure(isLast: isLast)
            return cell

        } else if buttonVisa1.isSelected {

        }else if buttonVisa2.isSelected {

        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }

        if cell.reuseIdentifier == EStatementMonthCell.identifier {
            downloadEStatement()
        }
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if showEmptyForCell {
            return 200
        }
        return 70
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if !showEmptyForCell && !isLoadingForData {
            return 28
        }

        // MARK: (July 2025) filter may be added in the future - figma unclear

        if buttonVisa1.isSelected {

        }
        return 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .Brimo.White.main

        let label = UILabel()
        view.addSubview(label)

        label.text = "2025"
        label.textColor = .Brimo.Black.x600
        label.font = .Brimo.Body.largeSemiBold

        label.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(8)
        }

        // MARK: (July 2025) filter may be added in the future - figma unclear

        if buttonVisa1.isSelected {

        }

        return view
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension BrimoNsEStatementListViewController: SkeletonTableViewDataSource {
    func numSections(in collectionSkeletonView: UITableView) -> Int {
        return 1
    }

    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return EStatementMonthCell.identifier
    }
}

extension BrimoNsEStatementListViewController {
    func downloadEStatement() {
        let bottomSheet = EStatementDownloadSheet()
        bottomSheet.onExportSelected = { [weak self] exportType in
            switch exportType {
            case .pdf:
                self?.handlePDFExport()
            case .csv:
                self?.handleCSVExport()
            }
        }
        self.presentBrimonsBottomSheet(viewController: bottomSheet)
    }

    func handlePDFExport() {
        DispatchQueue.main.async {
            self.loading(true)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.downloadAndPreviewCSV(withUrlString: "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf", fileName: "eStatement_pdf", fileExtension: "pdf")
        }
    }

    func handleCSVExport() {
        DispatchQueue.main.async {
            self.loading(true)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.downloadAndPreviewCSV(withUrlString: "https://download.microsoft.com/download/5/B/2/5B2108F8-112B-4913-A761-38AFF2FD8598/Sample%20CSV%20file%20for%20importing%20contacts.csv", fileName: "eStatement", fileExtension: "csv")
        }
    }

    func downloadAndPreviewCSV(withUrlString: String, fileName: String, fileExtension: String) {
        guard let remoteURL = URL(string: withUrlString) else {
            print("Invalid URL")
            return
        }

        let task = URLSession.shared.downloadTask(with: remoteURL) { localURL, response, error in
            if let localURL = localURL {
                let fileManager = FileManager.default
                let destinationURL = fileManager.temporaryDirectory.appendingPathComponent("\(fileName).\(fileExtension)")

                try? fileManager.removeItem(at: destinationURL)
                do {
                    try fileManager.moveItem(at: localURL, to: destinationURL)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        self.loading(false)
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        //if fileExtension == "csv" {
                            let previewVC = EStatementCSVQuickLookVC()
                            previewVC.previewFile(url: destinationURL)
                            self.present(previewVC, animated: true)
                        /*} else if fileExtension == "pdf" {
                            let previewVC = EStatementQuickLookVC()
                            previewVC.previewFile(url: destinationURL)
                            self.present(previewVC, animated: true)
                        }*/
                    }
                } catch {
                    print("File move error: \(error)")
                }
            } else if let error = error {
                print("Download error: \(error)")
            }
        }
        task.resume()
    }
}
