//
//  AddGarmentTableViewCell.swift
//  MobileAssessment
//
//  Created by Derrick Park on 2021-03-05.
//

import UIKit

class AddGarmentTableViewCell: UITableViewCell {
  static let reuseIdentifier = "add-garment-cell-reuse-identifier"
  let textField = UITextField()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.addSubview(textField)
    textField.matchParent(padding: .init(top: 8, left: 16, bottom: 8, right: 16))
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(false, animated: false)
  }
}
