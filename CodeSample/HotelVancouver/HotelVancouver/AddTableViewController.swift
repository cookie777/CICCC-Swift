//
//  AddTableViewController.swift
//  HotelVancouver
//
//  Created by Derrick Park on 2021-01-11.
//

import UIKit

class AddTableViewController: UITableViewController {
  
  let checkInLabelCell: DateLabelTableViewCell = {
    let cell = DateLabelTableViewCell()
    cell.label.text = "Check-In Date"
    let midnightToday = Calendar.current.startOfDay(for: Date()) // midnight
    cell.datePicker.minimumDate = midnightToday
    cell.datePicker.date = midnightToday
    return cell
  }()
//  let checkInDatePickerCell = DatePickerTableViewCell()
  lazy var checkOutLabelCell: DateLabelTableViewCell = {
    let cell = DateLabelTableViewCell()
    cell.label.text = "Check-Out Date"
    cell.datePicker.minimumDate = Calendar.current.date(byAdding: .day, value: 1, to: checkInLabelCell.datePicker.date)
    return cell
  }()
//  let checkOutDatePickerCell = DatePickerTableViewCell()
  
  private let checkInLabelCellIndexPath = IndexPath(row: 0, section: 0)
//  private let checkInDatePickerCellIndexPath = IndexPath(row: 1, section: 0)
  private let checkOutLabelCellIndexPath = IndexPath(row: 1, section: 0)
//  private let checkOutDatePickerCellIndexPath = IndexPath(row: 3, section: 0)
  
//  private var isCheckInDatePickerVisible: Bool = false {
//    didSet {
//      checkInDatePickerCell.datePicker.isHidden = !isCheckInDatePickerVisible
//    }
//  }
//  private var isCheckOutDatePickerVisible: Bool = false {
//    didSet {
//      checkOutDatePickerCell.datePicker.isHidden = !isCheckOutDatePickerVisible
//    }
//  }
  
  private let dateFormatter: DateFormatter = {
    let df = DateFormatter()
    df.dateStyle = .medium
    return df
  }()
  
  fileprivate func updateDatePickers() {
    checkOutLabelCell.datePicker.minimumDate = Calendar.current.date(byAdding: .day, value: 1, to: checkInLabelCell.datePicker.date)
//    checkOutDatePickerCell.datePicker.minimumDate = Calendar.current.date(byAdding: .day, value: 1, to: checkInDatePickerCell.datePicker.date)
//    checkInLabelCell.detailTextLabel?.text = dateFormatter.string(from: checkInDatePickerCell.datePicker.date)
//    checkOutLabelCell.detailTextLabel?.text = dateFormatter.string(from: checkOutDatePickerCell.datePicker.date)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    checkInLabelCell.datePicker.addTarget(self, action: #selector(dateValueChanged(_:)), for: .valueChanged)
    checkOutLabelCell.datePicker.addTarget(self, action: #selector(dateValueChanged(_:)), for: .valueChanged)
    
//    checkInDatePickerCell.datePicker.addTarget(self, action: #selector(dateValueChanged(_:)), for: .valueChanged)
//    checkOutDatePickerCell.datePicker.addTarget(self, action: #selector(dateValueChanged(_:)), for: .valueChanged)
//
//    // initial date picker minimum date
//    let midnightToday = Calendar.current.startOfDay(for: Date()) // midnight
//    checkInDatePickerCell.datePicker.minimumDate = midnightToday
//    checkInDatePickerCell.datePicker.date = midnightToday
//    updateDatePickers()
  }
  
  @objc func dateValueChanged(_ sender: UIDatePicker) {
    updateDatePickers()
  }
  
  // MARK: - Table view data source
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    return 4
    return 2
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath {
    case checkInLabelCellIndexPath:
      return checkInLabelCell
    case checkOutLabelCellIndexPath:
      return checkOutLabelCell
    default:
      return UITableViewCell()
    }
  }
  
  
//  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    switch indexPath {
//    case checkInLabelCellIndexPath:
//      checkInLabelCell.textLabel?.text = "Check-In Date"
//      return checkInLabelCell
//
//    case checkInDatePickerCellIndexPath:
//      return checkInDatePickerCell
//
//    case checkOutLabelCellIndexPath:
//      checkOutLabelCell.textLabel?.text = "Check-Out Date"
//      return checkOutLabelCell
//
//    case checkOutDatePickerCellIndexPath:
//      return checkOutDatePickerCell
//
//    default:
//      return UITableViewCell()
//    }
//  }
  
//  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//    switch indexPath {
//    case checkInDatePickerCellIndexPath where isCheckInDatePickerVisible == false:
//      return 0
//    case checkOutDatePickerCellIndexPath where isCheckOutDatePickerVisible == false:
//      return 0
//    default:
//      return UITableView.automaticDimension
//    }
//  }
  
//  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    tableView.deselectRow(at: indexPath, animated: true)
//
//    if indexPath == checkInLabelCellIndexPath && !isCheckOutDatePickerVisible {
//      isCheckInDatePickerVisible.toggle()
//    } else if indexPath == checkOutLabelCellIndexPath && !isCheckInDatePickerVisible {
//      isCheckOutDatePickerVisible.toggle()
//    } else if indexPath == checkInLabelCellIndexPath || indexPath == checkOutLabelCellIndexPath {
//      isCheckInDatePickerVisible.toggle()
//      isCheckOutDatePickerVisible.toggle()
//    } else {
//      return
//    }
//    tableView.beginUpdates()
//    tableView.endUpdates()
//  }
  
}
