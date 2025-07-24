import UIKit
import SnapKit

class CustomSizedSwitch: UIControl {
    private let trackView = UIView()
    private let thumbView = UIView()

    // Configuration
    private let trackOnColor: UIColor = .Brimo.Green.main
    private let trackOffColor: UIColor = .Brimo.Black.x200
    private let thumbColor: UIColor = .Brimo.White.main
    private let padding: CGFloat = 4

    private(set) var isOn: Bool = false {
        didSet {
            animateThumb()
            sendActions(for: .valueChanged)
        }
    }
    
    init(isEnalbed: Bool = true) {
        super.init(frame: .zero)
        self.isEnabled = isEnalbed
        setupViews()
        if isEnabled {
            addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toggle)))
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 52, height: 32)
    }

    private func setupViews() {
        addSubview(trackView)
        trackView.layer.cornerRadius = 16
        trackView.backgroundColor = trackOffColor

        addSubview(thumbView)
        thumbView.backgroundColor = thumbColor
        thumbView.layer.cornerRadius = 14
        thumbView.layer.shadowColor = UIColor.black.cgColor
        thumbView.layer.shadowOpacity = 0.1
        thumbView.layer.shadowOffset = CGSize(width: 0, height: 2)
        thumbView.layer.shadowRadius = 3
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        trackView.frame = bounds
        trackView.layer.cornerRadius = trackView.frame.height / 2

        let thumbSize = bounds.height - padding * 2
        let xPosition = isOn ? bounds.width - thumbSize - padding : padding
        thumbView.frame = CGRect(x: xPosition, y: padding, width: thumbSize, height: thumbSize)
        thumbView.layer.cornerRadius = thumbSize / 2
    }

    @objc private func toggle() {
        setOn(!isOn, animated: true)
    }

    func setOn(_ on: Bool, animated: Bool) {
        isOn = on
        if animated {
            animateThumb()
        } else {
            layoutSubviews()
        }
    }

    private func animateThumb() {
        UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseOut], animations: {
            self.layoutThumb()
        }, completion: nil)

        trackView.backgroundColor = isOn ? trackOnColor : trackOffColor
    }

    private func layoutThumb() {
        let thumbSize = bounds.height - padding * 2
        let xPosition = isOn ? bounds.width - thumbSize - padding : padding
        thumbView.frame.origin.x = xPosition
    }
}
