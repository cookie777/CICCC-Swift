//
//  CountiesTableViewController.swift
//  TableViewDemo
//
//  Created by Derrick Park on 2021-01-05.
//

import UIKit

class CountiesTableViewController: UITableViewController {
  var countries: [[String]] = [["Canada", "USA", "Mexico"], ["Japan", "China", "Korea", "Philippines"], ["Germany", "France", "UK"], ["Brazil", "Argentina", "Colombia", "Ecuador"]]
  
  var sectionTitles: [String] = ["North America", "Asia", "Europe", "South America"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return countries.count
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return countries[section].count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if indexPath.section % 2 == 0 {
      let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as! CountryTableViewCell
      cell.countryLabel.text = countries[indexPath.section][indexPath.row]
      cell.countryImage.image = UIImage(named: "earth")
      return cell
    } else {
      let cell = tableView.dequeueReusableCell(withIdentifier: "Subtitle", for: indexPath)
      cell.textLabel?.text = countries[indexPath.section][indexPath.row]
      cell.detailTextLabel?.text = sectionTitles[indexPath.section]
      return cell
    }
  }
  
  // MARK: - UITableView Delegate
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 80
  }
  
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let header = CustomHeader()
    header.imageView.image = UIImage(named: "earth")
    header.label.text = sectionTitles[section]
    return header
  }
  
  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return view.frame.size.height * 0.05
  }
  
}
