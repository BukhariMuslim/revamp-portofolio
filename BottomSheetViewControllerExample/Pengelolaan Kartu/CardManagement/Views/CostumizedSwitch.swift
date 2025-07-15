import UIKit
import SnapKit

class CustomSizedSwitch: UIControl {
    private let switchControl: UISwitch = {
        let uiSwitch = UISwitch()
        return uiSwitch
    }()

    private let switchScale: CGFloat

    var isOn: Bool {
        get { switchControl.isOn }
        set { switchControl.setOn(newValue, animated: true) }
    }
    
    var disableBehavior: Bool = true {
        didSet {
            setSwitchBehavior()
        }
    }

    init(scale: CGFloat = 0.71, isOn: Bool = false) {
        self.switchScale = scale
        super.init(frame: .zero)
        setupUI()
        self.isOn = isOn
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubview(switchControl)
        
        switchControl.transform = CGAffineTransform(scaleX: switchScale, y: switchScale)

        switchControl.addTarget(self, action: #selector(switchChanged), for: .valueChanged)

        switchControl.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        setSwitchBehavior()
    }
    
    private func setSwitchBehavior() {
        switchControl.isUserInteractionEnabled = !disableBehavior
    }

    @objc private func switchChanged() {
        sendActions(for: .valueChanged)
    }

    var onTintColor: UIColor? {
        get { switchControl.onTintColor }
        set { switchControl.onTintColor = newValue }
    }

    var thumbTintColor: UIColor? {
        get { switchControl.thumbTintColor }
        set { switchControl.thumbTintColor = newValue }
    }
}
