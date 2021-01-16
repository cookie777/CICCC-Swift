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
            Alert.displayError(target: self, error, title: "Failed to Fetch Menu Items for \(self.category)")
          }
        }
      }
  }
  
  func updateUI(with menuItems: [MenuItem]) {
          self.menuItems = menuItems
          self.tableView.reloadData()
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
    content.secondaryText = MenuItem.priceFormatter.string(from: NSNumber(value: menuItem.price))
    cell.accessoryType = .disclosureIndicator
    
    // set content image
    MenuController.shared.fetchImage(url: menuItem.imageURL) { (uiImage: UIImage?) in
      DispatchQueue.main.async {
        if let uiImage = uiImage{
          content.image = uiImage
        }else{
          // if image is nil, set place holder
          content.image = UIImage(systemName: "photo.on.rectangle")
        }
        cell.setNeedsLayout()
        cell.contentConfiguration = content
      }
    }
    
    
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedMenuItem = menuItems[indexPath.row]
    
    let nextVC =  MenuItemDetailViewController(menuItem: selectedMenuItem)
    
    navigationController?.pushViewController(nextVC, animated: true)
  }
  
  
}
