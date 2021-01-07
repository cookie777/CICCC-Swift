//
//  CountryTableViewCell.swift
//  TableViewDemo
//
//  Created by Derrick Park on 2021-01-05.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
  
  @IBOutlet var countryLabel: UILabel!
  @IBOutlet var countryImage: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    countryLabel.text = "Loading..." 
  }
}
