//
//  CategoryTableViewController.swift
//  Restaurant
//
//  Created by Takayuki Yamaguchi on 2021-01-14.
//

import UIKit

class CategoryTableViewController: UITableViewController {
  
  // this is for storing data that you fetch from api
  var categories = [String]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "Restaurant"
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Category")
    
    MenuController.shared.fetchCategories { (result) in
      
      //Please do this task in main thread as async(== when the last task in main finished)
      DispatchQueue.main.async {
        switch result{
        case .success(let categories):
          self.updateUI(with: categories)
        case .failure(let error):
          self.displayError(error,title: "Failed to Fetch Categories")
        }
      }

    }
    
  }
  
  // Update both data and view
  func updateUI(with categories: [String]) {
    self.categories = categories
    self.tableView.reloadData()
  }
  
  // IF failure -> create alert and display it by using UIAlertController.
  func displayError(_ error: Error, title: String){
    let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert )
    alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
    self.present(alert, animated: true)
  }
  
  
}


// MARK: - Table view data source
extension CategoryTableViewController{

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return categories.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Category", for: indexPath)
    let currentCategory = categories[indexPath.row]

    // set content text
    var content = cell.defaultContentConfiguration()
    content.text = currentCategory.capitalized
    cell.contentConfiguration = content
    cell.accessoryType = .disclosureIndicator
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedCategory = categories[indexPath.row]
    let nextVC = MenuTableViewController(category: selectedCategory)
    navigationController?.pushViewController(nextVC, animated: true)
    tableView.deselectRow(at: indexPath, animated: true)
  }
}
