//
//  HabitCollectionViewCell.swift
//  Habits
//
//  Created by Takayuki Yamaguchi on 2021-02-11.
//

import UIKit

class HabitCollectionViewCell: PrimarySecondaryTextCollectionViewCell {
  override init(frame: CGRect) {
    super.init(frame: frame)
    primaryTextLabel.textAlignment = .left
    primaryTextLabel.matchParent(padding: .init(top: 0, left: 6, bottom: 0, right: 0))
    primaryTextLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    self.constraintHeight(equalToConstant: 44)
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
