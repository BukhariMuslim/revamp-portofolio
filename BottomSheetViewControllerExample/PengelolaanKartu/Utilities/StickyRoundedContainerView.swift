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
    private var compositeHeader: StickyCompositeHeader?
    
    var roundedContainerView: UIView { roundedContainer }

    init(
        headerView: UIView,
        contentView: UIView,
        isStickyEnabled: Bool = true,
        compositeHeaderBuilder: StickyCompositeHeader.ContainerBuilder? = nil
    ) {
        self.headerView = headerView
        self.contentView = contentView
        self.isStickyEnabled = isStickyEnabled
        super.init(frame: .zero)
        setupLayout(compositeHeaderBuilder: compositeHeaderBuilder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let headerFrame = headerView.frame
        let scrollOffsetY = scrollView.contentOffset.y

        if point.y < headerFrame.maxY - scrollOffsetY {
            let converted = headerView.convert(point, from: self)
            return headerView.hitTest(converted, with: event)
        }

        return super.hitTest(point, with: event)
    }

    private func setupLayout(compositeHeaderBuilder: StickyCompositeHeader.ContainerBuilder?) {
        addSubviews(headerView, roundedContainer, scrollView)

        scrollView.backgroundColor = .clear
        scrollView.addSubview(scrollContent)
        scrollContent.addSubviews(spacerView, contentWrapper)
        contentWrapper.addSubview(contentView)

        scrollView.showsVerticalScrollIndicator = false
        scrollView.isScrollEnabled = false

        contentWrapper.backgroundColor = isStickyEnabled ? .Brimo.White.main : .clear
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
                make.top.equalTo(roundedContainer.snp.top)
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

        contentWrapper.snp.makeConstraints { [weak self] make in
            guard let self = self else { return }
            make.top.equalTo(spacerView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.greaterThanOrEqualTo(self.snp.height).offset(-24)
        }

        contentView.snp.makeConstraints { make in
            if isStickyEnabled {
                make.edges.equalToSuperview()
            } else {
                make.top.equalToSuperview().offset(16)
                make.leading.trailing.bottom.equalToSuperview()
            }
        }

        roundedContainer.snp.makeConstraints { [weak self] make in
            guard let self = self else { return }
            if isStickyEnabled {
                self.topConstraint = make.top.equalTo(self.headerView.snp.top).constraint
                make.height.greaterThanOrEqualTo(48)
                make.bottom.equalToSuperview()
            } else {
                make.top.equalTo(headerView.snp.bottom)
                make.bottom.equalToSuperview()
            }
            make.leading.trailing.equalToSuperview()
        }

        if let builder = compositeHeaderBuilder {
            compositeHeader = StickyCompositeHeader(
                in: self,
                scrollContent: scrollContent,
                stickyOffset: 0,
                buildContent: builder
            )
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

final class StickyCompositeHeader {
    typealias ContainerBuilder = (_ container: UIView) -> Void
    
    private let sourceView: PassthroughView = PassthroughView()
    private var currentBuilder: ContainerBuilder?
    private weak var container: StickyRoundedContainerView?

    init(
        in container: StickyRoundedContainerView,
        scrollContent: UIView,
        stickyOffset: CGFloat = 0,
        buildContent: @escaping ContainerBuilder
    ) {
        self.container = container
        
        currentBuilder = buildContent

        sourceView.backgroundColor = .Brimo.White.main
        buildContent(sourceView)

        container.addSubview(sourceView)

        sourceView.snp.makeConstraints {
            $0.top.equalTo(container.roundedContainerView.snp.top).offset(24)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }
}
