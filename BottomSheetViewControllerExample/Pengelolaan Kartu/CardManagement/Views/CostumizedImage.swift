import UIKit
import SnapKit

class CustomizedImage: UIControl {
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.tintColor = .Brimo.Black.x600
        iv.contentMode = .scaleAspectFit
        iv.snp.makeConstraints { $0.size.equalTo(24) }
        return iv
    }()

    init(imageName: String) {
        super.init(frame: .zero)
        setupUI(imageName)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI(_ imageName: String) {
        addSubview(imageView)
        
        imageView.image = UIImage(named: imageName)?
            .withRenderingMode(.alwaysTemplate)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
