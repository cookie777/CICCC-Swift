//
//  MenuTableViewController.swift
//  Restaurant
//
//  Created by Takayuki Yamaguchi on 2021-01-14.
//

import UIKit

class MenuTableViewController: UITableViewController {
  
  // category passed from categoryTVC
  let category: String
  // storing menuItems that you get from api
  var menuItems = [MenuItem]()
  // formatter for showing price
  let priceFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencySymbol = "$"
    return formatter
  }()
  

  init(category: String) {
    self.category = category
    super.init(nibName: nil, bundle: nil)
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MenuItem")

    
    MenuController.shared.fetchMenuItems(forCategory: category)
      { (result) in
        DispatchQueue.main.async {
          switch result{
          case .success(let menuItems):
            self.updateUI(with: menuItems)
          case .failure(let error):
            self.displayError(error, title: "Failed to Fetch Menu Items for \(self.category)")
          }
        }
      }
  }
  
  func updateUI(with menuItems: [MenuItem]) {
          self.menuItems = menuItems
          self.tableView.reloadData()
  }

  func displayError(_ error: Error, title: String){
    let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert )
    alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
    self.present(alert, animated: true)
  }
  

}


// MARK: - Table view data source
extension MenuTableViewController{
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return menuItems.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItem", for: indexPath)
    
    // set content text
    var content = cell.defaultContentConfiguration()
    let menuItem = menuItems[indexPath.row]
    content.text = menuItem.name
    content.prefersSideBySideTextAndSecondaryText = true
    content.secondaryText = priceFormatter.string(from: NSNumber(value: menuItem.price))
//    content.secondaryTextProperties.font = .systemFont(ofSize: 16)
    cell.contentConfiguration = content
    cell.accessoryType = .disclosureIndicator
    
    return cell
  }
  
  
}
