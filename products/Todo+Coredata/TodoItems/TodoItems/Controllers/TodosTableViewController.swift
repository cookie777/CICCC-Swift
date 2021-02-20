//
//  TodosTableViewController.swift
//  TodoItems
//
//  Created by Derrick Park on 2018-10-11.
//  Copyright © 2018 Derrick Park. All rights reserved.
//

import UIKit
import CoreData

class TodosTableViewController: FetchedResultsTableViewController{
  
  @IBOutlet var deleteButton: UIBarButtonItem!

  
  var container: NSPersistentContainer = AppDelegate.persistentContainer
  lazy var fetchedResultsController: NSFetchedResultsController<ManagedTodoItem> = {
    let request: NSFetchRequest<ManagedTodoItem> = ManagedTodoItem.fetchRequest()

//    request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedCaseInsensitiveCompare(_:)))]
    
    let frc = NSFetchedResultsController<ManagedTodoItem>(
      fetchRequest: request,
      managedObjectContext: container.viewContext,
      sectionNameKeyPath: "priority",
      cacheName: nil
    )
    
    
    frc.delegate = self
    return frc
  }()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.leftBarButtonItem = editButtonItem
    tableView.allowsMultipleSelectionDuringEditing = true
    try? fetchedResultsController.performFetch()
  }
  
  override func setEditing(_ editing: Bool, animated: Bool) {
    super.setEditing(editing, animated: animated)
    tableView.setEditing(editing, animated: animated)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "AddItemSegue" {
      if let addItemVC = segue.destination as? AddItemTableViewController {
        addItemVC.delegate = self
      }
    } else if segue.identifier == "EditItemSegue" {
      if let addItemVC = segue.destination as? AddItemTableViewController {
        if let cell = sender as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell){
          addItemVC.itemToEdit = fetchedResultsController.object(at: indexPath)
          addItemVC.delegate = self
        }
      }
    }
  }
  
  @IBAction func deleteTodoItems(_ sender: UIBarButtonItem) {
    // check if there are any items selected
    if var selectedRows = tableView.indexPathsForSelectedRows {
      selectedRows.sort { $0.row > $1.row }
      for indexPath in selectedRows {
        container.viewContext.delete(fetchedResultsController.object(at: indexPath))
      }
      try? container.viewContext.save()
    }
    
  }
  
  // MARK: - TableViewDataSource
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return fetchedResultsController.sections?.count ?? 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let sections = fetchedResultsController.sections, sections.count > 0 {
      return sections[section].numberOfObjects
    } else {
      return 0
    }
  }
  
  // Definition of cells
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // how each cell looks like
    let cell = tableView.dequeueReusableCell(withIdentifier: TodoTableViewCell.identifier, for: indexPath) as! TodoTableViewCell
    let todoItem = fetchedResultsController.object(at: indexPath)

    cell.checkmark.text = todoItem.isCompleted ? "✓" : ""
    cell.todoLabel.text = todoItem.title
    
    return cell
    
  }
  
  // MARK: - TableViewDelegate
  
  // section title
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

      switch fetchedResultsController.sections?[section].name{
      case "0":
        return "High"
      case "1":
        return "Medium"
      case "2":
        return "Low"
      default:
        return nil
      }
    }
  
  // When the cell is selected
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if tableView.isEditing { return }
    // get target ManagedObject from indexPath
    let todoItem = fetchedResultsController.object(at: indexPath)
    // update object
    todoItem.isCompleted.toggle()
    // save it
    try? container.viewContext.save()
    // re-fetch and update fetchedResultsController and related UI
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 70
  }
  
  // Deletion
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

    container.viewContext.delete(fetchedResultsController.object(at: indexPath))
    try? container.viewContext.save()
  }
  
  // If you tap accessoryButton
  override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
    if tableView.isEditing { return }
    performSegue(withIdentifier: "EditItemSegue", sender: tableView.cellForRow(at: indexPath))
  }
  
}


// MARK: - AddEdit Delegate
extension TodosTableViewController: AddItemViewControllerDelegate {
  
  func addItemDidCancel() {
    navigationController?.popViewController(animated: true)
  }
  
  func addItemDidFinishAdding(_ item: ManagedTodoItem) {
    navigationController?.popViewController(animated: true)
    // add new item
    _ = try? ManagedTodoItem.findOrCreateItem(matching: item, in: container.viewContext)
    try? container.viewContext.save()

  }
  
  func addItemDidFinishEditing(_ item: ManagedTodoItem) {
    try? container.viewContext.save()
    navigationController?.popViewController(animated: true)
  }
}


