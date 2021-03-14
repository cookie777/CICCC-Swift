//
//  CoreDataStack.swift
//  MobileAssessment
//
//  Created by Derrick Park on 2021-03-05.
//

import Foundation
import CoreData

open class CoreDataStack {
  public static let modelName = "MobileAssessment"
  
  public static let model: NSManagedObjectModel = {
    let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd")!
    return NSManagedObjectModel(contentsOf: modelURL)!
  }()
  
  public static let shared = CoreDataStack()
  
  private init() {}
  
  public lazy var viewContext: NSManagedObjectContext = {
    return persistentContainer.viewContext
  }()
  
  public lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: CoreDataStack.modelName, managedObjectModel: CoreDataStack.model)
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()
  
  public func newBackgroundContext() -> NSManagedObjectContext {
    return persistentContainer.newBackgroundContext()
  }
  
  public func saveContext() {
    saveContext(viewContext)
  }
  
  func saveContext(_ context: NSManagedObjectContext) {
    if context != viewContext {
      saveBackgroundContext(context)
      return
    }
    context.perform {
      do {
        try context.save()
      } catch let error as NSError {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
  }
  
  public func saveBackgroundContext(_ context: NSManagedObjectContext) {
    context.perform {
      do {
        try context.save()
      } catch let error as NSError {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
      self.saveContext(self.viewContext)
    }
  }
}
