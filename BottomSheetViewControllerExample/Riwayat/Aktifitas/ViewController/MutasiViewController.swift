//
//  MutasiViewController.swift
//  BottomSheetViewControllerExample
//
//  Created by sia santos on 17/07/25.
//

import UIKit

class MutasiViewController: UIViewController {
    
    private let filterView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let filterIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "line.horizontal.3.decrease")
        imageView.tintColor = UIColor(red: 0.6, green: 0.6, blue: 0.67, alpha: 1.0)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var monthFilterScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    private lazy var monthFilterStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 12
        stack.alignment = .center
        stack.backgroundColor = .white
        return stack
    }()
    
    private lazy var emptyStateView: EmptyStateCellView = {
        let emptyView = EmptyStateCellView()
        emptyView.isHidden = true
        return emptyView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        cv.showsVerticalScrollIndicator = false
        
        cv.register(RiwayatMutasiDateHeaderView.self, forCellWithReuseIdentifier: "RiwayatMutasiDateHeaderView")
        cv.register(RiwayatMutasiCellView.self, forCellWithReuseIdentifier: "RiwayatMutasiCellView")
        
        return cv
    }()
    
    private var mutasiData: [RiwayatMutasiModel] = []
    private var allMutasiData: [RiwayatMutasiModel] = []
    private var selectedMonthIndex: Int? = nil
    
    private let months = ["Jan", "Feb", "Mar", "Apr", "Mei", "Jun", "Jul", "Agu", "Sep", "Okt", "Nov", "Des"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        setupMonthFilter()
        configureEmptyState()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(filterView)
        view.addSubview(collectionView)
        view.addSubview(emptyStateView)
        
        filterView.addSubview(filterIcon)
        filterView.addSubview(monthFilterScrollView)
        monthFilterScrollView.addSubview(monthFilterStackView)
    }
    
    private func configureEmptyState() {
        emptyStateView.configure(data: EmptyStateDataItem(
            imageIcon: "illustrations/empty",
            titleText: "Belum Ada Riwayat Mutasi",
            descriptionText: "Kamu belum pernah melakukan transaksi melalui BRImo. Yuk, mulai transaksimu sekarang!")
        )
    }
    
    private func setupConstraints() {
        filterView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(60)
        }
        
        filterIcon.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(20)
        }
        
        monthFilterScrollView.snp.makeConstraints { make in
            make.leading.equalTo(filterIcon.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
            make.height.equalTo(32)
        }
        
        monthFilterStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(filterView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        emptyStateView.snp.makeConstraints { make in
            make.top.equalTo(filterView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupMonthFilter() {
        for (index, month) in months.enumerated() {
            let button = createMonthButton(title: month, index: index)
            monthFilterStackView.addArrangedSubview(button)
        }
        
        updateMonthSelection(selectedIndex: nil)
    }
    
    private func createMonthButton(title: String, index: Int) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .Brimo.Body.smallRegular
        button.setTitleColor(.Brimo.Black.main, for: .normal)
        button.setTitleColor(.Brimo.Primary.main, for: .selected)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 16
        button.tag = index
        button.addTarget(self, action: #selector(monthButtonTapped(_:)), for: .touchUpInside)
        
        button.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.height.equalTo(32)
        }
        
        return button
    }
    
    @objc private func monthButtonTapped(_ sender: UIButton) {
        let tappedIndex = sender.tag
        
        if selectedMonthIndex == tappedIndex {
            selectedMonthIndex = nil
        } else {
            selectedMonthIndex = tappedIndex
        }
        
        updateMonthSelection(selectedIndex: selectedMonthIndex)
        filterDataByMonth()
    }
    
    private func updateMonthSelection(selectedIndex: Int?) {
        for (index, view) in monthFilterStackView.arrangedSubviews.enumerated() {
            if let button = view as? UIButton {
                let isSelected = (selectedIndex == index)
                button.isSelected = isSelected
                if isSelected {
                    button.backgroundColor = ConstantsColor.primary100
                } else {
                    button.backgroundColor = .clear
                }
            }
        }
    }
    
    private func filterDataByMonth() {
        if let selectedIndex = selectedMonthIndex {
            let selectedMonth = selectedIndex + 1
            
            mutasiData = allMutasiData.filter { model in
                let calendar = Calendar.current
                let month = calendar.component(.month, from: model.tanggalMutasi)
                return month == selectedMonth
            }
        } else {
            mutasiData = allMutasiData
        }
        
        let isEmpty = mutasiData.isEmpty
        emptyStateView.isHidden = !isEmpty
        collectionView.isHidden = isEmpty
        
        collectionView.reloadData()
    }
    
    func configureData(data: [RiwayatMutasiModel]) {
        allMutasiData = data
        filterDataByMonth()
    }
}

extension MutasiViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return mutasiData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mutasiData[section].riwayatMutasiItemModel.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let mutasi = mutasiData[indexPath.section]
        
        if indexPath.item == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RiwayatMutasiDateHeaderView", for: indexPath) as? RiwayatMutasiDateHeaderView else {
                return UICollectionViewCell()
            }
            
            cell.configure(with: mutasi.tanggalMutasi)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RiwayatMutasiCellView", for: indexPath) as? RiwayatMutasiCellView else {
                return UICollectionViewCell()
            }
            
            let transaction = mutasi.riwayatMutasiItemModel[indexPath.item - 1]
            let isLastItem = indexPath.item == mutasi.riwayatMutasiItemModel.count
            cell.configure(with: transaction, isLastIndex: isLastItem)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        
        if indexPath.item == 0 {
            return CGSize(width: width, height: 60)
        } else {
            return CGSize(width: width, height: 80)
        }
    }
}
