//
//  AddGarmentTableViewController.swift
//  MobileAssessment
//
//  Created by Derrick Park on 2021-03-05.
//

import UIKit

class AddGarmentTableViewController: UITableViewController {
  
  let cell = AddGarmentTableViewCell()
  var garmentService: GarmentService?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "ADD"
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveNewGarment(_:)))
    tableView.rowHeight = 44
  }
  
  @objc func saveNewGarment(_ sender: UIBarButtonItem) {
    guard let name = cell.textField.text, !name.isEmpty else {
      let alert = UIAlertController(title: "Error", message: "You must enter the name.", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil))
      self.present(alert, animated: true, completion: nil)
      return
    }
    garmentService?.addNewGarment(name: name, creationDate: Date())
    dismiss(animated: true, completion: nil)
  }
  
  // MARK: - Table view data source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return cell
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "Garment Name:"
  }
}
