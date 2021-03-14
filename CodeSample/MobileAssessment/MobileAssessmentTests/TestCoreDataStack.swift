//
//  TestCoreDataStack.swift
//  MobileAssessmentTests
//
//  Created by Derrick Park on 2021-03-08.
//
import Foundation
import MobileAssessment
import CoreData

class TestCoreDataStack: CoreDataStack {
  
  override init() {
    super.init()
    let persistentStoreDescription = NSPersistentStoreDescription()
    persistentStoreDescription.type = NSInMemoryStoreType
    
    let container = NSPersistentContainer(
      name: CoreDataStack.modelName,
      managedObjectModel: CoreDataStack.model)
    container.persistentStoreDescriptions = [persistentStoreDescription]
    
    container.loadPersistentStores { _, error in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
    
    persistentContainer = container
  }
}
