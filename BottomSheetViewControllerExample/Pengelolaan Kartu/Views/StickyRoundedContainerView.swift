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

    init(headerView: UIView, contentView: UIView) {
        self.headerView = headerView
        self.contentView = contentView
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
            make.top.equalToSuperview().offset(24)
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
            self.topConstraint = make.top.equalTo(self.headerView.snp.top).constraint
            make.leading.trailing.equalToSuperview()
            make.height.greaterThanOrEqualTo(48)
        }
        
        scrollView.delegate = self
    }

    func setHeaderHeight(_ height: CGFloat) {
        self.headerHeight = height
        spacerView.snp.updateConstraints { $0.height.equalTo(height) }
        scrollView.contentInset.top = 0
        scrollView.contentOffset = .zero
        scrollView.isScrollEnabled = true
        
        scrollViewDidScroll(scrollView)
    }
}

extension StickyRoundedContainerView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let pinnedOffset = max(0, headerHeight - offsetY)
        topConstraint?.update(offset: pinnedOffset)
    }
}
