//
//  CustomNumberKeyboard.swift
//  BottomSheetViewControllerExample
//
//  Created by PT Diksha Teknologi Indonesia on 29/06/25.
//


import UIKit
import SnapKit

protocol CustomNumberKeyboardDelegate: AnyObject {
    func customKeyboardDidTap(number: String)
    func customKeyboardDidTapDelete()
}

class CustomNumberKeyboard: UIView {

    weak var delegate: CustomNumberKeyboardDelegate?

    private let buttons: [[String]] = [
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["7", "8", "9"],
        ["0", "000", "⌫"]
    ]

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        let mainStack = UIStackView()
        mainStack.axis = .vertical
        mainStack.spacing = 8 // vertical spacing
        mainStack.alignment = .center // center rowStack
        mainStack.translatesAutoresizingMaskIntoConstraints = false

        for row in buttons {
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.spacing = 12 // horizontal spacing
            rowStack.alignment = .center

            for title in row {
                let button = UIButton(type: .system)
                button.setTitle(title, for: .normal)
                button.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
                button.layer.cornerRadius = 8
                button.setTitleColor(.black, for: .normal)
                button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)

                // ✅ Hanya tombol "⌫" tanpa background
                if title == "⌫" {
                    button.backgroundColor = .clear
                } else {
                    button.backgroundColor = .lightGray
                }

                button.snp.makeConstraints { make in
                    make.width.equalTo(106)
                    make.height.equalTo(52)
                }

                rowStack.addArrangedSubview(button)
            }

            mainStack.addArrangedSubview(rowStack)
        }

        addSubview(mainStack)

        mainStack.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.lessThanOrEqualTo(self.safeAreaLayoutGuide).inset(16)
        }
    }

    @objc private func buttonTapped(_ sender: UIButton) {
        guard let title = sender.currentTitle else { return }

        if title == "⌫" {
            delegate?.customKeyboardDidTapDelete()
        } else {
            delegate?.customKeyboardDidTap(number: title)
        }
    }
}
