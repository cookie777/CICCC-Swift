//
//  DateLabelTableViewCell.swift
//  HotelVancouver
//
//  Created by Derrick Park on 2021-01-11.
//

import UIKit

class DateLabelTableViewCell: UITableViewCell {
  
  let label = UILabel()
  
  let datePicker: UIDatePicker = {
    let dp = UIDatePicker()
    dp.preferredDatePickerStyle = .compact
    return dp
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    let hStackView = HorizontalStackView(arrangedSubviews: [label, datePicker], spacing: 8, alignment: .center, distribution: .fillEqually)
    contentView.addSubview(hStackView)
    hStackView.matchParent(padding: .init(top: 0, left: 8, bottom: 0, right: 8))
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
