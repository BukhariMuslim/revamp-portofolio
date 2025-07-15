//
//  LimitSettingCollectionView.swift
//  BottomSheetViewControllerExample
//
//  Created by sia santos on 15/07/25.
//

import UIKit
import SnapKit

class LimitSettingCollectionView: UICollectionViewCell {
  static let reuseIdentifier = "LimitSettingCollectionView"
  
  private lazy var cellView: LimitSettingCellView = {
    // we'll configure with a dummy model for init;
    // real data comes in `configure(with:)`
    let dummy = LimitSettingModel(
      topLeftIcon: "",
      topSubtitleLabel: "",
      topDescriptionLabel: "",
      bottomSubtitleLabel: "",
      bottomDescriptionLabel: "",
      isPremiumBadge: false
    )
    return LimitSettingCellView(model: dummy)
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(cellView)
    cellView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  required init?(coder: NSCoder) { fatalError() }
  
  func configure(with model: LimitSettingModel) {
    // replace the internal view’s model
    // easiest: recreate it, or add a public `update(model:)` on your cellView
    let newView = LimitSettingCellView(model: model)
    cellView.removeFromSuperview()
    contentView.addSubview(newView)
    newView.snp.makeConstraints { $0.edges.equalToSuperview() }
  }
}
