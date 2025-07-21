//
//  UIViewController+LoadingView.swift
//  brimo-native
//
//  Created by galih on 20/06/25.
//  Copyright © 2025 BRImo. All rights reserved.
//

import ObjectiveC
import UIKit

// MARK: - Circular Progress View
class CircularProgressView: UIView {
    private let shapeLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayer()
        startRotating()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayer()
        startRotating()
    }
    
    private func setupLayer() {
        let radius = min(bounds.width, bounds.height) / 2
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let circlePath = UIBezierPath(arcCenter: center,
                                      radius: radius - 4,
                                      startAngle: 0,
                                      endAngle: .pi * 2,
                                      clockwise: true)
        
        shapeLayer.path = circlePath.cgPath
        shapeLayer.lineWidth = 8
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.systemBlue.cgColor
        shapeLayer.lineCap = .round
        
        shapeLayer.strokeStart = 0
        shapeLayer.strokeEnd = 0.5
        
        layer.addSublayer(shapeLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayer()
    }
    
    private func startRotating() {
        let rotation = CABasicAnimation(keyPath: "transform.rotation")
        rotation.fromValue = 0
        rotation.toValue = CGFloat.pi * 2
        rotation.duration = 1
        rotation.repeatCount = .infinity
        layer.add(rotation, forKey: "rotate")
    }
    
    func startAnimation() {
        startRotating()
    }
}

// MARK: - UIViewController Extension for Loading
extension UIViewController {
    static let loadingTag = 98765
    private struct AssociatedKeys {
        static var loadingView = "loadingView"
    }
    
    func loading(_ isShow: Bool) {
        if isShow {
            showLoadingInWindow()
        } else {
            hideLoadingFromWindow()
        }
    }
    
    func loading(_ isShow: Bool, completion: @escaping () -> Void) {
        if isShow {
            showLoadingInWindow()
            completion()
        } else {
            hideLoadingFromWindow(completion: completion)
        }
    }
    
    // MARK: - Private Methods
    private func showLoadingInWindow() {
        hideLoadingFromWindow()
        
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
        
        let loadingContainer = createLoadingView()
        window.addSubview(loadingContainer)
        
        NSLayoutConstraint.activate([
            loadingContainer.topAnchor.constraint(equalTo: window.topAnchor),
            loadingContainer.leadingAnchor.constraint(equalTo: window.leadingAnchor),
            loadingContainer.trailingAnchor.constraint(equalTo: window.trailingAnchor),
            loadingContainer.bottomAnchor.constraint(equalTo: window.bottomAnchor)
        ])

        window.bringSubviewToFront(loadingContainer)

        loadingContainer.alpha = 0
        loadingContainer.subviews.last?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .curveEaseOut) {
            loadingContainer.alpha = 1
            loadingContainer.subviews.last?.transform = .identity
        }

        objc_setAssociatedObject(self, &AssociatedKeys.loadingView, loadingContainer, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    private func hideLoadingFromWindow() {
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
        let loadingView = objc_getAssociatedObject(self, &AssociatedKeys.loadingView) as? UIView ?? window.viewWithTag(UIViewController.loadingTag)
        guard let view = loadingView else { return }
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn) {
            view.alpha = 0
            view.subviews.last?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        } completion: { _ in
            view.removeFromSuperview()
            objc_setAssociatedObject(self, &AssociatedKeys.loadingView, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private func hideLoadingFromWindow(completion: @escaping () -> Void) {
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else {
            completion()
            return
        }
        
        let loadingView = objc_getAssociatedObject(self, &AssociatedKeys.loadingView) as? UIView ?? window.viewWithTag(UIViewController.loadingTag)
        
        guard let view = loadingView else {
            completion()
            return
        }
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn) {
            view.alpha = 0
            view.subviews.last?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        } completion: { _ in
            view.removeFromSuperview()
            objc_setAssociatedObject(self, &AssociatedKeys.loadingView, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            completion()
        }
    }
    
    private func createLoadingView() -> UIView {
        let container = UIView()
        container.backgroundColor = .clear
        container.translatesAutoresizingMaskIntoConstraints = false

        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = container.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 1
        container.addSubview(blurEffectView)

        let loadingContainer = UIView()
        loadingContainer.backgroundColor = .white
        loadingContainer.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(loadingContainer)

        let circularProgressView = CircularProgressView()
        circularProgressView.translatesAutoresizingMaskIntoConstraints = false
        loadingContainer.addSubview(circularProgressView)

        NSLayoutConstraint.activate([
            loadingContainer.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            loadingContainer.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            loadingContainer.widthAnchor.constraint(equalToConstant: 120),
            loadingContainer.heightAnchor.constraint(equalToConstant: 140),

            circularProgressView.centerXAnchor.constraint(equalTo: loadingContainer.centerXAnchor),
            circularProgressView.centerYAnchor.constraint(equalTo: loadingContainer.centerYAnchor),
            circularProgressView.widthAnchor.constraint(equalToConstant: 48),
            circularProgressView.heightAnchor.constraint(equalToConstant: 48)
        ])

        setupCustomCornerRadius(for: loadingContainer)

        circularProgressView.startAnimation()
        container.tag = UIViewController.loadingTag
        return container
    }
    
    private func setupCustomCornerRadius(for view: UIView) {
        let path = UIBezierPath()
        
        let width = 120.0
        let height = 140.0

        path.move(to: CGPoint(x: 12, y: 0))
        path.addLine(to: CGPoint(x: width - 40, y: 0))

        path.addArc(withCenter: CGPoint(x: width - 40, y: 40), radius: 40, startAngle: -CGFloat.pi/2, endAngle: 0, clockwise: true)

        path.addLine(to: CGPoint(x: width, y: height - 12))
        path.addArc(withCenter: CGPoint(x: width - 12, y: height - 12), radius: 12, startAngle: 0, endAngle: CGFloat.pi/2, clockwise: true)

        path.addLine(to: CGPoint(x: 12, y: height))
        path.addArc(withCenter: CGPoint(x: 12, y: height - 12), radius: 12, startAngle: CGFloat.pi/2, endAngle: CGFloat.pi, clockwise: true)

        path.addLine(to: CGPoint(x: 0, y: 12))
        path.addArc(withCenter: CGPoint(x: 12, y: 12), radius: 12, startAngle: CGFloat.pi, endAngle: -CGFloat.pi/2, clockwise: true)
        
        path.close()
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        view.layer.mask = maskLayer

        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 8
        view.layer.shadowOpacity = 0.1
    }
}

