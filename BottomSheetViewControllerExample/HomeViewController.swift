//
//  HomeViewController.swift
//  BottomSheetViewControllerExample
//
//  Created by Mohd Hafiz on 04/06/2023.
//

import UIKit

class HomeViewController: UIViewController {
    // MARK: - Properties
    private var settings = PageSettings()

    // MARK: - UI
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var showBottomSheetButton: UIButton = {
        let button = UIButton()
        button.setTitle("Show Bottom Sheet", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 54).isActive = true
        return button
    }()
    
    private lazy var showBottomSheetSearchView: UIButton = {
        let button = UIButton()
        button.setTitle("Show Bottom Search View", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 54).isActive = true
        return button
    }()
    
    private lazy var showConfirmationAccountRek: UIButton = {
        let button = UIButton()
        button.setTitle("Konfirmasi Setoran", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 54).isActive = true
        return button
    }()
    
    private lazy var showPinBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Show Pin View", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 54).isActive = true
        return button
    }()
    
    private lazy var expandedBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Expand Button", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 54).isActive = true
        return button
    }()
    
    private lazy var setoranAwal: UIButton = {
        let button = UIButton()
        button.setTitle("Setoran Awal", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 54).isActive = true
        return button
    }()
    
    private lazy var riwayat: UIButton = {
        let button = UIButton()
        button.setTitle("Riwayat", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 54).isActive = true
        return button
    }()
    
    private lazy var longTextSwitch: UISwitch = {
        let view = UISwitch()
        return view
    }()

    private lazy var longTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Long text"
        return label
    }()

    private lazy var longTextOptionStackView: UIStackView = {
        let view = UIStackView()
        view.spacing = 16
        return view
    }()

    private lazy var hasImageSwitch: UISwitch = {
        let view = UISwitch()
        return view
    }()
    
    private lazy var hasImageLabel: UILabel = {
        let label = UILabel()
        label.text = "Has Image"
        return label
    }()
    
    private lazy var hasImageOptionStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = 16
        return view
    }()

    // MARK: - Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupAction()
    }

    private func setupView() {
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    
        stackView.addArrangedSubview(longTextOptionStackView)
        stackView.addArrangedSubview(hasImageOptionStackView)
        stackView.addArrangedSubview(showBottomSheetButton)
        stackView.addArrangedSubview(showBottomSheetSearchView)
        stackView.addArrangedSubview(showConfirmationAccountRek)
        stackView.addArrangedSubview(showPinBtn)
        stackView.addArrangedSubview(expandedBtn)
        stackView.addArrangedSubview(setoranAwal)
        stackView.addArrangedSubview(riwayat)
    
        hasImageOptionStackView.addArrangedSubview(hasImageSwitch)
        hasImageOptionStackView.addArrangedSubview(hasImageLabel)
    
        longTextOptionStackView.addArrangedSubview(longTextSwitch)
        longTextOptionStackView.addArrangedSubview(longTextLabel)
    }

    // MARK: - Actions
    private func setupAction() {
        longTextSwitch.addTarget(self, action: #selector(handleLongTextSwitch), for: .valueChanged)
        hasImageSwitch.addTarget(self, action: #selector(handleHasImageSwitch), for: .valueChanged)
        showBottomSheetButton.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)
        showBottomSheetSearchView.addTarget(self, action: #selector(showBottomSheetSearchTap), for: .touchUpInside)
        showConfirmationAccountRek.addTarget(self, action: #selector(showKonfirmasiScreen), for: .touchUpInside)
        expandedBtn.addTarget(self, action: #selector(expandableText), for: .touchUpInside)
        showPinBtn.addTarget(self, action: #selector(showPinView), for: .touchUpInside)
        setoranAwal.addTarget(self, action: #selector(showSetoranAwal), for: .touchUpInside)
        riwayat.addTarget(self, action: #selector(showRiwayatPage), for: .touchUpInside)
    }

    @objc private func handleLongTextSwitch() {
        settings.longText = longTextSwitch.isOn
    }

    @objc private func handleHasImageSwitch() {
        settings.hasImage = hasImageSwitch.isOn
    }

    @objc private func handleButtonTap() {
        let vc = DemoBottomSheetViewController(settings: settings)
        presentBrimonsBottomSheet(viewController: vc)
    }
    
    @objc private func showBottomSheetSearchTap(){
        let vc = AccountOpeningBranchSearchVC()
        presentBrimonsBottomSheet(viewController: vc)
    }
    
    @objc private func showKonfirmasiScreen(){
        let vc = AccountOpeningDepositConfirmationVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func expandableText(){
        let vc = AccountOpeningCompleteViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func showPinView(){
        let vc = AccountOpeningPinViewVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func showRiwayatPage(){
        let vc = RiwayatViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func showSetoranAwal(){
//        let vc = SetoranAwalViewController()
//        navigationController?.pushViewController(vc, animated: true)
//        let vc = SkeletonViewController()
//        navigationController?.pushViewController(vc, animated: true)
        
//        let vc = AccountListViewController()
//        presentBrimonsBottomSheet(viewController: vc)
        
        
        //slicing new ui
        let vc = CardDetailManagerVC()
        navigationController?.pushViewController(vc, animated: true)
        
//        let vc = CardDetailInformationVC()
//        navigationController?.pushViewController(vc, animated: true)
    }
}
