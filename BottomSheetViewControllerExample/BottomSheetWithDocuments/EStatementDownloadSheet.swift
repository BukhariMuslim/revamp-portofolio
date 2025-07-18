//
//  EStatementDownloadSheet.swift
//  BottomSheetViewControllerExample
//
//  Created by User01 on 18/07/25.
//

import SnapKit
import UIKit

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
            $0.bottom.equalToSuperview().inset(24)
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
        onExportSelected?(.csv)
        dismissBottomSheet()
    }

    @objc
    private func closeBtnAction(){
        dismissBottomSheet()
    }

}
