//
//  SourceDataView.swift
//  BottomSheetViewControllerExample
//
//  Created by Bukhari Muslim on 18/07/25.
//

import UIKit
import SnapKit

class SourceDataView: UIView {
    private let source: SourceDetailViewModel
    private let destination: SourceDetailViewModel
    
    private lazy var mainStackView: UIStackView = {
        let stack: UIStackView = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 0
        return stack
    }()
    
    private lazy var sourceImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "image_placeholder/default_circle_32")
        imageView.snp.makeConstraints {
            $0.width.equalTo(32)
            $0.height.equalTo(32)
        }
        return imageView
    }()
    
    private lazy var sourceTopLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .Brimo.Body.largeSemiBold
        label.textColor = .Brimo.Black.main
        return label
    }()
    
    private lazy var sourceBottomLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .Brimo.Body.mediumRegular
        label.textColor = .Brimo.Black.main
        return label
    }()
    
    private lazy var destinationImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "image_placeholder/default_circle_32")
        imageView.snp.makeConstraints {
            $0.width.equalTo(32)
            $0.height.equalTo(32)
        }
        return imageView
    }()
    
    private lazy var destinationTopLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .Brimo.Body.largeSemiBold
        label.textColor = .Brimo.Black.main
        return label
    }()
    
    private lazy var delimiterImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "arrows/ico_arrow_down")
        imageView.snp.makeConstraints {
            $0.width.equalTo(18)
            $0.height.equalTo(18)
        }
        return imageView
    }()
    
    private lazy var delimiterView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .Brimo.Black.x200
        view.snp.makeConstraints {
            $0.height.equalTo(1)
        }
        return view
    }()
    
    private lazy var destinationBottomLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .Brimo.Body.mediumRegular
        label.textColor = .Brimo.Black.main
        return label
    }()
    
    private lazy var sourceLabelStackView: UIStackView = {
        let stack: UIStackView = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        stack.spacing = 2
        return stack
    }()
    
    private lazy var sourceStackView: UIStackView = {
        let stack: UIStackView = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.alignment = .leading
        stack.spacing = 12
        return stack
    }()
    
    private lazy var destinationLabelStackView: UIStackView = {
        let stack: UIStackView = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        stack.spacing = 2
        return stack
    }()
    
    private lazy var destinationStackView: UIStackView = {
        let stack: UIStackView = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.alignment = .leading
        stack.spacing = 12
        return stack
    }()
    
    private lazy var delimiterStackView: UIStackView = {
        let stack: UIStackView = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 12
        return stack
    }()
    
    init(source: SourceDetailViewModel, destination: SourceDetailViewModel) {
        self.source = source
        self.destination = destination
        super.init(frame: .zero)
        
        setupView()
        updateContent()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        sourceLabelStackView.addArrangedSubview(sourceTopLabel)
        sourceLabelStackView.addArrangedSubview(sourceBottomLabel)
        sourceStackView.addArrangedSubview(sourceImageView)
        sourceStackView.addArrangedSubview(sourceLabelStackView)
        
        destinationLabelStackView.addArrangedSubview(destinationTopLabel)
        destinationLabelStackView.addArrangedSubview(destinationBottomLabel)
        destinationStackView.addArrangedSubview(destinationImageView)
        destinationStackView.addArrangedSubview(destinationLabelStackView)
        
        let delimiterImageContainerView: UIView = UIView()
        delimiterImageContainerView.addSubview(delimiterImageView)
        delimiterStackView.addArrangedSubview(delimiterImageContainerView)
        delimiterStackView.addArrangedSubview(delimiterView)
        
        mainStackView.addArrangedSubview(sourceStackView)
        mainStackView.addArrangedSubview(delimiterStackView)
        mainStackView.addArrangedSubview(destinationStackView)
        addSubview(mainStackView)
        
        layer.cornerRadius = 16
        backgroundColor = .Brimo.White.main
        
        delimiterImageView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(4)
            $0.horizontalEdges.equalToSuperview().inset(7)
        }
        
        mainStackView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(12)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    
    private func updateContent() {
        sourceTopLabel.text = source.title
        sourceBottomLabel.text = source.description
        
        destinationTopLabel.text = destination.title
        destinationBottomLabel.text = destination.description
    }
}
