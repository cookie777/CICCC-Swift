//
//  HomeCollectionView.swift
//  Habits
//
//  Created by Takayuki Yamaguchi on 2021-02-13.
//

import UIKit

class FollowedUserViewCell: PrimarySecondaryTextCollectionViewCell {
  override init(frame: CGRect) {
    super.init(frame: frame)
    primaryTextLabel.textAlignment = .left
    primaryTextLabel.anchors(
      topAnchor: contentView.topAnchor,
      leadingAnchor: contentView.leadingAnchor,
      trailingAnchor: nil,
      bottomAnchor: nil,
      padding: .init(top: 16, left: 16, bottom: 0, right: 0)
    )
    primaryTextLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
    
    secondaryTextLabel.textAlignment = .left
    secondaryTextLabel.anchors(
      topAnchor: primaryTextLabel.bottomAnchor,
      leadingAnchor: primaryTextLabel.leadingAnchor,
      trailingAnchor: contentView.trailingAnchor,
      bottomAnchor: contentView.bottomAnchor,
      padding: .init(top: 16, left: 24, bottom: 8, right: 8)
    )
    secondaryTextLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
