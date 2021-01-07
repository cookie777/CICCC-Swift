//
//  CountryDataSource.swift
//  TableViewDemo
//
//  Created by Derrick Park on 2021-01-05.
//

import UIKit

class CountryDataSource: NSObject, UITableViewDataSource {
  // MARK: - Table view data source
  let cellId = "CountryCell"
  
  var countries: [[String]] = [["Canada", "USA", "Mexico"], ["Japan", "China", "Korea", "Philippines"], ["Germany", "France", "UK"], ["Brazil", "Argentina", "Colombia", "Ecuador"]]
  
  var sectionTitles: [String] = ["North America", "Asia", "Europe", "South America"]
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return countries.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return countries[section].count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! PCountryTableViewCell
    
    cell.textLabel?.text = countries[indexPath.section][indexPath.row]
    cell.detailTextLabel?.text = sectionTitles[indexPath.section]
    return cell
  }
}
