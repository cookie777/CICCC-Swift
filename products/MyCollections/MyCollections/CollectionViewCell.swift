//
//  RestaurantCollectionViewCell.swift
//  MyRestaurants
//
//  Created by Takayuki Yamaguchi on 2021-02-04.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
      super.init(frame: frame)
      contentView.backgroundColor = .systemTeal
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
}
