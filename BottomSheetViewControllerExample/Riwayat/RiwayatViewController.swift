//
//  RiwayatViewController.swift
//  BottomSheetViewControllerExample
//
//  Created by sia santos on 17/07/25.
//

import UIKit
import SnapKit

final class RiwayatViewController: UIViewController {
    private enum Tab: Int {
        case mutasi = 0
        case aktivitas = 1
        case estatement = 2
    }
    
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
    
    private let tabContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var tabStackView: UIStackView = {
        let spacer: UIView = UIView()
        spacer.setContentHuggingPriority(.defaultLow, for: .horizontal)
        let stack: UIStackView = UIStackView(arrangedSubviews: [mutasiButton, aktivitasButton, eStatementButton, spacer])
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .leading
        stack.spacing = 16
        return stack
    }()
    
    private let aktivitasButton: UIButton = {
        let button = UIButton()
        button.setTitle("Aktivitas", for: .normal)
        button.titleLabel?.font = UIFont.Brimo.Title.smallSemiBold
        button.backgroundColor = .clear
        button.setTitleColor(UIColor.Brimo.Black.x600, for: .normal)
        button.setTitleColor(UIColor.Brimo.Primary.main, for: .selected)
        return button
    }()
    
    private let mutasiButton: UIButton = {
        let button = UIButton()
        button.setTitle("Mutasi", for: .normal)
        button.titleLabel?.font = UIFont.Brimo.Title.smallSemiBold
        button.backgroundColor = .clear
        button.setTitleColor(UIColor.Brimo.Black.x600, for: .normal)
        button.setTitleColor(UIColor.Brimo.Primary.main, for: .selected)
        return button
    }()
    
    private let eStatementButton: UIButton = {
        let button = UIButton()
        button.setTitle("e-Statement", for: .normal)
        button.titleLabel?.font = UIFont.Brimo.Title.smallSemiBold
        button.backgroundColor = .clear
        button.setTitleColor(UIColor.Brimo.Black.x600, for: .normal)
        button.setTitleColor(UIColor.Brimo.Primary.main, for: .selected)
        return button
    }()
    
    private let activeIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.Brimo.Primary.main
        view.layer.cornerRadius = 1.5
        return view
    }()
        
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.94, green: 0.94, blue: 0.96, alpha: 1.0)
        return view
    }()
    
    private var buttons: [UIButton]!
    
    private let contentContainer = UIView()
    
    private var currentSelectedIndex = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttons = [
            mutasiButton,
            aktivitasButton,
            eStatementButton
        ]
        setupView()
        setupConstraint()
        setupActions()
        switchToTab(index: .mutasi)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Riwayat"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        roundBackgroundView.roundCorners(corners: [.topLeft, .topRight], radius: 24)
        updateActiveIndicator()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        view.addSubviews(backgroundContainerView, roundBackgroundView)
        roundBackgroundView.addSubviews(tabContainerView, contentContainer)
        tabContainerView.addSubviews(tabStackView, separatorView, activeIndicator)
    }
    
    private func setupConstraint() {
        backgroundContainerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        roundBackgroundView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        tabContainerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }

        tabStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }

        buttons.forEach { button in
            button.contentEdgeInsets = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
            button.clipsToBounds = true
        }

        activeIndicator.snp.makeConstraints {
            $0.height.equalTo(3)
            $0.bottom.equalToSuperview()
            $0.width.equalTo(50)
            $0.leading.equalToSuperview().offset(16)
        }

        separatorView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }

        contentContainer.snp.makeConstraints {
            $0.top.equalTo(tabContainerView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupActions() {
        aktivitasButton.addTarget(self, action: #selector(aktivitasTapped), for: .touchUpInside)
        mutasiButton.addTarget(self, action: #selector(mutasiTapped), for: .touchUpInside)
        eStatementButton.addTarget(self, action: #selector(eStatementTapped), for: .touchUpInside)
    }
    
    @objc private func mutasiTapped() {
        switchToTab(index: Tab.mutasi)
    }
    
    @objc private func aktivitasTapped() {
        switchToTab(index: Tab.aktivitas)
    }
    
    @objc private func eStatementTapped() {
        switchToTab(index: Tab.estatement)
    }
    
    private func switchToTab(index: Tab) {
        currentSelectedIndex = index.rawValue
        
        let childVC: UIViewController
        switch index {
        case .mutasi:
            // TODO: Santos - Remove Mock and Replace With Actual Data
            let mockData = RiwayatMutasiMockData().loadSampleData()
            let sortedData = mockData.sorted {
                $0.tanggalMutasi < $1.tanggalMutasi
            }
            
            let mutasiVC = MutasiViewController()
            
            mutasiVC.onTapFilter = {[weak self] in
                guard let self = self else {
                    return
                }
                
                let filterVC = RiwayatMutasiFilterViewController()
                
                filterVC.onFilterApplied = {[weak self] (selectedStartDate, selectedEndDate, selectedAccount, selectedTransactionType) in
                    
                    mutasiVC.filterDataBy(startDate: selectedStartDate, endDate: selectedEndDate)
                }
                
                navigationController?.pushViewController(filterVC, animated: true)
            }
            
            mutasiVC.configureData(data: sortedData)
            
            childVC = mutasiVC
        case .aktivitas:
            childVC = AktivitasViewController()
        case .estatement:
            childVC = EStatementViewController()
        }
        
        for view in contentContainer.subviews {
            view.removeFromSuperview()
        }
        
        for child in children {
            child.removeFromParent()
        }
        
        addChild(childVC)
        contentContainer.addSubview(childVC.view)
        
        childVC.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        childVC.didMove(toParent: self)
        highlightTab(index: index.rawValue)
        updateActiveIndicator()
    }
    
    private func highlightTab(index: Int) {
        for (i, btn) in buttons.enumerated() {
            btn.isSelected = (i == index)
            if i == index {
                btn.titleLabel?.font = UIFont.Brimo.Title.smallSemiBold
            } else {
                btn.titleLabel?.font = UIFont.Brimo.Title.smallRegular
            }
        }
    }
    
    private func updateActiveIndicator() {
        guard currentSelectedIndex < 3 else { return }
        let selectedButton = buttons[currentSelectedIndex]
        
        tabStackView.layoutIfNeeded()
        
        let buttonFrame = selectedButton.convert(selectedButton.bounds, to: tabContainerView)
        let textSize = selectedButton.titleLabel?.intrinsicContentSize ?? CGSize.zero
        let indicatorWidth = textSize.width
        let indicatorX = buttonFrame.minX + (buttonFrame.width - indicatorWidth) / 2
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            self.activeIndicator.snp.updateConstraints { make in
                make.leading.equalToSuperview().offset(indicatorX)
                make.width.equalTo(indicatorWidth)
            }
            self.tabContainerView.layoutIfNeeded()
        }
    }
}
