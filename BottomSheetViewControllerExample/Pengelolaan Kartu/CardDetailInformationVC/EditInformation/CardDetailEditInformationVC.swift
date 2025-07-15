//
//  CardDetailEditInformationVC.swift
//  BottomSheetViewControllerExample
//
//  Created by Phincon on 08/07/25.
//

import UIKit
import SnapKit

class CardDetailEditInformationVC: UIViewController, UITextFieldDelegate {

    // MARK: - UI Components

    private let backgroundContainerView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "background_blue_secondary")
        return img
    }()

    private lazy var roundBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = ConstantsColor.white900
        return view
    }()

    private lazy var aliasField: FormFieldInformationView = {
        let field = FormFieldInformationView()
        field.titleLabel.text = "Nama Alias"
        field.placeholderText = "Nama Alias"
        field.setError("Wajib diisi minimal 5 karakter")
        return field
    }()

    private lazy var backgroundBtnView: UIView = {
        let view = UIView()
        view.backgroundColor = ConstantsColor.white900
        return view
    }()

    private lazy var separatorBtnView: UIView = {
        let view = UIView()
        view.backgroundColor = .Brimo.Black.x300
        return view
    }()

    private lazy var saveBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .Brimo.Primary.main
        btn.setTitleColor(ConstantsColor.white900, for: .normal)
        btn.setTitle("Simpan", for: .normal)
        btn.titleLabel?.font = .Brimo.Title.smallSemiBold
        btn.layer.cornerRadius = 28
        return btn
    }()

    // MARK: - Constraint

    private var bottomButtonConstraint: Constraint?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupLayout()
        aliasField.textField.delegate = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        roundBackgroundView.roundCorners(corners: [.topLeft, .topRight], radius: 24)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Edit Nama Alias"
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleKeyboard),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        aliasField.textField.resignFirstResponder()
    }

    // MARK: - Setup

    private func setupView() {
        view.addSubviews(backgroundContainerView, roundBackgroundView)
        roundBackgroundView.addSubviews(aliasField, backgroundBtnView)
        backgroundBtnView.addSubviews(separatorBtnView, saveBtn)
    }

    private func setupLayout() {
        backgroundContainerView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }

        roundBackgroundView.snp.remakeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        aliasField.snp.remakeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        backgroundBtnView.snp.remakeConstraints {
            $0.leading.trailing.equalToSuperview()
            bottomButtonConstraint = $0.bottom.equalTo(view.safeAreaLayoutGuide).constraint
            $0.height.equalTo(96)
        }

        separatorBtnView.snp.remakeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
            $0.bottom.equalTo(backgroundBtnView.snp.top)
        }

        saveBtn.snp.remakeConstraints {
            $0.leading.top.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(56)
        }
    }

    // MARK: - Keyboard Handling

    @objc private func handleKeyboard(notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let endFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
            let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
            let curveRaw = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt
        else {
            return
        }

        let convertedFrame = view.convert(endFrame, from: nil)
        let isKeyboardVisible = convertedFrame.origin.y < UIScreen.main.bounds.height
        let bottomInset = isKeyboardVisible ? convertedFrame.height - view.safeAreaInsets.bottom : 0

        bottomButtonConstraint?.update(offset: -bottomInset)

        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: UIView.AnimationOptions(rawValue: curveRaw << 16),
            animations: {
                self.view.layoutIfNeeded()
            }
        )
    }
}
