//
//  ManagedTodoItem.swift
//  TodoItems
//
//  Created by Takayuki Yamaguchi on 2021-02-18.
//  Copyright © 2021 Derrick Park. All rights reserved.
//

import Foundation
import CoreData

class ManagedTodoItem: NSManagedObject{
  class func findOrCreateItem(matching sourceInfo: ManagedTodoItem, in context: NSManagedObjectContext) throws -> ManagedTodoItem {
    let request: NSFetchRequest<ManagedTodoItem> = ManagedTodoItem.fetchRequest()
    request.predicate = NSPredicate(format: "objectID = %@", sourceInfo.objectID)
    
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
    let source = ManagedTodoItem(context: context)
    source.title = sourceInfo.title
    source.isCompleted = sourceInfo.isCompleted
    source.priority = sourceInfo.priority
    source.todoDescription = sourceInfo.todoDescription
    
    return source
  }
  
}
