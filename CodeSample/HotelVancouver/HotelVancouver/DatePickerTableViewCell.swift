//
//  DatePickerTableViewCell.swift
//  HotelVancouver
//
//  Created by Derrick Park on 2021-01-11.
//

import UIKit

class DatePickerTableViewCell: UITableViewCell {
  
  let datePicker: UIDatePicker = {
    let dp = UIDatePicker()
    dp.preferredDatePickerStyle = .wheels
    return dp
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.addSubview(datePicker)
    datePicker.matchParent()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
