//
//  ManagedArticle.swift
//  CDNewsAPI
//
//  Created by Derrick Park on 2021-02-16.
//

import Foundation
import CoreData

class ManagedArticle: NSManagedObject {
  class func findOrCreateArticle(matching articleInfo: Article, with searchText: String, in context: NSManagedObjectContext) throws -> ManagedArticle {
   
    let request: NSFetchRequest<ManagedArticle> = ManagedArticle.fetchRequest()
    request.predicate = NSPredicate(format: "title = %@", articleInfo.title)
    do {
      let matches = try context.fetch(request)
      if matches.count > 0 {
        assert(matches.count == 1, "ManagedArticle.findOrCreateArticle -- database inconsistency")
        let matchedArticle = matches[0]
        matchedArticle.searchText = searchText
        return matchedArticle
      }
    } catch {
      throw error
    }
    
    // no match
    let article = ManagedArticle(context: context)
    article.title = articleInfo.title
    article.author = articleInfo.author
    article.searchText = searchText
    article.url = articleInfo.url
    if let urlStr = articleInfo.urlToImage {
      article.urlToImage = URL(string: urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
    }
    article.source = try? ManagedSource.findOrCreateSource(matching: articleInfo.source, in: context)
    return article
  }
  
}
