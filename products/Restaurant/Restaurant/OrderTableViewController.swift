//
//  OrderTableViewController.swift
//  Restaurant
//
//  Created by Takayuki Yamaguchi on 2021-01-14.
//

import UIKit

class OrderTableViewController: UITableViewController {
  
  var minutesToPrepareOrder = 0
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Order")
    
    // add observer. If order is changed(add, delete) -> get notification
    // and then updateUI == add item to cell
    NotificationCenter.default.addObserver(
      tableView!,
      selector: #selector(UITableView.reloadData), // can not use func, why ?
      name: MenuController.orderUpdatedNotification,
      object: nil
    )
    
    // set title
    navigationItem.title = "Order"
    // add edit button
    navigationItem.leftBarButtonItem = editButtonItem
    // add submit button
    navigationItem.rightBarButtonItem =  UIBarButtonItem(title: "Submit", style: .done, target: self, action: #selector(submitButtonPressed))
    
  }
  
  @objc func submitButtonPressed(){
    
    // Calculate total price from ordered menu
    let orderTotal = MenuController.shared.order.menuItems.reduce(0){$0 + $1.price}
    // convert price into text
    let formattedTotal = MenuItem.priceFormatter.string(from: NSNumber(value: orderTotal)) ?? "\(orderTotal)"
    
    /*
     Create alter view.
     Inside the alter, if we tap "submit" it will call postOder,
     which post order to server and get prepTime, and them move to next VC
     */
    let alertController = UIAlertController(title: "Confirm Order", message: "You are about to submit your order with a total of \(formattedTotal)", preferredStyle: .actionSheet)
    alertController.addAction(UIAlertAction(title: "Submit", style: .default, handler: {_ in
      self.postOrder()
    }))
    alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    
    // present alter view
    present(alertController, animated: true, completion: nil)
    
  }
  
  
  // Here we post our order to server, and get the prepTime as result.
  // If success -> move(present) to next VC
  func postOrder(){
    let menuIds = MenuController.shared.order.menuItems.map{$0.id}
    MenuController.shared.submitOrder(forMenuIDs: menuIds) { (result) in
      DispatchQueue.main.async {
        switch result{
        
        case .success(let minutesToPrepare):
          
          
          // present next VC
          let nextVC = OrderConfirmationViewController(minutesToPrepare: minutesToPrepare)
          self.present(nextVC, animated: true, completion: nil)
          
        case .failure(let error):
          // display alter vc
          Alert.displayError(target: self, error, title: "Order Submission Failed")
        }
      }
    }
  }
  
}


// MARK: - Table view data source
extension OrderTableViewController{
  
  // num of sections
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  // num of rows
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return MenuController.shared.order.menuItems.count
  }
  
  // cell definition
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Order", for: indexPath)
    
    //set cell
    var content = cell.defaultContentConfiguration()
    let menuItem = MenuController.shared.order.menuItems[indexPath.row]
    content.text = menuItem.name
    content.prefersSideBySideTextAndSecondaryText = true
    content.secondaryText = MenuItem.priceFormatter.string(from: NSNumber(value: menuItem.price))
    cell.contentConfiguration = content
    
    return cell
  }
  
  // setting for editing cell
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    true
  }
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    
    if editingStyle == .delete{
      MenuController.shared.order.menuItems.remove(at: indexPath.row)
    }
  }
}
