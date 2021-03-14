//
//  GarmentTableViewController.swift
//  MobileAssessment
//
//  Created by Derrick Park on 2021-03-05.
//

import UIKit
import CoreData

class GarmentTableViewController: FetchedResultsTableViewController {
  typealias DataSource = UITableViewDiffableDataSource<Int, NSManagedObjectID>
  
  private let coreDataStack = CoreDataStack.shared
  private lazy var garmentService = GarmentService(managedObjectContext: coreDataStack.viewContext, coreDataStack: coreDataStack)
  
  private let sortDescriptors = [
    NSSortDescriptor(key: #keyPath(Garment.name), ascending: true),
    NSSortDescriptor(key: #keyPath(Garment.creationDate), ascending: true)
  ]
  
  var dataSource: DataSource!
  
  enum Segment: String {
    case alpha = "Alpha"
    case creationTime = "Creation Time"
  }
  
  private let segmentedControl = UISegmentedControl(items: [Segment.alpha.rawValue, Segment.creationTime.rawValue])
  
  private lazy var fetchedResultsController: NSFetchedResultsController<Garment> = {
    let request: NSFetchRequest<Garment> = Garment.fetchRequest()
    request.sortDescriptors = []
    let frc = NSFetchedResultsController<Garment>(
      fetchRequest: request,
      managedObjectContext: coreDataStack.viewContext,
      sectionNameKeyPath: nil,
      cacheName: nil)
    frc.delegate = self
    return frc
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewGarment(_:)))
    navigationItem.titleView = segmentedControl
    
    /// setup segmentedControl
    segmentedControl.addTarget(self, action: #selector(rearrangeBy(_:)), for: .valueChanged)
    
    /// setup tableView cell
    tableView.register(GarmentTableViewCell.self, forCellReuseIdentifier: GarmentTableViewCell.reuseIdentifier)
    
    /// setup diffableDataSource
    configureDiffableDataSource()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    UIView.performWithoutAnimation {
      do {
        try fetchedResultsController.performFetch()
      } catch let error as NSError {
        print("Fetching error: \(error), \(error.userInfo)")
      }
    }
  }
  
  @objc func rearrangeBy(_ sender: UISegmentedControl) {
    fetchedResultsController.fetchRequest.sortDescriptors = [sortDescriptors[sender.selectedSegmentIndex]]
    try? fetchedResultsController.performFetch()
  }
  
  @objc func addNewGarment(_ sender: UIBarButtonItem) {
    let addGarmentTVC = AddGarmentTableViewController(style: .grouped)
    addGarmentTVC.garmentService = garmentService
    present(UINavigationController(rootViewController: addGarmentTVC), animated: true, completion: nil)
  }
  
  // MARK: - Table view data source
  private func configureDiffableDataSource() {
    dataSource = DataSource(tableView: tableView, cellProvider: { [unowned self] (tableView, indexPath, managedObjectID) -> UITableViewCell? in
      let cell = tableView.dequeueReusableCell(withIdentifier: GarmentTableViewCell.reuseIdentifier, for: indexPath) as! GarmentTableViewCell
      if let garment = try? self.fetchedResultsController.managedObjectContext.existingObject(with: managedObjectID) as? Garment {
        cell.configure(with: garment)
      }
      return cell
    })
  }
}
