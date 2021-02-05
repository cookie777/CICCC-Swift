//
//  File.swift
//  MyCollections
//
//  Created by Takayuki Yamaguchi on 2021-02-04.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    
    var label = UILabel()
    
    override init(frame: CGRect) {
      super.init(frame: frame)
        contentView.backgroundColor = .systemPink
        
        contentView.addSubview(label)
        label.centerXYin(contentView)
        
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    func updateCell(str: String) {
        label.text = str
//        setNeedsLayout()
//        layoutIfNeeded()
//        frame.size = CGSize(width: label.frame.size.width+16, height: frame.size.height)
//        print(frame.size)
    }
    

}
