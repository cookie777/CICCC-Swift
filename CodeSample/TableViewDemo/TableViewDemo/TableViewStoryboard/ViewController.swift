//
//  ViewController.swift
//  TableViewDemo
//
//  Created by Derrick Park on 2021-01-05.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet var tableView: UITableView!
  
  var countries: [[String]] = [["Canada", "USA", "Mexico"], ["Japan", "China", "Korea", "Philippines"], ["Germany", "France", "UK"], ["Brazil", "Argentina", "Colombia", "Ecuador"]]
  
  var sectionTitles: [String] = ["North America", "Asia", "Europe", "South America"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.delegate = self
    // datasource: asks how many rows / sections / about data
    // delegate: looks and behaviours
  }
}

extension ViewController: UITableViewDataSource {
  // optional (default 1 section)
  func numberOfSections(in tableView: UITableView) -> Int {
    return countries.count
  }
  
  // required
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return countries[section].count
  }
  
  // required
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // 1. get the reuseable cell from the queue
    let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath)
    // 2. configure the cell and return
    cell.textLabel?.text = countries[indexPath.section][indexPath.row]
    return cell
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return sectionTitles[section]
  }
}

extension ViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    print("\(countries[indexPath.section][indexPath.row])")
  }
}
