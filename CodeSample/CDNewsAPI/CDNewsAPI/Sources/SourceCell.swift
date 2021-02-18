//
//  SourceCell.swift
//  NewsAPI
//
//  Created by Derrick Park on 5/25/20.
//  Copyright © 2020 Derrick Park. All rights reserved.
//

import UIKit

class SourceCell: UITableViewCell {
  static let reuseIdentifier = "SourceCell"
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
}
