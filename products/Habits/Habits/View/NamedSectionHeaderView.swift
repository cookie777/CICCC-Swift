//
//  NamedSectionHeaderView.swift
//  Habits
//
//  Created by Takayuki Yamaguchi on 2021-02-11.
//

import UIKit

class NamedSectionHeaderView: UICollectionReusableView {
  
  let nameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .label
    label.font = UIFont.systemFont(ofSize: 24, weight: .black)
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupView()
  }
  
  private func setupView() {
    backgroundColor = .systemBackground
    
    addSubview(nameLabel)
    
    NSLayoutConstraint.activate([
      nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
      nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
    ])
  }
}
