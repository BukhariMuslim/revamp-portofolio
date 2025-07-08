//
//  InitialDepositDetailView.swift
//  BottomSheetViewControllerExample
//
//  Created by PT Diksha Teknologi Indonesia on 28/06/25.
//

import UIKit
import SnapKit

class InitialDepositDetailView: UIView {

    // MARK: - UI Components

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Detail Setoran Awal"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()

    private let backgroundContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()

    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()

    // MARK: - State

    private var dataItems: [(title: String, desc: String)] = []
    private var itemViews: [UIView] = []

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupLayout()
    }

    // MARK: - Setup

    private func setupView() {
        backgroundColor = .white
        addSubview(backgroundContainerView)
        backgroundContainerView.addSubview(titleLabel)
        backgroundContainerView.addSubview(verticalStackView)
    }

    private func setupLayout() {
        titleLabel.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview().inset(16)
        }

        backgroundContainerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        verticalStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.bottom.equalToSuperview().inset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }

    // MARK: - Configure Data

    func configure(with data: [(title: String, desc: String)]) {
        dataItems = data
        rebuildStackView(from: data)
    }

    // MARK: - Collapse/Expand Animations

    func collapseToFirstFourItemsAnimated() {
        guard !dataItems.isEmpty else { return }

        let collapsedItems = Array(dataItems.prefix(4)) // ambil 4 item pertama

        UIView.transition(with: verticalStackView, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.rebuildStackView(from: collapsedItems)
        }, completion: nil)
    }

    func expandAllItemsAnimated() {
        guard dataItems.count > 4 else { return } // gak perlu expand kalau semua udah ditampilkan

        UIView.transition(with: verticalStackView, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.rebuildStackView(from: self.dataItems)
        }, completion: nil)
    }


    // MARK: - Helpers

    private func rebuildStackView(from items: [(title: String, desc: String)]) {
        // Clear existing views
        verticalStackView.arrangedSubviews.forEach {
            verticalStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }

        itemViews = []

        for item in items {
            let hStack = UIStackView()
            hStack.axis = .horizontal
            hStack.spacing = 8
            hStack.alignment = .top
            hStack.distribution = .fill

            let titleLabel = UILabel()
            titleLabel.text = item.title
            titleLabel.font = .systemFont(ofSize: 14, weight: .regular)
            titleLabel.textColor = .label
            titleLabel.numberOfLines = 1
            titleLabel.setContentHuggingPriority(.required, for: .horizontal)

            let descLabel = UILabel()
            descLabel.text = item.desc
            descLabel.font = .systemFont(ofSize: 14, weight: .semibold)
            descLabel.textColor = .label
            descLabel.numberOfLines = 0
            descLabel.textAlignment = .right
            descLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

            hStack.addArrangedSubview(titleLabel)
            hStack.addArrangedSubview(descLabel)

            verticalStackView.addArrangedSubview(hStack)
            itemViews.append(hStack)
        }
    }
}
