//
//  LeaderboardHabitCollectionViewCell.swift
//  Habits
//
//  Created by Takayuki Yamaguchi on 2021-02-13.
//

import UIKit

class LeaderboardHabitCollectionViewCell: UICollectionViewCell {
  let habitNameLabel: UILabel = {
    let lb = UILabel()
    lb.translatesAutoresizingMaskIntoConstraints = false
    lb.font = UIFont.systemFont(ofSize: 24, weight: .black)
    lb.textAlignment = .left
    return lb
  }()
  let leaderLabel: UILabel = {
    let lb = UILabel()
    lb.translatesAutoresizingMaskIntoConstraints = false
    lb.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    lb.textAlignment = .right
    return lb
  }()
  let secondaryLabel: UILabel = {
    let lb = UILabel()
    lb.translatesAutoresizingMaskIntoConstraints = false
    lb.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    lb.textAlignment = .right
    return lb
  }()
  lazy var stackView = VerticalStackView(arrangedSubviews: [habitNameLabel, leaderLabel, secondaryLabel],spacing: 8)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    contentView.addSubview(stackView)
    stackView.matchParent()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
