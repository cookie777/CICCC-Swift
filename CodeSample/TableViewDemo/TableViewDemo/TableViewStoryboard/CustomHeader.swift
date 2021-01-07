//
//  CustomHeader.swift
//  TableViewDemo
//
//  Created by Derrick Park on 2021-01-05.
//

import UIKit

class CustomHeader: UIView {
  let imageView = UIImageView()
  let label = UILabel()

  override init(frame: CGRect) {
    super.init(frame: frame)
    imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
    imageView.layer.cornerRadius = 16
    imageView.clipsToBounds = true
    
    label.font = .boldSystemFont(ofSize: 25)
    
    let hStackView = UIStackView(arrangedSubviews: [
      imageView, label
    ])
    hStackView.axis = .horizontal
    hStackView.alignment = .center
    hStackView.distribution = .fill
    hStackView.spacing = 8
    addSubview(hStackView)
    
    hStackView.matchParent(padding: .init(top: 0, left: 16, bottom: 0, right: 16))
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
