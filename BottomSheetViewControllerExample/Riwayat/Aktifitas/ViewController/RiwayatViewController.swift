import UIKit
import SnapKit

final class RiwayatViewController: UIViewController {
    
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
        let stack = UIStackView(arrangedSubviews: [aktivitasButton, mutasiButton, eStatementButton])
        stack.axis = .horizontal
        stack.distribution = .fill
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
    
    private let contentContainer = UIView()
    
    private var currentSelectedIndex = 1 // Mutasi selected by default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraint()
        setupActions()
        switchToTab(index: 1)
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
        tabContainerView.addSubviews(tabStackView, activeIndicator)
    }
    
    private func setupConstraint() {
        backgroundContainerView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
        
        roundBackgroundView.snp.remakeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        tabContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(60)
        }
        
        tabStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.lessThanOrEqualToSuperview().offset(-16)
        }
        
        [aktivitasButton, mutasiButton, eStatementButton].forEach { button in
            button.contentEdgeInsets = UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16)
            button.clipsToBounds = true
        }
        
        activeIndicator.snp.makeConstraints { make in
            make.height.equalTo(3)
            make.bottom.equalToSuperview()
            make.width.equalTo(50)
            make.leading.equalToSuperview().offset(16)
        }
        
        contentContainer.snp.makeConstraints { make in
            make.top.equalTo(tabContainerView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupActions() {
        aktivitasButton.addTarget(self, action: #selector(aktivitasTapped), for: .touchUpInside)
        mutasiButton.addTarget(self, action: #selector(mutasiTapped), for: .touchUpInside)
        eStatementButton.addTarget(self, action: #selector(eStatementTapped), for: .touchUpInside)
    }
    
    @objc private func aktivitasTapped() {
        switchToTab(index: 0)
    }
    
    @objc private func mutasiTapped() {
        switchToTab(index: 1)
    }
    
    @objc private func eStatementTapped() {
        switchToTab(index: 2)
    }
    
    private func switchToTab(index: Int) {
        currentSelectedIndex = index
        
        let childVC: UIViewController
        switch index {
        case 0:
            childVC = AktivitasViewController()
        case 1:
            childVC = MutasiViewController()
        case 2:
            childVC = EStatementViewController()
        default:
            return
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
        highlightTab(index: index)
        updateActiveIndicator()
    }
    
    private func highlightTab(index: Int) {
        let buttons = [aktivitasButton, mutasiButton, eStatementButton]
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
        
        let buttons = [aktivitasButton, mutasiButton, eStatementButton]
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
