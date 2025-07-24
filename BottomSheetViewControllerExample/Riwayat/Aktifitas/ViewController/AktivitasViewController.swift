//
//  AktivitasViewController.swift
//  BottomSheetViewControllerExample
//
//  Created by sia santos on 17/07/25.
//

import UIKit
import SnapKit

final class AktivitasViewController: UIViewController {
    
    private let listActivityView: AccountCardDetailManagerActivityView = AccountCardDetailManagerActivityView(
        isShowBorder: true
    )
    
    private let headerTitle: ActivityFilterHeaderView = ActivityFilterHeaderView()
    
    private var isActivityLoading: Bool = false {
        didSet {
            listActivityView.isLoading = isActivityLoading
            headerTitle.isLoading = isActivityLoading
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupView()
        setupConstraint()
    }
    
    private func setupView() {
        listActivityView.onItemSelected = listActivityItemSelected
        headerTitle.updateTitle("Aktivitas Qitta")
        view.addSubviews(headerTitle, listActivityView)
    }
    
    private func setupConstraint() {
        headerTitle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.trailing.leading.equalToSuperview()
        }
        
        listActivityView.snp.makeConstraints {
            $0.top.equalTo(headerTitle.snp.bottom).offset(8)
            $0.trailing.leading.bottom.equalToSuperview()
        }
    }
    
    private func listActivityItemSelected(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}
