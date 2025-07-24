//
//  EStatementMakerVC.swift
//  BottomSheetViewControllerExample
//
//  Created by User01 on 23/07/25.
//

import SnapKit
import UIKit

class EStatementMakerVC: UIViewController {

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

    private var headLabel1: UILabel = UILabel()
    private var headLabel2: UILabel = UILabel()
    private var headLabel3: UILabel = UILabel()

    private var cardSectionView: CustomSingleCardComponentView!

    private let bulanInputField: InputField = {
        let input = InputField(type: .dropdown)
        input.placeholder = "Pilih Bulan"
        input.setInputFieldTextColor(.Brimo.Black.main)
        input.setInputFieldFont(.Brimo.Body.largeRegular)
        input.setupFloatingLabel()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.borderOff()
        input.isSkeletonable = true
        input.changeImageView(icon: UIImage(named: "calendar_ic") ?? UIImage())
        return input
    }()

    private let docTypeInputField: InputField = {
        let input = InputField(type: .dropdown)
        input.placeholder = "Tipe Dokumen"
        input.setInputFieldTextColor(.Brimo.Black.main)
        input.setInputFieldFont(.Brimo.Body.largeRegular)
        input.setupFloatingLabel()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.borderOff()
        input.isSkeletonable = true
        return input
    }()

    private let buttonContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .Brimo.White.main
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: -2)
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.1
        view.isSkeletonable = true
        return view
    }()

    private lazy var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Buat e-Statement", for: .normal)
        button.titleLabel?.font = .Brimo.Body.largeSemiBold
        button.layer.cornerRadius = 28
        button.isUserInteractionEnabled = false
        button.backgroundColor = .Brimo.Black.x1000
        button.setTitleColor(ConstantsColor.black500, for: .normal)
        button.addTarget(self, action: #selector(continueAction), for: .touchUpInside)
        return button
    }()

    private var recievedMonth: String = ""
    private var recievedYear: Int = 0

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
    }

    private func setupHeader() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        title = "Buat e-Statement"
        /*addBackButton(
            backgroundType: .transparent,
            title: BrimoConstantV3.eStatementText,
            titleFont: .Brimo.Title.mediumSemiBold
        )*/
    }

    private func setupUI() {
        [headLabel1, headLabel2, headLabel3].forEach {
            $0.textColor = .Brimo.Black.main
            $0.font = .Brimo.Title.smallSemiBold
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.isSkeletonable = true
            mainView.addSubview($0)
        }
        headLabel1.text = "Sumber"
        headLabel2.text = "Rentang Waktu"
        headLabel3.text = "Tipe Dokumen"

        cardSectionView = CustomSingleCardComponentView(icon: UIImage(named: "debit"), name: "@marselasatya", detail: "6013 3455 0999 120")
        cardSectionView.translatesAutoresizingMaskIntoConstraints = false
        cardSectionView.isSkeletonable = true
        cardSectionView.changeTextColors(color1: .Brimo.Black.main, color2: .Brimo.Black.main)
        mainView.addSubview(cardSectionView)

        mainView.addSubview(bulanInputField)
        mainView.addSubview(docTypeInputField)
        mainView.addSubview(buttonContainerView)
        buttonContainerView.addSubview(continueButton)

        bulanInputField.resizeImageView(width: 24, height: 24)

        bulanInputField.onDropdownTapped = {
            self.chooseMonthYear()
        }

        docTypeInputField.onDropdownTapped = {
            self.chooseDocType()
        }
    }

    private func setupConstraints() {
        headLabel1.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        cardSectionView.snp.makeConstraints { make in
            make.top.equalTo(headLabel1.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        headLabel2.snp.makeConstraints { make in
            make.top.equalTo(cardSectionView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        bulanInputField.snp.makeConstraints { make in
            make.top.equalTo(headLabel2.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        headLabel3.snp.makeConstraints { make in
            make.top.equalTo(bulanInputField.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        docTypeInputField.snp.makeConstraints { make in
            make.top.equalTo(headLabel3.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        buttonContainerView.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalToSuperview()
        }

        continueButton.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
    }

    @objc
    private func continueAction() {

    }

    private func toggleActionButton() {
        if recievedYear != 0 && !recievedMonth.isEmpty && docTypeInputField.text?.count == 3 {
            continueButton.isUserInteractionEnabled = false
            continueButton.backgroundColor = .Brimo.Primary.main
            continueButton.setTitleColor(.Brimo.White.main, for: .normal)
        }
    }

    @objc
    private func chooseMonthYear() {
        let bottomSheet = EStatementMonthYearSheet()
        bottomSheet.onDataSaved = { [weak self] (month, year) in
            self?.recievedMonth = month
            self?.recievedYear = year
        }
        self.presentBrimonsBottomSheet(viewController: bottomSheet)
    }

    @objc
    private func chooseDocType() {
        let bottomSheet = EStatementDownloadSheet()
        bottomSheet.onExportSelected = { [weak self] exportType in
            switch exportType {
            case .pdf:
                self?.docTypeInputField.text = "PDF"
                self?.docTypeInputField.showFloatingLabelForced(font: .Brimo.Body.mediumRegular, color: .Brimo.Black.main)
            case .csv:
                self?.docTypeInputField.text = "CSV"
                self?.docTypeInputField.showFloatingLabelForced(font: .Brimo.Body.mediumRegular, color: .Brimo.Black.main)
            }
        }
        self.presentBrimonsBottomSheet(viewController: bottomSheet)
    }
}
