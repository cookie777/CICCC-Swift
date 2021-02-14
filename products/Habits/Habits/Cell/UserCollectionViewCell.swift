//
//  UserCollectionViewCell.swift
//  Habits
//
//  Created by Takayuki Yamaguchi on 2021-02-11.
//

import UIKit

class UserCollectionViewCell: PrimarySecondaryTextCollectionViewCell {
  override init(frame: CGRect) {
    super.init(frame: frame)
    primaryTextLabel.textAlignment = .center
    primaryTextLabel.matchParent()
    primaryTextLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
