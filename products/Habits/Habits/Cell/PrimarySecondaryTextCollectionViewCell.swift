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
    addSubview(primaryTextLabel)
    addSubview(secondaryTextLabel)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
