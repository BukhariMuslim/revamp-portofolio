//
//  KeyValueComponentView.swift
//  brimo-native
//
//  Created by user on 20/06/25.
//  Copyright © 2025 BRImo. All rights reserved.
//

import UIKit

struct DepositoKeyValueItemSet {
    let key: String
    let value: String
    let keyValueStyle: DepositoKeyValueStyle
    let showSeparator: Bool
}

enum DepositoKeyValueStyle: String {
    case keyOnlyAsTitle
    case valueRed
    case valueGreen
    case none // default font & color for key/value
}

class KeyValueComponentView: UIView {
    private let stackView: UIStackView = UIStackView()
    private let titleLabel: UILabel = UILabel()
    private let toggleButton: UIButton = UIButton(type: .system)
    private let briDescStackView: UIStackView = UIStackView()
    
    private var allItemViews: [UIView] = []
    private var isExpanded: Bool = false
    private var isToggleable: Bool = false
    private var compactVisibleRows: Int = 3
    private var addBRIDescription: Bool = true
    private var descHeading: String = ""
    private var descContent: String = ""
    private var toggleTextShow: String = ""
    private var toggleTextHide: String = ""
    private var items: [DepositoKeyValueItemSet] = []
    
    init(
        items: [DepositoKeyValueItemSet],
        title: String?,
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
        backgroundColor = .Brimo.White.light20
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
            titleLabel.font = .Brimo.Body.largeSemiBold
            titleLabel.textColor = ConstantsColor.black900
            titleLabel.numberOfLines = 0
            titleLabel.setContentHuggingPriority(.required, for: .vertical)
            stackView.addArrangedSubview(titleLabel)
        }
        
        for (_, item) in items.enumerated() {
            let row = createRow(item: item)
            allItemViews.append(row)
            
            if item.showSeparator {
                let separatorWrapper = UIView()
                separatorWrapper.translatesAutoresizingMaskIntoConstraints = false
                
                let separator = UIView()
                separator.backgroundColor = .Brimo.Black.x300
                separator.translatesAutoresizingMaskIntoConstraints = false
                
                separatorWrapper.addSubview(separator)
                
                NSLayoutConstraint.activate([
                    separator.leadingAnchor.constraint(equalTo: separatorWrapper.leadingAnchor),
                    separator.trailingAnchor.constraint(equalTo: separatorWrapper.trailingAnchor),
                    separator.topAnchor.constraint(equalTo: separatorWrapper.topAnchor),
                    separator.bottomAnchor.constraint(equalTo: separatorWrapper.bottomAnchor),
                    separator.heightAnchor.constraint(equalToConstant: 1)
                ])
                
                allItemViews.append(separatorWrapper)
            }
        }
        
        if addBRIDescription {
            let footer = createDescription(heading: descHeading, content: descContent)
            allItemViews.append(footer)
        }
        
        applyCollapseState()
        
        if isToggleable && items.count > compactVisibleRows {
            
            if #available(iOS 15.0, *) {
                var buttonConfig = UIButton.Configuration.plain()
                
                var titleAttrString = AttributedString(toggleTextShow)
                titleAttrString.font = .Brimo.Body.mediumSemiBold
                
                buttonConfig.attributedTitle = titleAttrString
                buttonConfig.image = UIImage(named: "arrows/chevron_down")
                buttonConfig.imagePlacement = .trailing
                buttonConfig.imagePadding = 4
                buttonConfig.baseForegroundColor = .Brimo.Primary.main
                
                toggleButton.configuration = buttonConfig
                toggleButton.addTarget(self, action: #selector(toggleExpanded), for: .touchUpInside)
                stackView.addArrangedSubview(toggleButton)
            } else {
                // Fallback on earlier versions
            }
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
            if #available(iOS 15.0, *) {
                var newButtonConfig = toggleButton.configuration
                
                var titleAttrString = AttributedString(isExpanded ? toggleTextHide : toggleTextShow)
                titleAttrString.font = .Brimo.Body.mediumSemiBold
                
                newButtonConfig?.baseForegroundColor = .Brimo.Primary.main
                newButtonConfig?.attributedTitle = titleAttrString
                newButtonConfig?.image = isExpanded ? UIImage(
                    named: "arrows/chevron_up"
                ) : UIImage(
                    named: "arrows/chevron_down"
                )
                toggleButton.configuration = newButtonConfig
            }
        }
    }
    
    @objc
    private func toggleExpanded() {
        isExpanded.toggle()
        
        UIView.performWithoutAnimation {
            applyCollapseState()
            self.layoutIfNeeded()
        }
        
        UIView.animate(withDuration: 0.5) {
            self.layoutIfNeeded()
        }
    }
    
    private func createDescription(heading: String, content: String) -> UIView {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 16
        container.alignment = .center
        container.distribution = .fill
        
        let headingLabel = UILabel()
        headingLabel.text = heading
        headingLabel.textAlignment = .center
        headingLabel.font = .Brimo.Body.mediumRegular
        headingLabel.textColor = ConstantsColor.black500
        headingLabel.numberOfLines = 0
        
        let contentLabel = UILabel()
        contentLabel.text = content
        contentLabel.textAlignment = .center
        contentLabel.font = .Brimo.Body.mediumRegular
        contentLabel.textColor = ConstantsColor.black500
        contentLabel.numberOfLines = 0
        
        container.addArrangedSubview(headingLabel)
        container.addArrangedSubview(contentLabel)
        
        let columnContainer = UIView()
        columnContainer.translatesAutoresizingMaskIntoConstraints = false
        container.translatesAutoresizingMaskIntoConstraints = false
        columnContainer.addSubview(container)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: columnContainer.topAnchor),
            container.bottomAnchor.constraint(equalTo: columnContainer.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: columnContainer.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: columnContainer.trailingAnchor)
        ])
        
        return columnContainer
    }
    
    private func createRow(item: DepositoKeyValueItemSet) -> UIView {
        let container = UIStackView()
        container.axis = .horizontal
        container.spacing = 8
        container.alignment = .center
        container.distribution = .fill
        
        let keyLabel = UILabel()
        keyLabel.text = item.key
        keyLabel.font = item.keyValueStyle != .keyOnlyAsTitle ? .Brimo.Body.mediumRegular : .Brimo.Body.mediumSemiBold
        keyLabel.textColor = item.keyValueStyle != .keyOnlyAsTitle ? ConstantsColor.black500 : ConstantsColor.black900
        keyLabel.numberOfLines = 1
        keyLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        let valueLabel = UILabel()
        valueLabel.text = item.value
        valueLabel.font = .Brimo.Body.mediumRegular
        valueLabel.textColor = {
            switch item.keyValueStyle {
            case .valueGreen:
                return .Brimo.Green.main
                
            case .valueRed:
                return .Brimo.Red.main
                
            default:
                return .Brimo.Black.main
            }
        }()
        valueLabel.textAlignment = .right
        valueLabel.numberOfLines = 1
        valueLabel.setContentHuggingPriority(.required, for: .horizontal)
        
        container.addArrangedSubview(keyLabel)
        container.addArrangedSubview(valueLabel)
        
        let rowContainer = UIView()
        rowContainer.translatesAutoresizingMaskIntoConstraints = false
        container.translatesAutoresizingMaskIntoConstraints = false
        rowContainer.addSubview(container)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: rowContainer.topAnchor),
            container.bottomAnchor.constraint(equalTo: rowContainer.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: rowContainer.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: rowContainer.trailingAnchor),
            rowContainer.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        return rowContainer
    }
}
