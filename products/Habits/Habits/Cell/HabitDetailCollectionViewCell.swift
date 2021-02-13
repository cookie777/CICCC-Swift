//
//  HabitDetailCollectionViewCell.swift
//  Habits
//
//  Created by Takayuki Yamaguchi on 2021-02-12.
//

import UIKit

class HabitDetailCollectionViewCell: PrimarySecondaryTextCollectionViewCell {
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    primaryTextLabel.textAlignment = .left
    primaryTextLabel.matchParent(padding: .init(top: 0, left: 0, bottom: 0, right: 0))
    primaryTextLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    
    secondaryTextLabel.textAlignment = .right
    secondaryTextLabel.matchParent(padding: .init(top: 0, left: 0, bottom: 0, right: 8))
    secondaryTextLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)

//    self.constraintHeight(equalToConstant: 44)
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
