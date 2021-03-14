//
//  MobileAssessmentTests.swift
//  MobileAssessmentTests
//
//  Created by Derrick Park on 2021-03-05.
//

import XCTest
@testable import MobileAssessment
import CoreData

class MobileAssessmentTests: XCTestCase {
  var coreDataStack: CoreDataStack!
  
  override func setUp() {
    super.setUp()
    coreDataStack = TestCoreDataStack()
  }
  
  override func tearDown() {
    super.tearDown()
    coreDataStack = nil
  }
  
  func testCreateGarment() {
    let garment = Garment(context: coreDataStack.viewContext)
    garment.id = UUID()
    garment.name = "Yoga Pants"
    garment.creationDate = Date()
    coreDataStack.saveContext(coreDataStack.viewContext)
    
    XCTAssertNotNil(garment, "Report should not be nil")
    XCTAssertNotNil(garment.id, "id should not be nil")
    XCTAssertTrue(garment.name == "Yoga Pants")
    XCTAssertNotNil(garment.creationDate, "creationDate should not be nil")
  }
  
  func testBackgroundContextIsSavedAfterAddingGarment() {
    let backgroundContext = coreDataStack.newBackgroundContext()
    
    expectation(forNotification: .NSManagedObjectContextDidSave, object: backgroundContext) { (_) -> Bool in
      return true
    }
    
    backgroundContext.perform {
      let garment = Garment(context: self.coreDataStack.viewContext)
      garment.id = UUID()
      garment.name = "Yoga Pants"
      garment.creationDate = Date()
      self.coreDataStack.saveContext(backgroundContext)
      
      XCTAssertNotNil(garment)
    }
    
    waitForExpectations(timeout: 2.0) { (error) in
      XCTAssertNil(error, "Save did not occur")
    }
  }

  func testGetGarment() throws {
    let garment = Garment(context: coreDataStack.viewContext)
    garment.id = UUID()
    garment.name = "Yoga Pants"
    garment.creationDate = Date()
    coreDataStack.saveContext(coreDataStack.viewContext)
    
    let fetchRequest: NSFetchRequest<Garment> = Garment.fetchRequest()
    let fetchedGarments = try! coreDataStack.viewContext.fetch(fetchRequest)
    
    XCTAssertNotNil(fetchedGarments)
    XCTAssertTrue(fetchedGarments.count == 1)
    XCTAssertTrue(garment.id == fetchedGarments.first?.id)
  }
  
  func testUpdateGarment() throws {
    let garment = Garment(context: coreDataStack.viewContext)
    garment.id = UUID()
    garment.name = "Yoga Pants"
    garment.creationDate = Date()
    coreDataStack.saveContext(coreDataStack.viewContext)
    
    @discardableResult
    func update(_ garment: Garment) -> Garment {
      coreDataStack.saveContext(coreDataStack.viewContext)
      return garment
    }
    
    garment.name = "Yoga T-Shirt"
    let updatedGarment = update(garment)
    
    coreDataStack.saveContext(coreDataStack.viewContext)
    XCTAssertTrue(garment.id == updatedGarment.id)
    XCTAssertTrue(updatedGarment.name == "Yoga T-Shirt")
  }
  
  func testDeleteGarment() {
    let garment = Garment(context: coreDataStack.viewContext)
    garment.id = UUID()
    garment.name = "Yoga Pants"
    garment.creationDate = Date()
    coreDataStack.saveContext(coreDataStack.viewContext)
    
    let fetchRequest: NSFetchRequest<Garment> = Garment.fetchRequest()
    var fetchedGarments = try! coreDataStack.viewContext.fetch(fetchRequest)
    XCTAssertNotNil(fetchedGarments)
    XCTAssertTrue(fetchedGarments.count == 1)
    XCTAssertTrue(garment.id == fetchedGarments.first?.id)
    
    coreDataStack.viewContext.delete(garment)
    coreDataStack.saveContext(coreDataStack.viewContext)
    
    fetchedGarments = try! coreDataStack.viewContext.fetch(fetchRequest)
    XCTAssertTrue(fetchedGarments.isEmpty)
  }
}
