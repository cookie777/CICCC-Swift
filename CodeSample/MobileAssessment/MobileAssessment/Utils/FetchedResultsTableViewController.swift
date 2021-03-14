//
//  FetchedResultsTableViewController.swift
//  NewsAPI
//
//  Created by Derrick Park on 5/24/20.
//  Copyright © 2020 Derrick Park. All rights reserved.
//

import UIKit
import CoreData

class FetchedResultsTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
  
  public func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.beginUpdates()
  }
  
  public func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
    switch type {
    case .insert: tableView.insertSections([sectionIndex], with: .fade)
    case .delete: tableView.deleteSections([sectionIndex], with: .fade)
    default: break
    }
  }
  
  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    switch type {
    case .insert:
      tableView.insertRows(at: [newIndexPath!], with: .fade)
    case .delete:
      tableView.deleteRows(at: [indexPath!], with: .fade)
    case .update:
      tableView.reloadRows(at: [indexPath!], with: .fade)
    case .move:
      tableView.deleteRows(at: [indexPath!], with: .fade)
      tableView.insertRows(at: [newIndexPath!], with: .fade)
    @unknown default:
      fatalError("FetchedResultsTableViewController -- unknown case found")
    }
  }
  
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.endUpdates()
  }

  @available(iOS 13.0, *)
  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChangeContentWith snapshot: NSDiffableDataSourceSnapshotReference) {
    guard let dataSource = tableView?.dataSource as? UITableViewDiffableDataSource<Int, NSManagedObjectID> else {
      assertionFailure("The data source has not implemented snapshot support while it should")
      return
    }
    // Check whether the table view is already presenting a set of data. If so, we’d like to animate to the new snapshot of data. If there’s no data visible yet, we want the snapshot to be applied as fast as possible without an animation so it’s visible to the user as fast as it can be.
    var snapshot = snapshot as NSDiffableDataSourceSnapshot<Int, NSManagedObjectID>
    let currentSnapshot = dataSource.snapshot() as NSDiffableDataSourceSnapshot<Int, NSManagedObjectID>
    
    let reloadIdentifiers: [NSManagedObjectID] = snapshot.itemIdentifiers.compactMap { itemIdentifier in
      guard let currentIndex = currentSnapshot.indexOfItem(itemIdentifier), let index = snapshot.indexOfItem(itemIdentifier), index == currentIndex else {
        return nil
      }
      guard let existingObject = try? controller.managedObjectContext.existingObject(with: itemIdentifier), existingObject.isUpdated else { return nil }
      return itemIdentifier
    }
    snapshot.reloadItems(reloadIdentifiers)
    
    let shouldAnimate = tableView?.numberOfSections != 0
    dataSource.apply(snapshot as NSDiffableDataSourceSnapshot<Int, NSManagedObjectID>, animatingDifferences: shouldAnimate)
  }
}
