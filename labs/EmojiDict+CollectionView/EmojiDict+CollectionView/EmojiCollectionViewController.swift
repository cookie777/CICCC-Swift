//
//  EmojiTableViewController.swift
//  EmojiDictionary
//
//  Created by Derrick Park on 2021-01-06.
//

import UIKit

class EmojiCollectionViewController: UICollectionViewController, AddEditEmojiCVCDelegate {
  let cellId = "EmojiCell"
  
  var emojis: [Emoji] = [
    Emoji(symbol: "😀", name: "Grinning Face", description: "A typical smiley face.", usage: "happiness"),
    Emoji(symbol: "😕", name: "Confused Face", description: "A confused, puzzled face.", usage: "unsure what to think; displeasure"),
    Emoji(symbol: "😍", name: "Heart Eyes", description: "A smiley face with hearts for eyes.", usage: "love of something; attractive"),
    Emoji(symbol: "🧑‍💻", name: "Developer", description: "A person working on a MacBook (probably using Xcode to write iOS apps in Swift).", usage: "apps, software, programming"),
    Emoji(symbol: "🐢", name: "Turtle", description: "A cute turtle.", usage: "Something slow"),
    Emoji(symbol: "🐘", name: "Elephant", description: "A gray elephant.", usage: "good memory"),
    Emoji(symbol: "🍝", name: "Spaghetti", description: "A plate of spaghetti.", usage: "spaghetti"),
    Emoji(symbol: "🎲", name: "Die", description: "A single die.", usage: "taking a risk, chance; game"),
    Emoji(symbol: "⛺️", name: "Tent", description: "A small tent.", usage: "camping"),
    Emoji(symbol: "📚", name: "Stack of Books", description: "Three colored books stacked on each other.", usage: "homework, studying"),
    Emoji(symbol: "💔", name: "Broken Heart", description: "A red, broken heart.", usage: "extreme sadness"),
    Emoji(symbol: "💤", name: "Snore", description: "Three blue \'z\'s.", usage: "tired, sleepiness"),
    Emoji(symbol: "🏁", name: "Checkered Flag", description: "A black-and-white checkered flag.", usage: "completion")
  ]{
    didSet{
      emojisFiltered = self.emojis
    }
  }
  
  lazy var emojisFiltered = self.emojis
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //    view.backgroundColor = .blue
    collectionView.backgroundColor = .systemBackground
    collectionView.setCollectionViewLayout(setCollectionViewLayout(), animated:  false)
    collectionView.register(EmojiCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    title = "Emoji Dictionary"
    
    // edit button
    navigationItem.leftBarButtonItem = editButtonItem
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewEmoji))
    
    // Searching bar. Details are defined in extension.
    let sc = UISearchController()
    navigationItem.searchController = sc
    sc.searchResultsUpdater = self
    sc.obscuresBackgroundDuringPresentation = false // don't show gray bg when searching.
    
    
    
    
  }
  
  
  
  func setCollectionViewLayout() -> UICollectionViewLayout{
    // Define item
    // Set item size as == group size
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
    
    // Define group
    // Set group size
    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .absolute(96)
    )
    // Set group with how to contain items
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
    group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
    
    // Define section
    let section = NSCollectionLayoutSection(group: group)
    section.interGroupSpacing = 16
    //    section.orthogonalScrollingBehavior = .continuous
    
    return UICollectionViewCompositionalLayout(section: section)
    
    
  }
  
  private func navigateToAddEditTVC() {
    let addEditTVC = AddEditEmojiTableViewController(style: .grouped)
    addEditTVC.delegate = self
    let addEditNC = UINavigationController(rootViewController: addEditTVC)
    present(addEditNC, animated: true, completion: nil)
  }
  
  @objc func addNewEmoji() {
    // present modally (AddEditEmojiTableViewController)
    navigateToAddEditTVC()
  }
  
  func add(_ emoji: Emoji) {
    emojis.append(emoji)
    //    collectionView.reloadData()
    collectionView.insertItems(at: [IndexPath(item: emojis.count-1, section: 0)])
  }
  
  func edit(_ emoji: Emoji) {
    
    if let indexPath = collectionView.indexPathsForSelectedItems?.first {
      emojis.remove(at: indexPath.item)
      emojis.insert(emoji, at: indexPath.item)
      collectionView.reloadItems(at: [indexPath])
      collectionView.deselectItem(at: indexPath, animated: true)
    }
  }
  
  // MARK: - Table view data source
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    1
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    emojisFiltered.count
  }
  
  // Set cell
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let emoji = emojisFiltered[indexPath.item]
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! EmojiCollectionViewCell
    
    cell.update(with: emoji)
    return cell
  }
  
  
  
  // if cell is selected
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //tableView.deselectRow(at: indexPath, animated: true)
    
    let addEditTVC = AddEditEmojiTableViewController(style: .grouped)
    addEditTVC.delegate = self
    addEditTVC.emoji = emojis[indexPath.item]
    let addEditNC = UINavigationController(rootViewController: addEditTVC)
    present(addEditNC, animated: true, completion: nil)
  }
  
  //https://medium.com/ivymobility-developers/context-menus-in-ios-226727a8aa88
  override func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
    
    let config = UIContextMenuConfiguration(
      identifier: nil,
      previewProvider: nil,
      actionProvider:
        { (menuElemets) -> UIMenu? in
          let delete = UIAction(
            title: "🗑",
            handler:
              { [weak self] action in
                self?.deleteEmoji(at: indexPath)
              }
          )
          
          let delete2 = UIAction(
            title: "🗑",
            handler:
              { [weak self] action in
                self?.deleteEmoji(at: indexPath)
              }
          )
          
          let menu = UIMenu( title: "AAA", image: nil, identifier: nil, options: [.displayInline], children: [delete, delete2])
          return menu
        }
    )
    
    return config
  }
  
  func deleteEmoji(at indexPath: IndexPath){
    emojis.remove(at: indexPath.item)
    collectionView.deleteItems(at: [indexPath])
  }
  
  
  
}
extension EmojiCollectionViewController: UISearchResultsUpdating{
  
  // Delegate method which is invoked when search bar text is changed.
  func updateSearchResults(for searchController: UISearchController) {
    
    if let text = searchController.searchBar.text, !text.isEmpty  {
      emojisFiltered = emojis.filter { $0.name.localizedCaseInsensitiveContains(text)}
    } else{
      emojisFiltered = emojis // This is need for "cancel action"
    }
    print("update")
    print(emojisFiltered)
    collectionView.reloadData()
    
  }
  
  
  
  
  // This will show search bar without scrolling by default
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    UIView.performWithoutAnimation {
      navigationItem.searchController?.isActive = true
      navigationItem.searchController?.isActive = false
    }
  }
  
}



