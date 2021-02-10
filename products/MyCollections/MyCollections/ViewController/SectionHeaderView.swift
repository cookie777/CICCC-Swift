//
//  SectionHeaderView.swift
//  MyCollections
//
//  Created by Takayuki Yamaguchi on 2021-02-08.
//


import UIKit

class SectionHeaderView: UICollectionReusableView {
    
    static let firstReuseIdentifier = "FirstSectionHeaderView"
    static let secondReuseIdentifier = "SecondSectionHeaderView"


    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32, weight: .black)
        label.textColor = .label
        label.textAlignment = .left
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        
        return label
    }()
    
    lazy var stackView = VerticalStackView(arrangedSubviews: [UIView(), label], spacing: 24)
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(stackView)
        stackView.matchParent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitle(_ title: String) {
        label.text = title
    }
    
    func setTopSpace(top: CGFloat) {
        stackView.spacing = top
    }
}
