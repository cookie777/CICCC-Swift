//
//  BasicCollectionViewCell.swift
//  BasicCollectionView
//
//  Created by Derrick Park on 2021-02-02.
//

import UIKit

class BasicCollectionViewCell: UICollectionViewCell {
  let label = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(label)
    contentView.backgroundColor = .systemTeal
    label.centerXYin(contentView)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
