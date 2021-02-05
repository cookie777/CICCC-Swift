//
//  RestaurantCollectionViewCell.swift
//  MyRestaurants
//
//  Created by Takayuki Yamaguchi on 2021-02-04.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    
    var label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemTeal
        
        contentView.addSubview(label)
        label.centerXYin(contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCell(item: Movie) {
        label.text = item.title
    }
}
