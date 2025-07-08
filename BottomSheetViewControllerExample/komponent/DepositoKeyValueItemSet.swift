//
//  DepositoKeyValueItemSet.swift
//  BottomSheetViewControllerExample
//
//  Created by PT Diksha Teknologi Indonesia on 05/07/25.
//


import UIKit

struct DepositoKeyValueItemSet {
    let key: String
    let value: String
    let keyValueStyle: DepositoKeyValueStyle
    let showSeparator: Bool
}

enum DepositoKeyValueStyle {
    case keyOnlyAsTitle
    case valueRed
    case valueGreen
    case none
}

class KeyValueComponentView: UIView {

    private let stackView = UIStackView()
    private let titleLabel = UILabel()
    private let toggleButton = UIButton(type: .system)
    private var allItemViews: [UIView] = []
    private var isExpanded = false
    private var isToggleable = false
    private var compactVisibleRows = 3
    private var addBRIDescription = false
    private var descHeading = ""
    private var descContent = ""
    private var toggleTextShow = ""
    private var toggleTextHide = ""
    private var items: [DepositoKeyValueItemSet] = []

    init(
        items: [DepositoKeyValueItemSet],
        title: String? = nil,
        isToggleable: Bool = false,
        toggleTextShow: String = "Lihat Lebih",
        toggleTextHide: String = "Sembunyikan",
        compactVisibleRows: Int = 3,
        addBRIDescription: Bool = false,
        descHeading: String = "",
        descContent: String = ""
    ) {
        super.init(frame: .zero)
        self.items = items
        self.isToggleable = isToggleable
        self.toggleTextShow = toggleTextShow
        self.toggleTextHide = toggleTextHide
        self.compactVisibleRows = compactVisibleRows
        self.addBRIDescription = addBRIDescription
        self.descHeading = descHeading
        self.descContent = descContent
        setupView()
        configure(title: title, items: items)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupView() {
        backgroundColor = .systemGray6
        layer.cornerRadius = 16
        clipsToBounds = true

        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
    }

    private func configure(title: String?, items: [DepositoKeyValueItemSet]) {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        allItemViews.removeAll()

        if let title = title {
            titleLabel.text = title
            titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
            titleLabel.textColor = .label
            titleLabel.numberOfLines = 0
            titleLabel.setContentHuggingPriority(.required, for: .vertical)
            stackView.addArrangedSubview(titleLabel)
        }

        for item in items {
            let row = createRow(item: item)
            allItemViews.append(row)

            if item.showSeparator {
                let separator = UIView()
                separator.backgroundColor = .systemGray4
                separator.translatesAutoresizingMaskIntoConstraints = false
                separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
                allItemViews.append(separator)
            }
        }

        if addBRIDescription {
            let footer = createDescription(heading: descHeading, content: descContent)
            allItemViews.append(footer)
        }

        applyCollapseState()

        if isToggleable && items.count > compactVisibleRows {
            toggleButton.setTitle(toggleTextShow, for: .normal)
            toggleButton.setTitleColor(.systemBlue, for: .normal)
            toggleButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            toggleButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
            toggleButton.semanticContentAttribute = .forceRightToLeft
            toggleButton.addTarget(self, action: #selector(toggleExpanded), for: .touchUpInside)
            stackView.addArrangedSubview(toggleButton)
        }
    }

    private func applyCollapseState() {
        allItemViews.forEach {
            stackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }

        let viewsToShow: [UIView]
        if isExpanded || !isToggleable {
            viewsToShow = allItemViews
        } else {
            viewsToShow = Array(allItemViews.prefix(compactVisibleRows))
        }

        for view in viewsToShow {
            stackView.insertArrangedSubview(view, at: stackView.arrangedSubviews.count - (stackView.arrangedSubviews.contains(toggleButton) ? 1 : 0))
        }

        if isToggleable {
            toggleButton.setTitle(isExpanded ? toggleTextHide : toggleTextShow, for: .normal)
            let icon = UIImage(systemName: isExpanded ? "chevron.up" : "chevron.down")
            toggleButton.setImage(icon, for: .normal)
        }
    }

    @objc
    private func toggleExpanded() {
        isExpanded.toggle()

        UIView.performWithoutAnimation {
            applyCollapseState()
            self.layoutIfNeeded()
        }

        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }

    private func createDescription(heading: String, content: String) -> UIView {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 8
        container.alignment = .center

        let headingLabel = UILabel()
        headingLabel.text = heading
        headingLabel.font = UIFont.systemFont(ofSize: 13)
        headingLabel.textColor = .darkGray
        headingLabel.textAlignment = .center
        headingLabel.numberOfLines = 0

        let contentLabel = UILabel()
        contentLabel.text = content
        contentLabel.font = UIFont.systemFont(ofSize: 13)
        contentLabel.textColor = .darkGray
        contentLabel.textAlignment = .center
        contentLabel.numberOfLines = 0

        container.addArrangedSubview(headingLabel)
        container.addArrangedSubview(contentLabel)

        return container
    }

    private func createRow(item: DepositoKeyValueItemSet) -> UIView {
        let container = UIStackView()
        container.axis = .horizontal
        container.spacing = 8
        container.alignment = .center
        container.distribution = .fill

        let keyLabel = UILabel()
        keyLabel.text = item.key
        keyLabel.font = item.keyValueStyle == .keyOnlyAsTitle ? .boldSystemFont(ofSize: 14) : .systemFont(ofSize: 14)
        keyLabel.textColor = item.keyValueStyle == .keyOnlyAsTitle ? .label : .secondaryLabel
        keyLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)

        let valueLabel = UILabel()
        valueLabel.text = item.value
        valueLabel.font = .systemFont(ofSize: 14)
        valueLabel.textAlignment = .right
        valueLabel.textColor = {
            switch item.keyValueStyle {
            case .valueGreen:
                return .systemGreen
            case .valueRed:
                return .systemRed
            default:
                return .label
            }
        }()
        valueLabel.setContentHuggingPriority(.required, for: .horizontal)

        container.addArrangedSubview(keyLabel)
        container.addArrangedSubview(valueLabel)

        return container
    }
}
