import UIKit
import SnapKit

final class StickyRoundedContainerView: UIView {
    private let headerView: UIView
    private let contentView: UIView

    private let scrollView = UIScrollView()
    private let scrollContent = UIView()
    private let roundedContainer = UIView()
    private let contentWrapper = UIView()
    private let spacerView = UIView()
    
    private var spacerHeightConstraint: Constraint?
    private var headerHeight: CGFloat = 0
    private var topConstraint: Constraint?
    
    private var isStickyEnabled: Bool

    init(headerView: UIView, contentView: UIView, isStickyEnabled: Bool = true) {
        self.headerView = headerView
        self.contentView = contentView
        self.isStickyEnabled = isStickyEnabled
        super.init(frame: .zero)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        addSubview(headerView)
        addSubview(roundedContainer)
        addSubview(scrollView)

        scrollView.backgroundColor = isStickyEnabled ? .clear : .Brimo.White.main
        scrollView.addSubview(scrollContent)
        scrollContent.addSubview(spacerView)
        scrollContent.addSubview(contentWrapper)
        contentWrapper.addSubview(contentView)

        scrollView.showsVerticalScrollIndicator = false
        scrollView.isScrollEnabled = false
        
        contentWrapper.backgroundColor = .Brimo.White.main
        roundedContainer.backgroundColor = .Brimo.White.main
        roundedContainer.layer.cornerRadius = 24
        roundedContainer.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        roundedContainer.layer.masksToBounds = true

        headerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints { make in
            if isStickyEnabled {
                make.top.equalToSuperview().offset(24)
            } else {
                make.top.equalTo(roundedContainer.snp.bottom).offset(-16)
            }
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        scrollContent.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        spacerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(0)
        }
        
        contentWrapper.snp.makeConstraints { make in
            make.top.equalTo(spacerView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        roundedContainer.snp.makeConstraints { [weak self] make in
            guard let self = self else { return }
            if isStickyEnabled {
                self.topConstraint = make.top.equalTo(self.headerView.snp.top).constraint
                make.height.greaterThanOrEqualTo(48)
            } else {
                make.top.equalTo(headerView.snp.bottom)
                make.height.equalTo(48)
            }
            make.leading.trailing.equalToSuperview()
        }
        
        scrollView.delegate = self
    }

    func setHeaderHeight(_ height: CGFloat) {
        self.headerHeight = height
        scrollView.contentInset.top = 0
        scrollView.isScrollEnabled = true
        scrollView.contentOffset = .zero
        scrollViewDidScroll(scrollView)
        
        if isStickyEnabled {
            spacerView.snp.updateConstraints { $0.height.equalTo(height) }
        }
    }
}

extension StickyRoundedContainerView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard isStickyEnabled else { return }
        let offsetY = scrollView.contentOffset.y
        let pinnedOffset = max(0, headerHeight - offsetY)
        topConstraint?.update(offset: pinnedOffset)
    }
}
