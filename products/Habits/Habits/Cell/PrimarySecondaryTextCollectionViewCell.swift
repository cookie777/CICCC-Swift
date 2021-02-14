//
//  PrimarySecondaryTextCollectionViewCell.swift
//  Habits
//
//  Created by Takayuki Yamaguchi on 2021-02-11.
//

import UIKit

class PrimarySecondaryTextCollectionViewCell: UICollectionViewCell {
  
  static let HabitReusableIdentifier = "Habit"
  static let UserReusableIdentifier  = "User"
  static let HabitDetailReusableIdentifier  = "HabitDetail"
  static let UserDetailReusableIdentifier  = "UserDetail"
  static let SelectionIndicatingPrimarySecondaryTextIdentifier = "SelectionIndicating"
  
  let primaryTextLabel: UILabel = {
    let lb = UILabel()
    lb.translatesAutoresizingMaskIntoConstraints = false
    return lb
  }()
  let secondaryTextLabel: UILabel = {
    let lb = UILabel()
    lb.translatesAutoresizingMaskIntoConstraints = false
    return lb
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(primaryTextLabel)
    contentView.addSubview(secondaryTextLabel)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}


class SelectionIndicatingPrimarySecondaryTextCollectionViewCell: PrimarySecondaryTextCollectionViewCell {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    let background = UIView(frame: bounds)
    background.translatesAutoresizingMaskIntoConstraints = false
    background.backgroundColor = UIColor.systemGray4.withAlphaComponent(0.75)

    selectedBackgroundView = background

    NSLayoutConstraint.activate([
      leadingAnchor.constraint(equalTo: background.leadingAnchor),
      trailingAnchor.constraint(equalTo: background.trailingAnchor),
      topAnchor.constraint(equalTo: background.topAnchor),
      bottomAnchor.constraint(equalTo: background.bottomAnchor)
    ])
    
    layer.cornerRadius = 8
    layer.shadowRadius = 3
    layer.shadowColor = UIColor.systemGray3.cgColor
    layer.shadowOffset = CGSize(width: 0, height: 2)
    layer.shadowOpacity = 1
    layer.masksToBounds = false
    
    background.layer.cornerRadius = 8
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
