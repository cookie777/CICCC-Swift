//
//  ManagedSource.swift
//  CDNewsAPI
//
//  Created by Derrick Park on 2021-02-16.
//

import Foundation
import CoreData

class ManagedSource: NSManagedObject {
  class func findOrCreateSource(matching sourceInfo: Article.Source, in context: NSManagedObjectContext) throws -> ManagedSource {
    let request: NSFetchRequest<ManagedSource> = ManagedSource.fetchRequest()
    request.predicate = NSPredicate(format: "name = %@", sourceInfo.name)
    
    do {
      let matches = try context.fetch(request)
      if matches.count > 0 {
        // assert 'sanity': if condition false ... then print message and interrupt program
        assert(matches.count == 1, "ManagedSource.findOrCreateSource -- database inconsistency")
        return matches[0]
      }
    } catch {
      throw error
    }
    // no match, instantiate ManagedSource
    let source = ManagedSource(context: context)
    source.name = sourceInfo.name
    source.firstLetter = String(sourceInfo.name.first!)
    
    return source
  }
}

