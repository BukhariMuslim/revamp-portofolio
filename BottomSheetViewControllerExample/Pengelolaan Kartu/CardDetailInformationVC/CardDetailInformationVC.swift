//
//  CardDetailInformationVC.swift
//  BottomSheetViewControllerExample
//
//  Created by Phincon on 07/07/25.
//

import UIKit
import SnapKit

// MARK: - Model
struct CardDetailItem {
    let title: String
    let value: String
    let showCopyButton: Bool
    let showDisclosure: Bool
}

class CardDetailInformationCell: UITableViewCell {

    private let titleLabel = UILabel()
    private let valueLabel = UILabel()

    private let iconImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "ic_copy")?.withRenderingMode(.alwaysTemplate))
        iv.tintColor = .Brimo.Primary.main
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    private let copyLabel: UILabel = {
        let label = UILabel()
        label.text = "Salin"
        label.font = .Brimo.Body.mediumSemiBold
        label.textColor = .Brimo.Primary.main
        return label
    }()

    private lazy var copyStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [iconImageView, copyLabel])
        stack.axis = .horizontal
        stack.spacing = 4
        stack.alignment = .center
        return stack
    }()

    private let copyContainer: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1.5
        view.layer.borderColor = UIColor.Brimo.Primary.main.cgColor
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()

    private let arrowImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(systemName: "chevron.right"))
        iv.tintColor = .systemGray3
        iv.contentMode = .scaleAspectFit
        iv.snp.makeConstraints { $0.size.equalTo(16) }
        return iv
    }()

    private let contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()

    private lazy var trailingStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [copyContainer, arrowImageView])
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        return stack
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        setupLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupLayout() {
        titleLabel.font = .Brimo.Body.mediumRegular
        titleLabel.textColor = ConstantsColor.black500
        
        valueLabel.font = .Brimo.Body.largeSemiBold
        valueLabel.textColor = ConstantsColor.black900
        
        valueLabel.numberOfLines = 0

        contentStack.addArrangedSubview(titleLabel)
        contentStack.addArrangedSubview(valueLabel)

        copyContainer.addSubview(copyStack)
        
        copyContainer.snp.remakeConstraints {
            $0.height.equalTo(30)
        }
        
        copyStack.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        }

        contentView.addSubview(contentStack)
        contentView.addSubview(trailingStack)

        contentStack.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.lessThanOrEqualTo(trailingStack.snp.leading).offset(-8)
        }

        trailingStack.snp.makeConstraints {
            $0.centerY.equalTo(contentStack)
            $0.trailing.equalToSuperview().inset(16)
        }
    }

    func configure(with item: CardDetailItem) {
        titleLabel.text = item.title
        valueLabel.text = item.value
        copyContainer.isHidden = !item.showCopyButton
        arrowImageView.isHidden = !item.showDisclosure
    }
}


// MARK: - ViewController
class CardDetailInformationVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private let backgroundContainerView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "background_blue_secondary")
        return img
    }()

    private let roundBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    private let tableView = UITableView()
    private var items: [CardDetailItem] = []
    private let cardAccountDetailInfoView = CardAccountDetailInfoView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupData()
        setupView()
        setupConstraint()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        roundBackgroundView.roundCorners(corners: [.topLeft, .topRight], radius: 24)
    }

    private func setupView() {
        view.addSubviews(backgroundContainerView, roundBackgroundView)
        roundBackgroundView.addSubviews(tableView, cardAccountDetailInfoView)
        

        tableView.register(CardDetailInformationCell.self, forCellReuseIdentifier: "CardDetailInformationCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = true
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
    }

    private func setupConstraint() {
        backgroundContainerView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }

        roundBackgroundView.snp.remakeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        tableView.snp.remakeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        cardAccountDetailInfoView.snp.remakeConstraints {
            $0.top.equalTo(tableView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    private func setupData() {
        items = [
            CardDetailItem(title: "Nomor Rekening", value: "6013 3455 0999 345", showCopyButton: true, showDisclosure: false),
            CardDetailItem(title: "Nama Rekening", value: "Marsela Satya", showCopyButton: false, showDisclosure: false),
            CardDetailItem(title: "Nama Alias", value: "(Belum ada Nama Alias)", showCopyButton: false, showDisclosure: true),
            CardDetailItem(title: "Proxy BI-Fast", value: "Atur Sekarang", showCopyButton: false, showDisclosure: true),
            CardDetailItem(title: "Status Finansial", value: "Aktif", showCopyButton: false, showDisclosure: true),
            CardDetailItem(title: "Status Rekening", value: "Bukan Rekening Utama", showCopyButton: false, showDisclosure: true),
            CardDetailItem(title: "Status Notifikasi Transaksi", value: "Tidak Aktif", showCopyButton: false, showDisclosure: true)
        ]
    }

    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { items.count }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CardDetailInformationCell", for: indexPath) as? CardDetailInformationCell else {
            return UITableViewCell()
        }
        cell.configure(with: item)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // later please change with enum
        if indexPath.row == 2 {
            let vc = CardDetailEditInformationVC()
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 3 {
            dummyBiFastSetup()
        } else if indexPath.row == 4 {
            dummyChangeFinanceView()
        } else if indexPath.row == 5 {
            showRekStatus()
        } else if indexPath.row == 6 {
            moveToDetailNotifyTransaction()
        }
    }
    
    private func dummyBiFastSetup(){
        let alert = UIAlertController(
            title: "Dummy Data",
            message: "Dummy Direction View",
            preferredStyle: .alert
        )

        let cancelAction = UIAlertAction(title: "Success", style: .default) { [weak self] _ in
            guard let self else { return }
            let vc = BiFastSetupVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }

        let disableAction = UIAlertAction(title: "Terhubung dengan bank lain", style: .default) { 
            [weak self] _ in
            guard let self else { return }
            let vc = BiFastActivatedPhoneVC()
            vc.biFastStatus = .connectToAnotherBank
            self.navigationController?.pushViewController(vc, animated: true)
        }

        let deleteAction = UIAlertAction(title: "Terhubung Dengan rekening di bank lain [terblockir]", style: .default) {
            [weak self] _ in
            guard let self else { return }
            let vc = BiFastActivatedPhoneVC()
            vc.biFastStatus = .anotherBankBlock
            self.navigationController?.pushViewController(vc, animated: true)
        }

        alert.addAction(cancelAction)
        alert.addAction(disableAction)
        alert.addAction(deleteAction)

        present(alert, animated: true, completion: nil)
    }
}

extension CardDetailInformationVC {
    private func dummyChangeFinanceView(){
        let alert = UIAlertController(
            title: "Dummy Data",
            message: "Dummy Direction View",
            preferredStyle: .alert
        )

        let success = UIAlertAction(title: "Success", style: .default) { [weak self] _ in
            guard let self else { return }
            dismiss(animated: true)
            // waiting dismiss pop up later don't need implement delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                let vc = BottomSheetWithTwoBtnVC()
                vc.setupContent(item: BottomSheetTwoButtonContent(
                    image: "warning_bottomshet_ic",
                    title: "Nonaktifkan Rekening Finansial?",
                    subtitle: "Kamu tidak dapat melakukan transaksi menggunakan rekening di BRImo jika dinonaktifkan",
                    agreeBtnTitle: "Nonaktifkan",
                    cancelBtnTitle: "Batalkan",
                    hideCancelBtn: true
                ))
                
                self.presentBrimonsBottomSheet(viewController: vc)
            }
        }

        let failed = UIAlertAction(title: "Failed", style: .default) { [weak self] _ in
            guard let self else { return }
            dismiss(animated: true)
            // waiting dismiss pop up later don't need implement delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                let vc = BottomSheetWithTwoBtnVC()
                vc.setupContent(item: BottomSheetTwoButtonContent(
                    image: "failed_bottomsheet_ic",
                    title: "Gagal Memuat Halaman",
                    subtitle: "Terjadi kendala saat memuat halaman. Silakan coba muat ulang untuk lanjutkan prosesmu.",
                    agreeBtnTitle: "Muat Ulang",
                    cancelBtnTitle: "",
                    hideCancelBtn: true
                ))
                
                self.presentBrimonsBottomSheet(viewController: vc)
            }
        }


        alert.addAction(success)
        alert.addAction(failed)

        present(alert, animated: true, completion: nil)
    }
}

// status rekening
extension CardDetailInformationVC {
    private func showRekStatus(){
        let vc = BottomSheetWithTwoBtnVC()
        vc.setupContent(item: BottomSheetTwoButtonContent(
            image: "warning_bottomshet_ic",
            title: "Jadikan Rekening Utama",
            subtitle: "Apakah kamu yakin ingin mengubah rekening ini sebagai rekening utama ?",
            agreeBtnTitle: "Ya, Jadikan Rekening Utama",
            cancelBtnTitle: "Batalkan"
        ))
        
        self.presentBrimonsBottomSheet(viewController: vc)
    }
}

extension CardDetailInformationVC {
    private func moveToDetailNotifyTransaction(){
        let vc = NotifyTransactionManagerVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}
