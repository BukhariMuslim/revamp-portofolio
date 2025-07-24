//
//  EStatementDownloadSheet.swift
//  BottomSheetViewControllerExample
//
//  Created by User01 on 18/07/25.
//

import SnapKit
import UIKit

class EStatementMonthYearSheet: BrimonsBottomSheetVC {
    var selectedMonth: String = ""
    var selectedYear: Int = 2000

    var onDataSaved: ((String, Int) -> Void)?

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Pilih Bulan"
        label.textColor = ConstantsColor.black900
        label.font = .Brimo.Title.smallSemiBold
        label.textAlignment = .center
        return label
    }()

    private lazy var closeImgView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "close_bottomsheet_img")
        img.isUserInteractionEnabled = true
        return img
    }()

    private let monthYearPickerView: UIPickerView = {
        let pView = UIPickerView()
        pView.translatesAutoresizingMaskIntoConstraints = false
        return pView
    }()

    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Buat e-Statement", for: .normal)
        button.titleLabel?.font = .Brimo.Body.largeSemiBold
        button.backgroundColor = .Brimo.Primary.main
        button.setTitleColor(.Brimo.White.main, for: .normal)
        button.layer.cornerRadius = 28
        return button
    }()

    private let months = Calendar.current.monthSymbols
    private let years = Array(2000...2030)

    private var containerBottomConstraint: Constraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()

        saveButton.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        closeImgView.addTapGesture(target: self, action: #selector(closeBtnAction))
    }

    private func setupView() {
        view.addSubview(containerView)
        monthYearPickerView.dataSource = self
        monthYearPickerView.delegate = self
        containerView.addSubviews(titleLabel, closeImgView, monthYearPickerView, saveButton)
    }

    private func setupLayout() {
        containerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            self.containerBottomConstraint = $0.bottom.equalToSuperview().constraint
        }

        closeImgView.snp.remakeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview().inset(16)
            $0.size.equalTo(32)
        }

        titleLabel.snp.remakeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        monthYearPickerView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(188)
        }

        saveButton.snp.makeConstraints {
            $0.top.equalTo(monthYearPickerView.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(56)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(24)
        }
    }

    @objc
    private func saveAction() {
        dismissBottomSheet()
    }

    @objc
    private func closeBtnAction() {
        dismissBottomSheet()
    }
}

extension EStatementMonthYearSheet: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return component == 0 ? months.count : years.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return component == 0 ? months[row] : "\(years[row])"
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedMonth = months[pickerView.selectedRow(inComponent: 0)]
        selectedYear = years[pickerView.selectedRow(inComponent: 1)]
    }

    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return (view.frame.width - 48) / 2
    }

    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let isSelected = pickerView.selectedRow(inComponent: component) == row
        let text = component == 0 ? months[row] : "\(years[row])"
        return NSAttributedString(string: text, attributes: [
            .foregroundColor: isSelected ? UIColor.systemBlue : UIColor.gray,
            .font: UIFont.systemFont(ofSize: 18, weight: isSelected ? .semibold : .regular)
        ])
    }
}

class EStatementDownloadSheet: BrimonsBottomSheetVC {
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Tipe Dokumen"
        label.textColor = ConstantsColor.black900
        label.font = .Brimo.Title.smallSemiBold
        label.textAlignment = .center
        return label
    }()

    private lazy var closeImgView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "close_bottomsheet_img")
        img.isUserInteractionEnabled = true
        return img
    }()

    private let pdfOptionView = EStatementOptionView(image: UIImage(named: "pdf_doc_ic"), title: "PDF")
    private let csvOptionView = EStatementOptionView(image: UIImage(named: "csv_doc_ic"), title: "CSV")
    private let separator1 = UIView()
    private let separator2 = UIView()

    private var containerBottomConstraint: Constraint?

    var onExportSelected: ((EStatementExportType) -> Void)?

    enum EStatementExportType {
        case pdf
        case csv
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
    }

    private func setupView(){
        view.addSubview(containerView)
        containerView.addSubviews(titleLabel, closeImgView, pdfOptionView, separator1, csvOptionView, separator2)
        setContent(content: containerView)

        closeImgView.addTapGesture(target: self, action: #selector(closeBtnAction))
        pdfOptionView.addTapGesture(target: self, action: #selector(didTapPDF))
        csvOptionView.addTapGesture(target: self, action: #selector(didTapCSV))

        [separator1, separator2].forEach {
            $0.backgroundColor = UIColor(hex: "#F1F2F6")
        }
    }

    private func setupLayout() {
        containerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            self.containerBottomConstraint = $0.bottom.equalToSuperview().constraint
        }

        closeImgView.snp.remakeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview().inset(16)
            $0.size.equalTo(32)
        }

        titleLabel.snp.remakeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        pdfOptionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        separator1.snp.makeConstraints {
            $0.top.equalTo(pdfOptionView.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }

        csvOptionView.snp.makeConstraints {
            $0.top.equalTo(separator1.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        separator2.snp.makeConstraints {
            $0.top.equalTo(csvOptionView.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(1)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(24)
        }
    }

    @objc
    private func didTapPDF() {
        print("didTapPDF")
        if let handler = onExportSelected {
            print("onExportSelected is not nil")
            handler(.pdf)
        } else {
            print("onExportSelected is nil!")
        }
        dismissBottomSheet()
    }

    @objc
    private func didTapCSV() {
        dismissBottomSheet()
        onExportSelected?(.csv)
    }

    @objc
    private func closeBtnAction(){
        dismissBottomSheet()
    }

}
