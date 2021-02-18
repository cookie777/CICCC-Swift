//
//  SourcesTableViewController.swift
//  CDNewsAPI
//
//  Created by Derrick Park on 2021-02-17.
//

import UIKit
import CoreData

class SourcesTableViewController: FetchedResultsTableViewController {
  
  var searchText: String! {
    didSet {
      updateUI()
    }
  }
  
  var container: NSPersistentContainer = AppDelegate.persistentContainer
  
  lazy var fetchedResultsController: NSFetchedResultsController<ManagedSource> = {
    let request: NSFetchRequest<ManagedSource> = ManagedSource.fetchRequest()
    request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true, selector: #selector(NSString.localizedCaseInsensitiveCompare(_:)))]
    request.predicate = NSPredicate(format: "ANY articles.searchText CONTAINS[c] %@", searchText)
    
    let frc = NSFetchedResultsController<ManagedSource>(
      fetchRequest: request,
      managedObjectContext: container.viewContext,
      sectionNameKeyPath: "firstLetter",
      cacheName: nil)
    frc.delegate = self
    // It's going to permanently cache the results (store on disk in some internal format)
    // Be sure that any cacheName you use is always associated with exactly the same request
    // You'll have to invalidate the cache if you change anything about the request. (There's an API for it)
    // It's okay to specify nil for the cacheName (no caching of fetch results)
    return frc
  }()
  
  func updateUI() {
    try? fetchedResultsController.performFetch()
    tableView.reloadData()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Sources for \(searchText!)"
    tableView.register(SourceCell.self, forCellReuseIdentifier: SourceCell.reuseIdentifier)
  }
  
  private func numberOfArticles(by source: ManagedSource) -> Int {
    let request: NSFetchRequest<ManagedArticle> = ManagedArticle.fetchRequest()
    request.predicate = NSPredicate(format: "searchText CONTAINS[c] %@ AND source == %@", searchText, source)
    return (try? source.managedObjectContext!.count(for: request)) ?? 0
  }
  
  // MARK: - Table view data source
  
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
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: SourceCell.reuseIdentifier, for: indexPath) as! SourceCell
    let source = fetchedResultsController.object(at: indexPath)
    cell.textLabel?.text = source.name
    let count = numberOfArticles(by: source)
    cell.detailTextLabel?.text = "\(count) article\((count == 1) ? "" : "s")"
    
    return cell
  }

  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if let sections = fetchedResultsController.sections, sections.count > 0 {
      return sections[section].name
    } else {
      return nil
    }
  }
  
  override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
    return fetchedResultsController.sectionIndexTitles
  }
  
  override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
    return fetchedResultsController.section(forSectionIndexTitle: title, at: index)
  }
}
