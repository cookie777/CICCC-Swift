//
//  NewsTableViewController.swift
//  CDNewsAPI
//
//  Created by Derrick Park on 2021-02-16.
//

import UIKit
import SafariServices
import CoreData

class NewsTableViewController: UITableViewController {
  
  private lazy var searchController: UISearchController = {
    let sc = UISearchController(searchResultsController: nil)
    sc.searchBar.delegate = self
    sc.searchBar.placeholder = "Search News"
    definesPresentationContext = true
    return sc
  }()
  
  private var container: NSPersistentContainer? = AppDelegate.persistentContainer
  
  private var articles: [[Article]] = [] {
    didSet {
      navigationItem.rightBarButtonItem?.isEnabled = articles.count > 0
    }
  }
  
  private var fetchedArticles = [Article]()
  
  var searchText: String? {
    didSet {
      navigationItem.searchController?.searchBar.searchTextField.resignFirstResponder()
      articles.removeAll()
      fetchedArticles.removeAll()
      tableView.reloadData()
      searchForArticles()
      title = searchText
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Breaking News"
    navigationController?.navigationBar.prefersLargeTitles = true
    
    /// table view
    tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.reuseIdentifier)
    tableView.estimatedRowHeight = tableView.rowHeight
    tableView.rowHeight = UITableView.automaticDimension
    
    /// refresh control
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
    tableView.refreshControl = refreshControl
    
    /// search controller
    navigationItem.searchController = searchController
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(sortBySources(_:)))
    navigationItem.rightBarButtonItem?.isEnabled = false
  }
  
  @objc func refresh(_ sender: UIRefreshControl) {
    searchForArticles()
  }
  
  @objc func sortBySources(_ sender: UIBarButtonItem) {
    let sourcesTVC = SourcesTableViewController()
    sourcesTVC.searchText = self.searchText
    self.navigationController?.pushViewController(sourcesTVC, animated: true)
  }
  
  private func viewInSafari(with url: URL) {
    let safariVC = SFSafariViewController(url: url)
    present(safariVC, animated: true, completion: nil)
  }
  
  private func searchForArticles() {
    guard let searchText = searchText else {
      refreshControl?.endRefreshing()
      return
    }
    NewsAPIRequest.shared.getTopHeadlines(with: searchText) { [weak self] (articles) in
      if let articles = articles?.articles {
        DispatchQueue.main.async {
          if let diffs = self?.diffWithTheMostRecentArticles(articles) {
            self?.articles.insert(diffs, at: 0)
            self?.fetchedArticles.append(contentsOf: diffs)
            self?.tableView.insertSections([0], with: .automatic)
            self?.updateDatebase(with: articles, for: searchText)
          }
          self?.refreshControl?.endRefreshing()
        }
      }
    }
  }
  
  private func updateDatebase(with articles: [Article], for searchText: String) {
    container?.performBackgroundTask { (context) in
      // background
      for article in articles {
        _ = try? ManagedArticle.findOrCreateArticle(matching: article, with: searchText, in: context)
      }
      try? context.save()
      print("done loading database...")
      self.printDatabaseStatistics()
    }
  }
  
  private func printDatabaseStatistics() {
    if let context = container?.viewContext { // viewContext == main context on main thread
      context.perform { // better be sure this is executed on the main thread
        if Thread.isMainThread {
          print("on main thread")
        } else {
          print("off main thread")
        }
        if let articleCount = (try? context.fetch(ManagedArticle.fetchRequest()))?.count {
          print("\(articleCount) articles")
        }
        // a better way to count ... context.count(for: )
        if let sourceCount = try? context.count(for: ManagedSource.fetchRequest()) {
          print("\(sourceCount) sources")
        }
      }
    }
  }
  
  private func diffWithTheMostRecentArticles(_ articles: [Article]) -> [Article] {
    if fetchedArticles.count == 0 {
      return articles
    }
    return fetchedArticles.difference(from: articles)
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return articles.count
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return articles[section].count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.reuseIdentifier, for: indexPath) as! NewsCell
    let article = articles[indexPath.section][indexPath.row]
    cell.article = article
    cell.viewMorePressed = { [weak self] (url) in
      self?.viewInSafari(with: url)
    }
    return cell
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm:ss E, d MMM y"
    return "\(searchText ?? "") \(articles.count - section) - \(formatter.string(from: Date()))"
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}

extension NewsTableViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    if let searchText = searchBar.text {
      self.searchText = searchText
    }
  }
}
