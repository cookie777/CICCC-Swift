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
        lb.text = " "
        lb.textColor =  UIColor.white.withAlphaComponent(0.6)
        lb.textAlignment = .center
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.systemGray.withAlphaComponent(0.3)
        contentView.addSubview(label)
        label.matchParent(padding: .init(top: 4, left: 16, bottom: 4, right: 16))
        
        contentView.layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCell(str: String) {
        label.text = str
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
