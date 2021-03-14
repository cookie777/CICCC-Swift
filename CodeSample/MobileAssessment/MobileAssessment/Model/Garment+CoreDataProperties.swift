//
//  Garment+CoreDataProperties.swift
//  MobileAssessment
//
//  Created by Derrick Park on 2021-03-06.
//
//

import Foundation
import CoreData


extension Garment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Garment> {
        return NSFetchRequest<Garment>(entityName: "Garment")
    }

    @NSManaged public var creationDate: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?

}

extension Garment : Identifiable {

}
