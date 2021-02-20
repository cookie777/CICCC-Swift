//
//  AddItemTableViewController.swift
//  TodoItems
//
//  Created by Derrick Park on 2018-10-11.
//  Copyright © 2018 Derrick Park. All rights reserved.
//

import UIKit
import CoreData

protocol AddItemViewControllerDelegate: class {
  func addItemDidCancel()
  func addItemDidFinishAdding(_ item: ManagedTodoItem)
  func addItemDidFinishEditing(_ item: ManagedTodoItem)
}

class AddItemTableViewController: UITableViewController {
  
  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var cancelBarButton: UIBarButtonItem!
  @IBOutlet weak var doneBarButton: UIBarButtonItem!
  weak var delegate: AddItemViewControllerDelegate?
  weak var itemToEdit: ManagedTodoItem?
  
  @IBAction func cancel(_ sender: UIBarButtonItem) {
    delegate?.addItemDidCancel()
  }
  
  @IBAction func done(_ sender: UIBarButtonItem) {
    if let item = itemToEdit, let text = textField.text {
      item.title = text
      item.priority = Int16(segmentController.selectedSegmentIndex)
      delegate?.addItemDidFinishEditing(item)
    } else {
      if let text = textField.text {
        let newItem = ManagedTodoItem(context: AppDelegate.persistentContainer.viewContext)
        newItem.title = text
        newItem.isCompleted = false
        newItem.priority = Int16(segmentController.selectedSegmentIndex)
        delegate?.addItemDidFinishAdding(newItem)
      }
    }
  }
  
  var segmentController : UISegmentedControl = {
    let s = UISegmentedControl()
    s.translatesAutoresizingMaskIntoConstraints = false
    s.insertSegment(withTitle: "High", at: 0, animated: false)
    s.insertSegment(withTitle: "Medium", at: 1, animated: false)
    s.insertSegment(withTitle: "Low", at: 2, animated: false)
    s.selectedSegmentIndex = 1
    return s
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.largeTitleDisplayMode = .never
    if let item = itemToEdit {
      title = "Edit Todo Item"
      textField.text = item.title
      doneBarButton.isEnabled = true
      segmentController.selectedSegmentIndex = Int(item.priority)
    }
    tableView.tableHeaderView = segmentController
    tableView.addSubview(segmentController)
    segmentController.anchors(
      topAnchor: nil,
      leadingAnchor: tableView.leadingAnchor,
      trailingAnchor: tableView.trailingAnchor,
      bottomAnchor: nil
    )
    segmentController.widthAnchor.constraint(equalTo: tableView.widthAnchor, multiplier: 1.0).isActive = true
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    textField.becomeFirstResponder()
  }
  
  override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    return nil
  }
  
}

extension AddItemTableViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    guard let oldText = textField.text, let stringRange = Range(range, in: oldText) else { return false }
    let newText = oldText.replacingCharacters(in: stringRange, with: string)
    doneBarButton.isEnabled = newText.isEmpty ? false : true
    return true
  }
  
}
