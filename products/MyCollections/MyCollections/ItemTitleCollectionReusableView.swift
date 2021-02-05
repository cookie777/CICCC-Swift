//
//  ItemTitleCollectionReusableView.swift
//  MyCollections
//
//  Created by Takayuki Yamaguchi on 2021-02-05.
//

import UIKit

class ItemTitleView: UICollectionReusableView {
    let label = UILabel()
    
    override init(frame: CGRect) {
      super.init(frame: frame)
      addSubview(label)
        backgroundColor = .systemGreen
      label.centerXYin(self)
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
}
