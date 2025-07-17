//
//  DetailRekeningVC.swift
//  BottomSheetViewControllerExample
//
//  Created by Bukhari Muslim on 17/07/25.
//

import UIKit
import SnapKit

struct ReceiptDataViewViewModel {
    let name: String
    let style: String
    let value: String
}

struct SourceDetailViewModel {
    let description: String
    let iconName: String
    let iconPath: String
    let listType: String
    let receiptAvatar: String
    let subtitle: String
    let title: String
}

struct DetailRekeningViewModel {
    let amountDataView: [ReceiptDataViewViewModel]
    let billingDetail: SourceDetailViewModel
    let closeButtonString: String
    let dataViewTransaction: [ReceiptDataViewViewModel]
    let dateTransaction: String
    let footer: String
    let footerHtml: String
    let headerDataView: [ReceiptDataViewViewModel]
    let helpFlag: Bool
    let immediatelyFlag: Bool
    let onProcess: Bool
    let referenceNumber: String
    let rowDataShow: Int
    let share: Bool
    let shareButtonString: String
    let sourceAccountDataView: SourceDetailViewModel
    let title: String
    let titleImage: String
    let totalDataView: [ReceiptDataViewViewModel]
    let voucherDataView: [ReceiptDataViewViewModel]
}

final class DetailRekeningVC: UIViewController {
    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let headerView: AccountOpeningCompleteHeaderView = AccountOpeningCompleteHeaderView()
    private var depositDetailView: KeyValueComponentView!
    private let recommendedProductsView: RecommendedProductsView = RecommendedProductsView()
    
    private var sourceDataView: SourceDataView!
    
    private lazy var backgroundImgView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "recipe_success_ic")
        return image
    }()

    var viewModel: DetailRekeningViewModel?

    private let doneBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Selesai", for: .normal)
        btn.setTitleColor(ConstantsColor.white900, for: .normal)
        btn.titleLabel?.font = UIFont.Brimo.Body.largeSemiBold
        btn.backgroundColor = ConstantsColor.blue500
        btn.layer.cornerRadius = 28
        return btn
    }()

    private let backgroundDoneBtnView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    init(
        viewModel: DetailRekeningViewModel? = nil
    ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        headerView
            .configure(
                title: viewModel?.title,
                date: viewModel?.dateTransaction,
                imageString: viewModel?.titleImage,
                amount: viewModel?.totalDataView.first?.value
            )
        configureDetailViewData()
        configureSourceData()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ConstantsColor.black100
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false

        setupLayout()
        
        navigationController?.navigationBar.isHidden = true
    }

    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubviews(
            backgroundImgView,
            headerView,
            sourceDataView,
            depositDetailView,
            recommendedProductsView
        )

        view.addSubview(backgroundDoneBtnView)
        backgroundDoneBtnView.addSubview(doneBtn)
        
        doneBtn.addTarget(self, action: #selector(back), for: .touchUpInside)
        
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(backgroundDoneBtnView.snp.top)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView.snp.width)
        }
        
        backgroundImgView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(812)
        }
        
        headerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(safeAreaTopHeight())
            $0.leading.trailing.equalToSuperview()
        }
        
        sourceDataView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        depositDetailView.snp.makeConstraints {
            $0.top.equalTo(sourceDataView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
                
        recommendedProductsView.snp.makeConstraints {
            $0.top.equalTo(depositDetailView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(220)
            $0.bottom.equalToSuperview().inset(16)
        }
        
        backgroundDoneBtnView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(96)
        }
        
        doneBtn.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(56)
        }
    }
    
    private func transform(_ viewModel: ReceiptDataViewViewModel) -> DepositoKeyValueItemSet {
        return DepositoKeyValueItemSet(
            key: viewModel.name,
            value: viewModel.value,
            keyValueStyle: DepositoKeyValueStyle(
                rawValue: viewModel.style
            ) ?? .none,
            showSeparator: false
        )
    }
    
    private func configureSourceData() {
        if let source = viewModel?.sourceAccountDataView, let destination = viewModel?.billingDetail {
            sourceDataView = SourceDataView(
                source: source,
                destination: destination
            )
        }
    }

    private func configureDetailViewData() {
        var items: [DepositoKeyValueItemSet] = []
        
        items.append(contentsOf: viewModel?.headerDataView.map { self.transform($0) } ?? [])
        items.append(contentsOf: viewModel?.dataViewTransaction.map { self.transform($0) } ?? [])
        items.append(contentsOf: viewModel?.amountDataView.map { self.transform($0)} ?? [])
        items.append(contentsOf: viewModel?.voucherDataView.map { self.transform($0)} ?? [])
        items.append(contentsOf: viewModel?.totalDataView.map { self.transform($0)} ?? [])

        depositDetailView = KeyValueComponentView(
            items: items,
            title: "Detail Transaksi",
            isToggleable: true,
            compactVisibleRows: 3,
            addBRIDescription: true,
            descHeading: "Informasi Hubungi Call Center 789",
            descContent: "Biaya Termasuk PPN (Apabila Dikenakan/Apabila Ada)\nPT. Bank Rakyat Indonesia (Persero) Tbk. Kantor Pusat\nBRI - Jakarta Pusat\nNPWP : 01.001.608.7-093.000"
        )
        
        depositDetailView.backgroundColor = .Brimo.White.main
    }
    
    @objc
    private func back() {
        navigationController?.popViewController(animated: true)
        navigationController?.navigationBar.isHidden = false
    }
}


class SourceDataView: UIView {
    private let source: SourceDetailViewModel
    private let destination: SourceDetailViewModel
    
    private lazy var mainStackView: UIStackView = {
        let stack: UIStackView = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 0
        return stack
    }()
    
    private lazy var sourceImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "image_placeholder/default_circle_32")
        imageView.snp.makeConstraints {
            $0.width.equalTo(32)
            $0.height.equalTo(32)
        }
        return imageView
    }()
    
    private lazy var sourceTopLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .Brimo.Body.largeSemiBold
        label.textColor = .Brimo.Black.main
        return label
    }()
    
    private lazy var sourceBottomLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .Brimo.Body.largeSemiBold
        label.textColor = .Brimo.Black.main
        return label
    }()
    
    private lazy var destinationImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "image_placeholder/default_circle_32")
        imageView.snp.makeConstraints {
            $0.width.equalTo(32)
            $0.height.equalTo(32)
        }
        return imageView
    }()
    
    private lazy var destinationTopLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .Brimo.Body.largeSemiBold
        label.textColor = .Brimo.Black.main
        return label
    }()
    
    private lazy var delimiterImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "arrows/ico_arrow_down")
        imageView.snp.makeConstraints {
            $0.width.equalTo(14)
            $0.height.equalTo(14)
        }
        return imageView
    }()
    
    private lazy var delimiterView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .Brimo.Black.x200
        view.snp.makeConstraints {
            $0.height.equalTo(1)
        }
        return view
    }()
    
    private lazy var destinationBottomLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .Brimo.Body.largeSemiBold
        label.textColor = .Brimo.Black.main
        return label
    }()
    
    private lazy var sourceLabelStackView: UIStackView = {
        let stack: UIStackView = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        stack.spacing = 2
        return stack
    }()
    
    private lazy var sourceStackView: UIStackView = {
        let stack: UIStackView = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.alignment = .leading
        stack.spacing = 12
        return stack
    }()
    
    private lazy var destinationLabelStackView: UIStackView = {
        let stack: UIStackView = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        stack.spacing = 2
        return stack
    }()
    
    private lazy var destinationStackView: UIStackView = {
        let stack: UIStackView = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.alignment = .leading
        stack.spacing = 12
        return stack
    }()
    
    private lazy var delimiterStackView: UIStackView = {
        let stack: UIStackView = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 12
        return stack
    }()
    
    init(source: SourceDetailViewModel, destination: SourceDetailViewModel) {
        self.source = source
        self.destination = destination
        super.init(frame: .zero)
        
        setupView()
        updateContent()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        sourceLabelStackView.addArrangedSubview(sourceTopLabel)
        sourceLabelStackView.addArrangedSubview(sourceBottomLabel)
        sourceStackView.addArrangedSubview(sourceImageView)
        sourceStackView.addArrangedSubview(sourceLabelStackView)
        
        destinationLabelStackView.addArrangedSubview(destinationTopLabel)
        destinationLabelStackView.addArrangedSubview(destinationBottomLabel)
        destinationStackView.addArrangedSubview(destinationImageView)
        destinationStackView.addArrangedSubview(destinationLabelStackView)
        
        let delimiterImageContainerView: UIView = UIView()
        delimiterImageContainerView.addSubview(delimiterImageView)
        delimiterStackView.addArrangedSubview(delimiterImageContainerView)
        delimiterStackView.addArrangedSubview(delimiterView)
        
        mainStackView.addArrangedSubview(sourceStackView)
        mainStackView.addArrangedSubview(delimiterStackView)
        mainStackView.addArrangedSubview(destinationStackView)
        addSubview(mainStackView)
        
        layer.cornerRadius = 16
        backgroundColor = .Brimo.White.main
        
        delimiterImageView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(4)
            $0.horizontalEdges.equalToSuperview().inset(7)
        }
        
        mainStackView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(12)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    
    private func updateContent() {
        sourceTopLabel.text = source.title
        sourceBottomLabel.text = source.description
        
        destinationTopLabel.text = destination.title
        destinationBottomLabel.text = destination.description
    }
}
