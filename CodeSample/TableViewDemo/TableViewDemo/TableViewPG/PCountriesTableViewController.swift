//
//  PCountriesTableViewController.swift
//  TableViewDemo
//
//  Created by Derrick Park on 2021-01-05.
//

import UIKit

class PCountriesTableViewController: UITableViewController {
  
  let cellId = "CountryCell"
  
  var countries: [[String]] = [["Canada", "USA", "Mexico"], ["Japan", "China", "Korea", "Philippines"], ["Germany", "France", "UK"], ["Brazil", "Argentina", "Colombia", "Ecuador"]]
  
  var sectionTitles: [String] = ["North America", "Asia", "Europe", "South America"]
  var dataSource = CountryDataSource()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Countries"
    navigationController?.navigationBar.prefersLargeTitles = true
    // make sure you register cell
    tableView.register(PCountryTableViewCell.self, forCellReuseIdentifier: cellId)
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return countries.count
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return countries[section].count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! PCountryTableViewCell
    
    cell.textLabel?.text = countries[indexPath.section][indexPath.row]
    cell.detailTextLabel?.text = sectionTitles[indexPath.section]
    return cell
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
