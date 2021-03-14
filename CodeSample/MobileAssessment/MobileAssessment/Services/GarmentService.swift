//
//  GarmentService.swift
//  MobileAssessment
//
//  Created by Derrick Park on 2021-03-08.
//

import Foundation
import CoreData

public final class GarmentService {
  let moc: NSManagedObjectContext
  let coreDataStack: CoreDataStack
  
  public init(managedObjectContext: NSManagedObjectContext, coreDataStack: CoreDataStack) {
    self.moc = managedObjectContext
    self.coreDataStack = coreDataStack
  }
}

extension GarmentService {
  @discardableResult
  public func addNewGarment(name: String, creationDate: Date) -> Garment {
    let garment = Garment(context: moc)
    garment.id = UUID()
    garment.creationDate = Date()
    garment.name = name

    coreDataStack.saveContext(moc)
    return garment
  }
  
  public func getGarments() -> [Garment]? {
    let fetchRequest: NSFetchRequest<Garment> = Garment.fetchRequest()
    do {
      let garments = try moc.fetch(fetchRequest)
      return garments
    } catch let error as NSError {
      print("Fetch error: \(error) description: \(error.userInfo)")
    }
    return nil
  }
  
  @discardableResult
  func update(_ garment: Garment) -> Garment {
    coreDataStack.saveContext(coreDataStack.viewContext)
    return garment
  }
}
