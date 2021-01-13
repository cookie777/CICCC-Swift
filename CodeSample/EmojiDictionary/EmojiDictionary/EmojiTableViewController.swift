//
//  EmojiTableViewController.swift
//  EmojiDictionary
//
//  Created by Derrick Park on 2021-01-06.
//

import UIKit

class EmojiTableViewController: UITableViewController, AddEditEmojiTVCDelegate {
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
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    tableView.register(EmojiTableViewCell.self, forCellReuseIdentifier: cellId)
    title = "Emoji Dictionary"
    
    // edit button
    navigationItem.leftBarButtonItem = editButtonItem
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewEmoji))
    
    // dynamic row height
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 44.0
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
//    tableView.reloadData()
    tableView.insertRows(at: [IndexPath(row: emojis.count - 1, section: 0)], with: .automatic)
  }
    
  func edit(_ emoji: Emoji) {
    if let indexPath = tableView.indexPathForSelectedRow {
      emojis.remove(at: indexPath.row)
      emojis.insert(emoji, at: indexPath.row)
      tableView.reloadRows(at: [indexPath], with: .automatic)
      tableView.deselectRow(at: indexPath, animated: true)
    }
  }
  
  // MARK: - Table view data source
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return emojis.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let emoji = emojis[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! EmojiTableViewCell
    
    cell.update(with: emoji)
    cell.showsReorderControl = true
    return cell
  }
  
  override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    // update model
    let removedEmoji = emojis.remove(at: sourceIndexPath.row)
    emojis.insert(removedEmoji, at: destinationIndexPath.row)
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //tableView.deselectRow(at: indexPath, animated: true)
    
    let addEditTVC = AddEditEmojiTableViewController(style: .grouped)
    addEditTVC.delegate = self
    addEditTVC.emoji = emojis[indexPath.row]
    let addEditNC = UINavigationController(rootViewController: addEditTVC)
    present(addEditNC, animated: true, completion: nil)
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      emojis.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .automatic)
    } else if editingStyle == .insert {
      // insert + button is tapped
    }
  }
  
  override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    return .delete
  }
}
