//
//  GarmentTableViewCell.swift
//  MobileAssessment
//
//  Created by Derrick Park on 2021-03-05.
//

import UIKit

class GarmentTableViewCell: UITableViewCell {
  static let reuseIdentifier = "garment-cell-reuse-identifier"
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(false, animated: false)
  }
  
  func configure(with garment: Garment) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .medium
    textLabel?.text = garment.name
    detailTextLabel?.text = dateFormatter.string(from: garment.creationDate!)
  }
}
