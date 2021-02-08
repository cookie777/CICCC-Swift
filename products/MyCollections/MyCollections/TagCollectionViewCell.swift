//
//  File.swift
//  MyCollections
//
//  Created by Takayuki Yamaguchi on 2021-02-04.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    
    var label :  UILabel = {
        let lb =  UILabel()
        lb.textColor =  UIColor.white.withAlphaComponent(0.8)
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.systemPink.withAlphaComponent(0.6)
        contentView.addSubview(label)
        label.centerXYin(contentView)
        
        contentView.layer.cornerRadius = 8
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
    
    override var isSelected: Bool{
        didSet{
            if isSelected{
                contentView.backgroundColor = UIColor.systemPink.withAlphaComponent(0.6)
            }else{
                contentView.backgroundColor = UIColor.systemGray.withAlphaComponent(0.3)
            }
        }
    }
    
}
