//
//  BasicHeaderView.swift
//  BasicCollectionView
//
//  Created by Derrick Park on 2021-02-04.
//

import UIKit

class BasicHeaderView: UICollectionReusableView {
  
  let label = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(label)
    backgroundColor = .systemBlue
    label.centerXYin(self)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
