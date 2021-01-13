//
//  RegistrationTableViewController.swift
//  HotelVancouver
//
//  Created by Derrick Park on 2021-01-11.
//

import UIKit

class RegistrationTableViewController: UITableViewController {
  let cellId = "RegistrationCell"
  
  var registrations = [Registration]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewRegistration(_:)))
  }
  
  @objc func addNewRegistration(_ sender: UIBarButtonItem) {
    let addTVC = AddTableViewController(style: .grouped)
    present(UINavigationController(rootViewController: addTVC), animated: true)
  }
  
  // MARK: - Table view data source
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return registrations.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
    
    return cell
  }
}
